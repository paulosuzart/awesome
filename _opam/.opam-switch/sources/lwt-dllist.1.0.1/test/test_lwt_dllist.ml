(* This file is part of Lwt, released under the MIT license. See LICENSE.md for
   details, or visit https://github.com/ocsigen/lwt/blob/master/LICENSE.md. *)

open Test

let filled_sequence () =
  let s = Lwt_dllist.create () in
  let _ = Lwt_dllist.add_r 1 s in
  let _ = Lwt_dllist.add_r 2 s in
  let _ = Lwt_dllist.add_r 3 s in
  let _ = Lwt_dllist.add_r 4 s in
  let _ = Lwt_dllist.add_r 5 s in
  let _ = Lwt_dllist.add_r 6 s in
  s

let filled_length = 6

let leftmost_value = 1

let rightmost_value = 6

let transfer_sequence () =
  let s = Lwt_dllist.create () in
  let _ = Lwt_dllist.add_r 7 s in
  let _ = Lwt_dllist.add_r 8 s in
  s

let transfer_length = 2

let empty_array = [||]

let l_filled_array = [|1; 2; 3; 4; 5; 6|]

let r_filled_array = [|6; 5; 4; 3; 2; 1|]

let factorial_sequence = 720

let test_iter iter_f array_values seq =
  let index = ref 0 in
  Lwt.catch
   (fun () ->
    iter_f (fun v ->
              assert (v = array_values.(!index));
              index := (!index + 1)) seq;
    Lwt.return_true)
   (function _ -> Lwt.return_false)

let test_iter_node iter_f array_values seq =
  let index = ref 0 in
  Lwt.catch
   (fun () ->
    iter_f (fun n ->
              assert ((Lwt_dllist.get n) = array_values.(!index));
              index := (!index + 1)) seq;
    Lwt.return_true)
   (function _ -> Lwt.return_false)

let test_iter_rem iter_f array_values seq =
  let index = ref 0 in
  Lwt.catch
   (fun () ->
    iter_f (fun n ->
              assert ((Lwt_dllist.get n) = array_values.(!index));
              Lwt_dllist.remove n;
              index := (!index + 1)) seq;
    Lwt.return_true)
   (function _ -> Lwt.return_false)

let suite = suite "lwt_sequence" [

  test "create" begin fun () ->
    let s = Lwt_dllist.create () in
    let _ = assert (Lwt_dllist.is_empty s) in
    let len = Lwt_dllist.length s in
    Lwt.return (len = 0)
  end;

  test "add_l" begin fun () ->
    let s = Lwt_dllist.create () in
    let n = Lwt_dllist.add_l 1 s in
    let _ = assert ((Lwt_dllist.get n) = 1) in
    let len = Lwt_dllist.length s in
    Lwt.return (len = 1)
  end;

  test "add_r" begin fun () ->
    let s = Lwt_dllist.create () in
    let n = Lwt_dllist.add_r 1 s in
    let _ = assert ((Lwt_dllist.get n) = 1) in
    let len = Lwt_dllist.length s in
    Lwt.return (len = 1)
  end;

  test "take_l Empty" begin fun () ->
    let s = Lwt_dllist.create () in
    Lwt.catch
      (fun () ->
        let _ = Lwt_dllist.take_l s in
        Lwt.return_false)
      (function
        | Lwt_dllist.Empty -> Lwt.return_true
        | _ -> Lwt.return_false)
  end;

  test "take_l" begin fun () ->
    let s = filled_sequence () in
    Lwt.catch
      (fun () ->
        let v = Lwt_dllist.take_l s in
        Lwt.return (leftmost_value = v))
      (function _ -> Lwt.return_false)
  end;

  test "take_r Empty" begin fun () ->
    let s = Lwt_dllist.create () in
    Lwt.catch
      (fun () ->
        let _ = Lwt_dllist.take_r s in Lwt.return_false)
      (function
        | Lwt_dllist.Empty -> Lwt.return_true
        | _ -> Lwt.return_false)
  end;

  test "take_r" begin fun () ->
    let s = filled_sequence () in
    Lwt.catch
      (fun () ->
        let v = Lwt_dllist.take_r s in Lwt.return (rightmost_value = v))
      (function _ -> Lwt.return_false)
  end;

  test "take_opt_l Empty" begin fun () ->
    let s = Lwt_dllist.create () in
    match Lwt_dllist.take_opt_l s with
    | None -> Lwt.return_true
    | _ -> Lwt.return_false
  end;

  test "take_opt_l" begin fun () ->
    let s = filled_sequence () in
    match Lwt_dllist.take_opt_l s with
    | None -> Lwt.return_false
    | Some v -> Lwt.return (leftmost_value = v)
  end;

  test "take_opt_r Empty" begin fun () ->
    let s = Lwt_dllist.create () in
    match Lwt_dllist.take_opt_r s with
    | None -> Lwt.return_true
    | _ -> Lwt.return_false
  end;

  test "take_opt_r" begin fun () ->
    let s = filled_sequence () in
    match Lwt_dllist.take_opt_r s with
    | None -> Lwt.return_false
    | Some v -> Lwt.return (rightmost_value = v)
  end;

  test "transfer_l Empty" begin fun () ->
    let s = filled_sequence () in
    let ts = Lwt_dllist.create () in
    let _ = Lwt_dllist.transfer_l ts s in
    let len = Lwt_dllist.length s in
    Lwt.return (filled_length = len)
  end;

  test "transfer_l " begin fun () ->
    let s = filled_sequence () in
    let ts = transfer_sequence () in
    let _ = Lwt_dllist.transfer_l ts s in
    let len = Lwt_dllist.length s in
    let _ = assert ((filled_length + transfer_length) = len) in
    match Lwt_dllist.take_opt_l s with
    | None -> Lwt.return_false
    | Some v -> Lwt.return (7 = v)
  end;

  test "transfer_r Empty" begin fun () ->
    let s = filled_sequence () in
    let ts = Lwt_dllist.create () in
    let _ = Lwt_dllist.transfer_r ts s in
    let len = Lwt_dllist.length s in
    Lwt.return (filled_length = len)
  end;

  test "transfer_r " begin fun () ->
    let s = filled_sequence () in
    let ts = transfer_sequence () in
    let _ = Lwt_dllist.transfer_r ts s in
    let len = Lwt_dllist.length s in
    let _ = assert ((filled_length + transfer_length) = len) in
    match Lwt_dllist.take_opt_r s with
    | None -> Lwt.return_false
    | Some v -> Lwt.return (8 = v)
  end;

  test "iter_l Empty" begin fun () ->
    test_iter Lwt_dllist.iter_l empty_array (Lwt_dllist.create ())
  end;

  test "iter_l" begin fun () ->
    test_iter Lwt_dllist.iter_l l_filled_array (filled_sequence ())
  end;

  test "iter_r Empty" begin fun () ->
    test_iter Lwt_dllist.iter_r empty_array (Lwt_dllist.create ())
  end;

  test "iter_r" begin fun () ->
    test_iter Lwt_dllist.iter_r r_filled_array (filled_sequence ())
  end;

  test "iter_node_l Empty" begin fun () ->
    test_iter_node Lwt_dllist.iter_node_l empty_array (Lwt_dllist.create ())
  end;

  test "iter_node_l" begin fun () ->
    test_iter_node Lwt_dllist.iter_node_l l_filled_array (filled_sequence ())
  end;

  test "iter_node_r Empty" begin fun () ->
    test_iter_node Lwt_dllist.iter_node_r empty_array (Lwt_dllist.create ())
  end;

  test "iter_node_r" begin fun () ->
    test_iter_node Lwt_dllist.iter_node_r r_filled_array (filled_sequence ())
  end;

  test "iter_node_l with removal" begin fun () ->
    test_iter_rem Lwt_dllist.iter_node_l l_filled_array (filled_sequence ())
  end;

  test "iter_node_r with removal" begin fun () ->
    test_iter_rem Lwt_dllist.iter_node_r r_filled_array (filled_sequence ())
  end;

  test "fold_l" begin fun () ->
    let acc = Lwt_dllist.fold_l (fun v e -> v * e) (filled_sequence ()) 1 in
    Lwt.return (factorial_sequence = acc)
  end;

  test "fold_l Empty" begin fun () ->
    let acc = Lwt_dllist.fold_l (fun v e -> v * e) (Lwt_dllist.create ()) 1 in
    Lwt.return (acc = 1)
  end;

  test "fold_r" begin fun () ->
    let acc = Lwt_dllist.fold_r (fun v e -> v * e) (filled_sequence ()) 1 in
    Lwt.return (factorial_sequence = acc)
  end;

  test "fold_r Empty" begin fun () ->
    let acc = Lwt_dllist.fold_r (fun v e -> v * e) (Lwt_dllist.create ()) 1 in
    Lwt.return (acc = 1)
  end;

  test "find_node_opt_l Empty" begin fun () ->
    let s = Lwt_dllist.create () in
    match Lwt_dllist.find_node_opt_l (fun v -> v = 1) s with
    | None -> Lwt.return_true
    | _ -> Lwt.return_false
  end;

  test "find_node_opt_l not found " begin fun () ->
    let s = transfer_sequence () in
    match Lwt_dllist.find_node_opt_l (fun v -> v = 1) s with
    | None -> Lwt.return_true
    | _ -> Lwt.return_false
  end;

  test "find_node_opt_l" begin fun () ->
    let s = filled_sequence () in
    match Lwt_dllist.find_node_opt_l (fun v -> v = 1) s with
    | None -> Lwt.return_false
    | Some n -> if ((Lwt_dllist.get n) = 1) then Lwt.return_true
      else Lwt.return_false
  end;

  test "find_node_opt_r Empty" begin fun () ->
    let s = Lwt_dllist.create () in
    match Lwt_dllist.find_node_opt_r (fun v -> v = 1) s with
    | None -> Lwt.return_true
    | _ -> Lwt.return_false
  end;

  test "find_node_opt_r not found " begin fun () ->
    let s = transfer_sequence () in
    match Lwt_dllist.find_node_opt_r (fun v -> v = 1) s with
    | None -> Lwt.return_true
    | _ -> Lwt.return_false
  end;

  test "find_node_opt_r" begin fun () ->
    let s = filled_sequence () in
    match Lwt_dllist.find_node_opt_r (fun v -> v = 1) s with
    | None -> Lwt.return_false
    | Some n -> if ((Lwt_dllist.get n) = 1) then Lwt.return_true
      else Lwt.return_false
  end;

  test "find_node_l Empty" begin fun () ->
    let s = Lwt_dllist.create () in
    Lwt.catch
    (fun () -> let n = Lwt_dllist.find_node_l (fun v -> v = 1) s in
       if ((Lwt_dllist.get n) = 1) then Lwt.return_false
       else Lwt.return_false)
    (function
      | Not_found -> Lwt.return_true
      | _ -> Lwt.return_false)
  end;

  test "find_node_l" begin fun () ->
    let s = filled_sequence () in
    Lwt.catch
    (fun () -> let n = Lwt_dllist.find_node_l (fun v -> v = 1) s in
       if ((Lwt_dllist.get n) = 1) then Lwt.return_true
       else Lwt.return_false)
    (function _ -> Lwt.return_false)
  end;

  test "find_node_r Empty" begin fun () ->
    let s = Lwt_dllist.create () in
    Lwt.catch
    (fun () -> let n = Lwt_dllist.find_node_r (fun v -> v = 1) s in
       if ((Lwt_dllist.get n) = 1) then Lwt.return_false
       else Lwt.return_false)
    (function
      | Not_found -> Lwt.return_true
      | _ -> Lwt.return_false)
  end;

  test "find_node_r" begin fun () ->
    let s = filled_sequence () in
    Lwt.catch
    (fun () -> let n = Lwt_dllist.find_node_r (fun v -> v = 1) s in
       if ((Lwt_dllist.get n) = 1) then Lwt.return_true
       else Lwt.return_false)
    (function _ -> Lwt.return_false)
  end;

  test "set" begin fun () ->
    let s = filled_sequence () in
    match Lwt_dllist.find_node_opt_l (fun v -> v = 4) s with
    | None -> Lwt.return_false
    | Some n -> let _ = Lwt_dllist.set n 10 in
      let data = [|1; 2; 3; 10; 5; 6|] in
      test_iter Lwt_dllist.iter_l data s
  end;

  test "fold_r with multiple removal" begin fun () ->
    let s = filled_sequence () in
    let n_three = Lwt_dllist.find_node_r (fun v' -> v' = 3) s in
    let n_two = Lwt_dllist.find_node_r (fun v' -> v' = 2) s in
    let n_four = Lwt_dllist.find_node_r (fun v' -> v' = 4) s in
    let acc = Lwt_dllist.fold_r begin fun v e ->
      if v = 3 then begin
         let _ = Lwt_dllist.remove n_three in
         let _ = Lwt_dllist.remove n_two in
         ignore(Lwt_dllist.remove n_four)
      end;
      v * e
    end s 1 in
    Lwt.return (acc = (factorial_sequence / 2))
  end;

  test "fold_l multiple removal" begin fun () ->
   let s = filled_sequence () in
   let n_four = Lwt_dllist.find_node_r (fun v' -> v' = 4) s in
   let n_five = Lwt_dllist.find_node_r (fun v' -> v' = 5) s in
   let n_three = Lwt_dllist.find_node_r (fun v' -> v' = 3) s in
   let acc = Lwt_dllist.fold_l begin fun v e ->
      if v = 4 then begin
         let _ = Lwt_dllist.remove n_four in
         let _ = Lwt_dllist.remove n_five in
         ignore(Lwt_dllist.remove n_three)
      end;
      v * e
   end s 1 in
    Lwt.return (acc = (factorial_sequence / 5))
  end;

  test "find_node_r with multiple removal" begin fun () ->
    let s = filled_sequence () in
    let n_three = Lwt_dllist.find_node_r (fun v' -> v' = 3) s in
    let n_two = Lwt_dllist.find_node_r (fun v' -> v' = 2) s in
    Lwt.catch
    begin fun () ->
      let n = Lwt_dllist.find_node_r begin fun v ->
        if v = 3 then (
          let _ = Lwt_dllist.remove n_three in
          ignore(Lwt_dllist.remove n_two));
        v = 1
       end s in
      let v = Lwt_dllist.get n in
      Lwt.return (v = 1)
    end
    (function _ -> Lwt.return_false)
  end;

  test "find_node_l with multiple removal" begin fun () ->
    let s = filled_sequence () in
    let n_three = Lwt_dllist.find_node_r (fun v' -> v' = 3) s in
    let n_four = Lwt_dllist.find_node_r (fun v' -> v' = 4) s in
    Lwt.catch
    begin fun () ->
      let n = Lwt_dllist.find_node_l begin fun v ->
        if v = 3 then (
          let _ = Lwt_dllist.remove n_three in
          ignore(Lwt_dllist.remove n_four));
        v = 6 end s in
      let v = Lwt_dllist.get n in
      Lwt.return (v = 6)
    end
    (function _ -> Lwt.return_false)
  end;
]
