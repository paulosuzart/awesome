
# 1 "type.ml"
(** {3 Type of the JSON tree} *)

type t =
    [
    | `Null
    | `Bool of bool
    
# 8 "type.ml"
    | `Int of int
    
# 11 "type.ml"
    | `Intlit of string
    
# 14 "type.ml"
    | `Float of float
    
# 17 "type.ml"
    | `Floatlit of string
    
# 20 "type.ml"
    | `String of string
    
# 23 "type.ml"
    | `Stringlit of string
    
# 25 "type.ml"
    | `Assoc of (string * t) list
    | `List of t list
    
# 28 "type.ml"
    | `Tuple of t list
    
# 31 "type.ml"
    | `Variant of (string * t option)
    
# 33 "type.ml"
    ]
(**
All possible cases defined in Yojson:
- `Null: JSON null
- `Bool of bool: JSON boolean
- `Int of int: JSON number without decimal point or exponent.
- `Intlit of string: JSON number without decimal point or exponent,
	    preserved as a string.
- `Float of float: JSON number, Infinity, -Infinity or NaN.
- `Floatlit of string: JSON number, Infinity, -Infinity or NaN,
	    preserved as a string.
- `String of string: JSON string. Bytes in the range 128-255 are preserved
	    as-is without encoding validation for both reading
	    and writing.
- `Stringlit of string: JSON string literal including the double quotes.
- `Assoc of (string * json) list: JSON object.
- `List of json list: JSON array.
- `Tuple of json list: Tuple (non-standard extension of JSON).
	    Syntax: [("abc", 123)].
- `Variant of (string * json option): Variant (non-standard extension of JSON).
	    Syntax: [<"Foo">] or [<"Bar":123>].
*)

(*
  Note to adventurers: ocamldoc does not support inline comments
  on each polymorphic variant, and cppo doesn't allow to concatenate
  comments, so it would be complicated to document only the
  cases that are preserved by cppo in the type definition.
*)

# 1 "write.ml"
let hex n =
  Char.chr (
    if n < 10 then n + 48
    else n + 87
  )

let write_special src start stop ob str =
  Buffer.add_substring ob src !start (stop - !start);
  Buffer.add_string ob str;
  start := stop + 1

let write_control_char src start stop ob c =
  Buffer.add_substring ob src !start (stop - !start);
  Buffer.add_string ob "\\u00";
  Buffer.add_char ob (hex (Char.code c lsr 4));
  Buffer.add_char ob (hex (Char.code c land 0xf));
  start := stop + 1

let finish_string src start ob =
  try
    Buffer.add_substring ob src !start (String.length src - !start)
  with exc ->
    Printf.eprintf "src=%S start=%i len=%i\n%!"
      src !start (String.length src - !start);
    raise exc

let write_string_body ob s =
  let start = ref 0 in
  for i = 0 to String.length s - 1 do
    match s.[i] with
        '"' -> write_special s start i ob "\\\""
      | '\\' -> write_special s start i ob "\\\\"
      | '\b' -> write_special s start i ob "\\b"
      | '\012' -> write_special s start i ob "\\f"
      | '\n' -> write_special s start i ob "\\n"
      | '\r' -> write_special s start i ob "\\r"
      | '\t' -> write_special s start i ob "\\t"
      | '\x00'..'\x1F'
      | '\x7F' as c -> write_control_char s start i ob c
      | _ -> ()
  done;
  finish_string s start ob

let write_string ob s =
  Buffer.add_char ob '"';
  write_string_body ob s;
  Buffer.add_char ob '"'

let json_string_of_string s =
  let ob = Buffer.create 10 in
  write_string ob s;
  Buffer.contents ob

let write_null ob () =
  Buffer.add_string ob "null"

let write_bool ob x =
  Buffer.add_string ob (if x then "true" else "false")

let dec n =
  Char.chr (n + 48)

let rec write_digits s x =
  if x = 0 then ()
  else
    let d = x mod 10 in
    write_digits s (x / 10);
    Buffer.add_char s (dec (abs d))

let write_int ob x =
  if x > 0 then
    write_digits ob x
  else if x < 0 then (
    Buffer.add_char ob '-';
    write_digits ob x
  )
  else
    Buffer.add_char ob '0'


let json_string_of_int i =
  string_of_int i


(*
  Ensure that the float is not printed as an int.
  This is not required by JSON, but useful in order to guarantee
  reversibility.
*)
let float_needs_period s =
  try
    for i = 0 to String.length s - 1 do
      match s.[i] with
          '0'..'9' | '-' -> ()
        | _ -> raise Exit
    done;
    true
  with Exit ->
    false

(*
  Guarantees that a sufficient number of digits are printed in order to allow
  reversibility.
*)
let write_float ob x =
  match classify_float x with
    FP_nan ->
      Buffer.add_string ob "NaN"
  | FP_infinite ->
      Buffer.add_string ob (if x > 0. then "Infinity" else "-Infinity")
  | _ ->
      let s1 = Printf.sprintf "%.16g" x in
      let s =
        if float_of_string s1 = x then s1
        else Printf.sprintf "%.17g" x
      in
      Buffer.add_string ob s;
      if float_needs_period s then
        Buffer.add_string ob ".0"

let write_normal_float_prec significant_figures ob x =
  let open Printf in
  let s =
    match significant_figures with
        1 -> sprintf "%.1g" x
      | 2 -> sprintf "%.2g" x
      | 3 -> sprintf "%.3g" x
      | 4 -> sprintf "%.4g" x
      | 5 -> sprintf "%.5g" x
      | 6 -> sprintf "%.6g" x
      | 7 -> sprintf "%.7g" x
      | 8 -> sprintf "%.8g" x
      | 9 -> sprintf "%.9g" x
      | 10 -> sprintf "%.10g" x
      | 11 -> sprintf "%.11g" x
      | 12 -> sprintf "%.12g" x
      | 13 -> sprintf "%.13g" x
      | 14 -> sprintf "%.14g" x
      | 15 -> sprintf "%.15g" x
      | 16 -> sprintf "%.16g" x
      | _ -> sprintf "%.17g" x
  in
  Buffer.add_string ob s;
  if float_needs_period s then
    Buffer.add_string ob ".0"

(* used by atdgen *)
let write_float_prec significant_figures ob x =
  match classify_float x with
    FP_nan ->
      Buffer.add_string ob "NaN"
  | FP_infinite ->
      Buffer.add_string ob (if x > 0. then "Infinity" else "-Infinity")
  | _ ->
      write_normal_float_prec significant_figures ob x

let json_string_of_float x =
  let ob = Buffer.create 20 in
  write_float ob x;
  Buffer.contents ob


let write_std_float ob x =
  match classify_float x with
    FP_nan ->
      Common.json_error "NaN value not allowed in standard JSON"
  | FP_infinite ->
      Common.json_error
        (if x > 0. then
           "Infinity value not allowed in standard JSON"
         else
           "-Infinity value not allowed in standard JSON")
  | _ ->
      let s1 = Printf.sprintf "%.16g" x in
      let s =
        if float_of_string s1 = x then s1
        else Printf.sprintf "%.17g" x
      in
      Buffer.add_string ob s;
      if float_needs_period s then
        Buffer.add_string ob ".0"

(* used by atdgen *)
let write_std_float_prec significant_figures ob x =
  match classify_float x with
    FP_nan ->
      Common.json_error "NaN value not allowed in standard JSON"
  | FP_infinite ->
      Common.json_error
        (if x > 0. then
           "Infinity value not allowed in standard JSON"
         else
           "-Infinity value not allowed in standard JSON")
  | _ ->
      write_normal_float_prec significant_figures ob x

let std_json_string_of_float x =
  let ob = Buffer.create 20 in
  write_std_float ob x;
  Buffer.contents ob


let write_intlit = Buffer.add_string
let write_floatlit = Buffer.add_string
let write_stringlit = Buffer.add_string

let rec iter2_aux f_elt f_sep x = function
    [] -> ()
  | y :: l ->
      f_sep x;
      f_elt x y;
      iter2_aux f_elt f_sep x l

let iter2 f_elt f_sep x = function
    [] -> ()
  | y :: l ->
      f_elt x y;
      iter2_aux f_elt f_sep x l

let f_sep ob =
  Buffer.add_char ob ','

let rec write_json ob (x : t) =
  match x with
      `Null -> write_null ob ()
    | `Bool b -> write_bool ob b
    
# 228 "write.ml"
    | `Int i -> write_int ob i
    
# 231 "write.ml"
    | `Intlit s -> Buffer.add_string ob s
    
# 234 "write.ml"
    | `Float f -> write_float ob f
    
# 237 "write.ml"
    | `Floatlit s -> Buffer.add_string ob s
    
# 240 "write.ml"
    | `String s -> write_string ob s
    
# 243 "write.ml"
    | `Stringlit s -> Buffer.add_string ob s
    
# 245 "write.ml"
    | `Assoc l -> write_assoc ob l
    | `List l -> write_list ob l
    
# 248 "write.ml"
    | `Tuple l -> write_tuple ob l
    
# 251 "write.ml"
    | `Variant (s, o) -> write_variant ob s o

# 254 "write.ml"
and write_assoc ob l =
  let f_elt ob (s, x) =
    write_string ob s;
    Buffer.add_char ob ':';
    write_json ob x
  in
  Buffer.add_char ob '{';
  iter2 f_elt f_sep ob l;
  Buffer.add_char ob '}';

and write_list ob l =
  Buffer.add_char ob '[';
  iter2 write_json f_sep ob l;
  Buffer.add_char ob ']'

# 270 "write.ml"
and write_tuple ob l =
  Buffer.add_char ob '(';
  iter2 write_json f_sep ob l;
  Buffer.add_char ob ')'

# 277 "write.ml"
and write_variant ob s o =
  Buffer.add_char ob '<';
  write_string ob s;
  (match o with
       None -> ()
     | Some x ->
         Buffer.add_char ob ':';
         write_json ob x
  );
  Buffer.add_char ob '>'

# 289 "write.ml"
let write_t = write_json

let rec write_std_json ob (x : t) =
  match x with
      `Null -> write_null ob ()
    | `Bool b -> write_bool ob b
    
# 296 "write.ml"
    | `Int i -> write_int ob i
    
# 299 "write.ml"
    | `Intlit s -> Buffer.add_string ob s
    
# 302 "write.ml"
    | `Float f -> write_std_float ob f
    
# 305 "write.ml"
    | `Floatlit s -> Buffer.add_string ob s
    
# 308 "write.ml"
    | `String s -> write_string ob s
    
# 311 "write.ml"
    | `Stringlit s -> Buffer.add_string ob s
    
# 313 "write.ml"
    | `Assoc l -> write_std_assoc ob l
    | `List l -> write_std_list ob l
    
# 316 "write.ml"
    | `Tuple l -> write_std_tuple ob l
    
# 319 "write.ml"
    | `Variant (s, o) -> write_std_variant ob s o

# 322 "write.ml"
and write_std_assoc ob l =
  let f_elt ob (s, x) =
    write_string ob s;
    Buffer.add_char ob ':';
    write_std_json ob x
  in
  Buffer.add_char ob '{';
  iter2 f_elt f_sep ob l;
  Buffer.add_char ob '}';

and write_std_list ob l =
  Buffer.add_char ob '[';
  iter2 write_std_json f_sep ob l;
  Buffer.add_char ob ']'

and write_std_tuple ob l =
  Buffer.add_char ob '[';
  iter2 write_std_json f_sep ob l;
  Buffer.add_char ob ']'

# 343 "write.ml"
and write_std_variant ob s o =
  match o with
      None -> write_string ob s
    | Some x ->
        Buffer.add_char ob '[';
        write_string ob s;
        Buffer.add_char ob ',';
        write_std_json ob x;
        Buffer.add_char ob ']'


# 355 "write.ml"
let to_buffer ?(suf = "") ?(std = false) ob x =
  if std then
    write_std_json ob x
  else
    write_json ob x;
  Buffer.add_string ob suf

let to_string ?buf ?(len = 256) ?(suf = "") ?std x =
  let ob =
    match buf with
        None -> Buffer.create len
      | Some ob ->
          Buffer.clear ob;
          ob
  in
  to_buffer ~suf ?std ob x;
  let s = Buffer.contents ob in
  Buffer.clear ob;
  s

let to_channel ?buf ?(len=4096) ?(suf = "") ?std oc x =
  let ob =
    match buf with
        None -> Buffer.create len
      | Some ob -> Buffer.clear ob; ob
  in
  to_buffer ~suf ?std ob x;
  Buffer.output_buffer oc ob;
  Buffer.clear ob

let to_output ?buf ?(len=4096) ?(suf = "") ?std out x =
  let ob =
    match buf with
        None -> Buffer.create len
      | Some ob -> Buffer.clear ob; ob
  in
  to_buffer ~suf ?std ob x;
  (* this requires an int and never uses it. This is done to preserve
     backward compatibility to not break the signatur but can safely
     be changed to require unit in a future compatibility-breaking
     release *)
  let _ : int = out#output (Buffer.contents ob) 0 (Buffer.length ob) in
  Buffer.clear ob

let to_file ?len ?std ?(suf = "\n") file x =
  let oc = open_out file in
  try
    to_channel ?len ~suf ?std oc x;
    close_out oc
  with e ->
    close_out_noerr oc;
    raise e

let seq_to_buffer ?(suf = "\n") ?std ob st =
  Seq.iter (to_buffer ~suf ?std ob) st

let seq_to_string ?buf ?(len = 256) ?(suf = "\n") ?std st =
  let ob =
    match buf with
        None -> Buffer.create len
      | Some ob ->
          Buffer.clear ob;
          ob
  in
  seq_to_buffer ~suf ?std ob st;
  let s = Buffer.contents ob in
  Buffer.clear ob;
  s

let seq_to_channel ?buf ?(len=2096) ?(suf = "\n") ?std oc seq =
  let ob =
    match buf with
        None -> Buffer.create len
      | Some ob -> Buffer.clear ob; ob
  in
  Seq.iter (fun json ->
    to_buffer ~suf ?std ob json;
    Buffer.output_buffer oc ob;
    Buffer.clear ob;
  ) seq

let seq_to_file ?len ?(suf = "\n") ?std file st =
  let oc = open_out file in
  try
    seq_to_channel ?len ~suf ?std oc st;
    close_out oc
  with e ->
    close_out_noerr oc;
    raise e


let rec sort = function
  | `Assoc l ->
      let l = List.rev (List.rev_map (fun (k, v) -> (k, sort v)) l) in
      `Assoc (List.stable_sort (fun (a, _) (b, _) -> String.compare a b) l)
  | `List l ->
      `List (List.rev (List.rev_map sort l))
  
# 453 "write.ml"
  | `Tuple l ->
      `Tuple (List.rev (List.rev_map sort l))
  
# 457 "write.ml"
  | `Variant (k, Some v) as x ->
      let v' = sort v in
      if v == v' then x
      else
        `Variant (k, Some v')
  
# 463 "write.ml"
  | x -> x

# 1 "monomorphic.ml"
let rec pp fmt =
  function
  | `Null -> Format.pp_print_string fmt "`Null"
  | `Bool x ->
    Format.fprintf fmt "`Bool (@[<hov>";
    Format.fprintf fmt "%B" x;
    Format.fprintf fmt "@])"
  
# 9 "monomorphic.ml"
  | `Int x ->
    Format.fprintf fmt "`Int (@[<hov>";
    Format.fprintf fmt "%d" x;
    Format.fprintf fmt "@])"
  
# 15 "monomorphic.ml"
  | `Intlit x ->
    Format.fprintf fmt "`Intlit (@[<hov>";
    Format.fprintf fmt "%S" x;
    Format.fprintf fmt "@])"
  
# 21 "monomorphic.ml"
  | `Float x ->
    Format.fprintf fmt "`Float (@[<hov>";
    Format.fprintf fmt "%F" x;
    Format.fprintf fmt "@])"
  
# 27 "monomorphic.ml"
  | `Floatlit x ->
    Format.fprintf fmt "`Floatlit (@[<hov>";
    Format.fprintf fmt "%S" x;
    Format.fprintf fmt "@])"
  
# 33 "monomorphic.ml"
  | `String x ->
    Format.fprintf fmt "`String (@[<hov>";
    Format.fprintf fmt "%S" x;
    Format.fprintf fmt "@])"
  
# 39 "monomorphic.ml"
  | `Stringlit x ->
    Format.fprintf fmt "`Stringlit (@[<hov>";
    Format.fprintf fmt "%S" x;
    Format.fprintf fmt "@])"
  
# 44 "monomorphic.ml"
  | `Assoc xs ->
    Format.fprintf fmt "`Assoc (@[<hov>";
    Format.fprintf fmt "@[<2>[";
    ignore (List.fold_left
      (fun sep (key, value) ->
        if sep then
          Format.fprintf fmt ";@ ";
          Format.fprintf fmt "(@[";
          Format.fprintf fmt "%S" key;
          Format.fprintf fmt ",@ ";
          pp fmt value;
          Format.fprintf fmt "@])";
          true) false xs);
    Format.fprintf fmt "@,]@]";
    Format.fprintf fmt "@])"
  | `List xs ->
    Format.fprintf fmt "`List (@[<hov>";
    Format.fprintf fmt "@[<2>[";
    ignore (List.fold_left
      (fun sep x ->
        if sep then
          Format.fprintf fmt ";@ ";
          pp fmt x;
          true) false xs);
    Format.fprintf fmt "@,]@]";
    Format.fprintf fmt "@])"
  
# 71 "monomorphic.ml"
  | `Tuple tup ->
    Format.fprintf fmt "`Tuple (@[<hov>";
    Format.fprintf fmt "@[<2>[";
    ignore (List.fold_left
      (fun sep e ->
         if sep then
           Format.fprintf fmt ";@ ";
           pp fmt e;
           true) false tup);
    Format.fprintf fmt "@,]@]";
    Format.fprintf fmt "@])"
  
# 84 "monomorphic.ml"
  | `Variant (name, value) ->
    Format.fprintf fmt "`Variant (@[<hov>";
    Format.fprintf fmt "(@[";
    Format.fprintf fmt "%S" name;
    Format.fprintf fmt ",@ ";
    (match value with
      | None -> Format.pp_print_string fmt "None"
      | Some x ->
        Format.pp_print_string fmt "(Some ";
        pp fmt x;
        Format.pp_print_string fmt ")");
    Format.fprintf fmt "@])";
    Format.fprintf fmt "@])"

# 99 "monomorphic.ml"
let show x =
  Format.asprintf "%a" pp x

let rec equal a b =
  match a, b with
  | `Null, `Null -> true
  | `Bool a, `Bool b -> a = b
  
# 107 "monomorphic.ml"
  | `Int a, `Int b -> a = b
    
# 110 "monomorphic.ml"
    | `Intlit a, `Intlit b -> a = b
    
# 113 "monomorphic.ml"
    | `Float a, `Float b -> a = b
    
# 116 "monomorphic.ml"
    | `Floatlit a, `Floatlit b -> a = b
    
# 119 "monomorphic.ml"
    | `String a, `String b -> a = b
    
# 122 "monomorphic.ml"
    | `Stringlit a, `Stringlit b -> a = b
    
# 124 "monomorphic.ml"
    | `Assoc xs, `Assoc ys ->
      let compare_keys = fun (key, _) (key', _) -> String.compare key key' in
      let xs = List.stable_sort compare_keys xs in
      let ys = List.stable_sort compare_keys ys in
      (match List.for_all2 (fun (key, value) (key', value') ->
        match key = key' with
        | false -> false
        | true -> equal value value') xs ys with
      | result -> result
      | exception Invalid_argument _ ->
        (* the lists were of different lengths, thus unequal *)
        false)
    
# 137 "monomorphic.ml"
    | `Tuple xs, `Tuple ys
    
# 139 "monomorphic.ml"
    | `List xs, `List ys ->
      (match List.for_all2 equal xs ys with
      | result -> result
      | exception Invalid_argument _ ->
        (* the lists were of different lengths, thus unequal *)
        false)
    
# 146 "monomorphic.ml"
    | `Variant (name, value), `Variant (name', value') ->
      (match name = name' with
      | false -> false
      | true ->
        match value, value' with
        | None, None -> true
        | Some x, Some y -> equal x y
        | _ -> false)
    
# 155 "monomorphic.ml"
    | _ -> false

# 16 "t.cppo.ml"
module Pretty = struct
# 1 "prettyprint.ml"
(*
   Pretty-print JSON data in an attempt to maximize readability.

   1. What fits on one line stays on one line.
   2. What doesn't fit on one line gets printed more vertically so as to not
      exceed a reasonable page width, if possible.

   Arrays containing only simple elements ("atoms") are pretty-printed with
   end-of-line wrapping like ordinary text:

     [
        "hello", "hello", "hello", "hello", "hello", "hello", "hello", "hello",
        "hello", "hello", "hello", "hello", "hello", "hello", "hello", "hello"
     ]

   Other arrays are printed either horizontally or vertically depending
   on whether they fit on a single line:

     [ { "hello": "world" }, { "hello": "world" }, { "hello": "world" } ]

   or

     [
       { "hello": "world" },
       { "hello": "world" },
       { "hello": "world" },
       { "hello": "world" }
     ]
*)

let pp_list sep ppx out l =
  let pp_sep out () = Format.fprintf out "%s@ " sep in
  Format.pp_print_list ~pp_sep ppx out l

let is_atom (x: [> t]) =
  match x with
  | `Null
  | `Bool _
  | `Int _
  | `Float _
  | `String _
  | `Intlit _
  | `Floatlit _
  | `Stringlit _
  | `List []
  | `Assoc []
  | `Tuple []
  | `Variant (_, None) -> true
  | `List _
  | `Assoc _
  | `Tuple _
  | `Variant (_, Some _) -> false

let is_atom_list l =
  List.for_all is_atom l

(*
   inside_box: indicates that we're already within a box that imposes
   a certain style and we shouldn't create a new one. This is used for
   printing field values like this:

     foo: [
       bar
     ]

   rather than something else like

     foo:
       [
         bar
       ]
*)
let rec format ~inside_box std (out:Format.formatter) (x:t) : unit =
  match x with
    | `Null -> Format.pp_print_string out "null"
    | `Bool x -> Format.pp_print_bool out x
    
# 78 "prettyprint.ml"
    | `Int x -> Format.pp_print_string out (json_string_of_int x)
    
# 81 "prettyprint.ml"
    | `Float x ->
        let s =
          if std then std_json_string_of_float x
          else json_string_of_float x
        in
        Format.pp_print_string out s
    
# 89 "prettyprint.ml"
    | `String s -> Format.pp_print_string out (json_string_of_string s)
    
# 92 "prettyprint.ml"
    | `Intlit s -> Format.pp_print_string out s
    
# 95 "prettyprint.ml"
    | `Floatlit s -> Format.pp_print_string out s
    
# 98 "prettyprint.ml"
    | `Stringlit s -> Format.pp_print_string out s
    
# 100 "prettyprint.ml"
    | `List [] -> Format.pp_print_string out "[]"
    | `List l ->
      if not inside_box then Format.fprintf out "@[<hv2>";
      if is_atom_list l then
        (* use line wrapping like we would do for a paragraph of text *)
        Format.fprintf out "[@;<1 0>@[<hov>%a@]@;<1 -2>]"
          (pp_list "," (format ~inside_box:false std)) l
      else
        (* print the elements horizontally if they fit on the line,
           otherwise print them in a column *)
        Format.fprintf out "[@;<1 0>@[<hv>%a@]@;<1 -2>]"
          (pp_list "," (format ~inside_box:false std)) l;
      if not inside_box then Format.fprintf out "@]";
    | `Assoc [] -> Format.pp_print_string out "{}"
    | `Assoc l ->
      if not inside_box then Format.fprintf out "@[<hv2>";
      Format.fprintf out "{@;<1 0>%a@;<1 -2>}" (pp_list "," (format_field std)) l;
      if not inside_box then Format.fprintf out "@]";
    
# 119 "prettyprint.ml"
    | `Tuple l ->
        if std then
          format ~inside_box std out (`List l)
        else
          if l = [] then
            Format.pp_print_string out "()"
          else (
            if not inside_box then Format.fprintf out "@[<hov2>";
            Format.fprintf out "(@,%a@;<0 -2>)" (pp_list "," (format ~inside_box:false std)) l;
            if not inside_box then Format.fprintf out "@]";
          )
    
# 132 "prettyprint.ml"
    | `Variant (s, None) ->
        if std then
          
# 135 "prettyprint.ml"
          let representation = `String s in
          
# 139 "prettyprint.ml"
          format ~inside_box std out representation
        else
          Format.fprintf out "<%s>" (json_string_of_string s)

    | `Variant (s, Some x) ->
        if std then
          
# 146 "prettyprint.ml"
          let representation = `String s in
          
# 150 "prettyprint.ml"
          format ~inside_box std out (`List [ representation; x ])
        else
          let op = json_string_of_string s in
          Format.fprintf out "<@[<hv2>%s: %a@]>" op (format ~inside_box:true std) x

# 156 "prettyprint.ml"
and format_field std out (name, x) =
  Format.fprintf out "@[<hv2>%s: %a@]" (json_string_of_string name) (format ~inside_box:true std) x

let pp ?(std = false) out x =
  Format.fprintf out "@[<hv2>%a@]" (format ~inside_box:true std) (x :> t)

let to_string ?std x =
  Format.asprintf "%a" (pp ?std) x

let to_channel ?std oc x =
  let fmt = Format.formatter_of_out_channel oc in
  Format.fprintf fmt "%a@?" (pp ?std) x
# 18 "t.cppo.ml"
end

# 1 "write2.ml"
let pretty_print ?std out x = Pretty.pp ?std out x
let pretty_to_string ?std x = Pretty.to_string ?std x
let pretty_to_channel ?std oc x = Pretty.to_channel ?std oc x

