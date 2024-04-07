let basics () =
  let n_threads = 10 in
  let n_items_per_thread = 100_000 in
  let t = Thread_table.create () in

  let threads =
    Array.init n_threads @@ fun i ->
    ()
    |> Thread.create @@ fun () ->
       for i = i * n_items_per_thread to ((i + 1) * n_items_per_thread) - 1 do
         Thread_table.add t i (-i)
       done
  in
  Array.iter Thread.join threads;

  Alcotest.check' ~msg:"length" Alcotest.int
    ~expected:(n_threads * n_items_per_thread)
    ~actual:(Thread_table.length t);

  for i = 0 to (n_threads * n_items_per_thread) - 1 do
    if Thread_table.find t i <> -i then raise Not_found
  done;

  let threads =
    Array.init n_threads @@ fun i ->
    ()
    |> Thread.create @@ fun () ->
       for
         i = ((i + 1) * n_items_per_thread) - 1 downto i * n_items_per_thread
       do
         Thread_table.remove t i
       done
  in
  Array.iter Thread.join threads;

  for i = 0 to (n_threads * n_items_per_thread) - 1 do
    match Thread_table.find t i with
    | _ -> raise Not_found
    | exception Not_found -> ()
  done;

  Alcotest.check' ~msg:"length" Alcotest.int ~expected:0
    ~actual:(Thread_table.length t);

  ()

let () =
  Alcotest.run "Thread_table"
    [ ("basics", [ Alcotest.test_case "" `Quick basics ]) ]
