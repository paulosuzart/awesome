type 'v bucket = Nil | Cons of int * 'v * 'v bucket

type 'v t = {
  mutable rehash : int;
  mutable buckets : 'v bucket array;
  mutable length : int;
}

let[@tail_mod_cons] rec remove_first removed k' = function
  | Nil -> Nil
  | Cons (k, v, kvs) ->
      if k == k' then begin
        removed := true;
        kvs
      end
      else Cons (k, v, remove_first removed k' kvs)

let[@inline] remove_first removed k' = function
  | Nil -> Nil
  | Cons (k, v, kvs) ->
      if k == k' then begin
        removed := true;
        kvs
      end
      else Cons (k, v, remove_first removed k' kvs)

let rec find k' = function
  | Nil -> raise_notrace Not_found
  | Cons (k, v, kvs) -> if k == k' then v else find k' kvs

let[@tail_mod_cons] rec filter bit chk = function
  | Nil -> Nil
  | Cons (k, v, kvs) ->
      if Mix.int k land bit = chk then Cons (k, v, filter bit chk kvs)
      else filter bit chk kvs

let[@inline] filter bit chk = function
  | Nil -> Nil
  | Cons (k, _, Nil) as kvs -> if Mix.int k land bit = chk then kvs else Nil
  | Cons (k, v, kvs) ->
      if Mix.int k land bit = chk then Cons (k, v, filter bit chk kvs)
      else filter bit chk kvs

let[@tail_mod_cons] rec append kvs tail =
  match kvs with Nil -> tail | Cons (k, v, kvs) -> Cons (k, v, append kvs tail)

let[@inline] append kvs tail =
  match kvs with Nil -> tail | Cons (k, v, kvs) -> Cons (k, v, append kvs tail)

let min_buckets = 4
and max_buckets_div_2 = (Sys.max_array_length + 1) asr 1

let create () = { rehash = 0; buckets = Array.make min_buckets Nil; length = 0 }
let length t = t.length

let find t k' =
  let h = Mix.int k' in
  let buckets = t.buckets in
  let n = Array.length buckets in
  let i = h land (n - 1) in
  find k' (Array.unsafe_get buckets i)

(* Below we use [@poll error] and [@inline never] to ensure that there are no
   safe-points where thread switches might occur during critical sections. *)

let[@poll error] [@inline never] update_buckets_atomically t old_buckets
    new_buckets =
  t.buckets == old_buckets
  && begin
       t.buckets <- new_buckets;
       t.rehash <- 0;
       true
     end

let rec maybe_rehash t =
  let old_buckets = t.buckets in
  let new_n = t.rehash in
  if new_n <> 0 then
    let old_n = Array.length old_buckets in
    let new_buckets = Array.make new_n Nil in
    if old_n * 2 = new_n then
      let new_bit = new_n lsr 1 in
      let rec loop i =
        if t.buckets == old_buckets then
          if old_n <= i then begin
            if not (update_buckets_atomically t old_buckets new_buckets) then
              maybe_rehash t
          end
          else begin
            let kvs = Array.unsafe_get old_buckets i in
            Array.unsafe_set new_buckets i (filter new_bit 0 kvs);
            Array.unsafe_set new_buckets (i lor new_bit)
              (filter new_bit new_bit kvs);
            loop (i + 1)
          end
        else maybe_rehash t
      in
      loop 0
    else if old_n = new_n * 2 then
      let old_bit = old_n lsr 1 in
      let rec loop i =
        if t.buckets == old_buckets then
          if new_n <= i then begin
            if not (update_buckets_atomically t old_buckets new_buckets) then
              maybe_rehash t
          end
          else begin
            Array.unsafe_set new_buckets i
              (append
                 (Array.unsafe_get old_buckets (i + old_bit))
                 (Array.unsafe_get old_buckets i));
            loop (i + 1)
          end
        else maybe_rehash t
      in
      loop 0
    else maybe_rehash t

let[@inline] maybe_rehash t = if t.rehash <> 0 then maybe_rehash t

let[@poll error] [@inline never] add_atomically t buckets n i before after =
  t.rehash = 0 && buckets == t.buckets
  && before == Array.unsafe_get buckets i
  && begin
       Array.unsafe_set buckets i after;
       let length = t.length + 1 in
       t.length <- length;
       if n < length && n < max_buckets_div_2 then t.rehash <- n * 2;
       true
     end

let rec add t k' v' =
  let h = Mix.int k' in
  maybe_rehash t;
  let buckets = t.buckets in
  let n = Array.length buckets in
  let i = h land (n - 1) in
  let before = Array.unsafe_get buckets i in
  let after = Cons (k', v', before) in
  if not (add_atomically t buckets n i before after) then add t k' v'

let[@poll error] [@inline never] remove_atomically t buckets n i before after
    removed =
  t.rehash = 0 && buckets == t.buckets
  && before == Array.unsafe_get buckets i
  && ((not !removed)
     || begin
          Array.unsafe_set buckets i after;
          let length = t.length - 1 in
          t.length <- length;
          if length * 4 < n && min_buckets < n then t.rehash <- n asr 1;
          true
        end)

let rec remove t k' =
  let h = Mix.int k' in
  let removed = ref false in
  maybe_rehash t;
  let buckets = t.buckets in
  let n = Array.length buckets in
  let i = h land (n - 1) in
  let before = Array.unsafe_get buckets i in
  let after = remove_first removed k' before in
  if not (remove_atomically t buckets n i before after removed) then remove t k'
