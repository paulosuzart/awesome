let[@poll error] [@inline never] push_atomically r before after =
  !r == before
  && begin
       r := after;
       true
     end

let rec push r x =
  let before = !r in
  let after = x :: before in
  if not (push_atomically r before after) then push r x

let test_all_threads_are_woken_up () =
  let n = ref 2 in

  let barrier = Domain_local_await.prepare_for_await () in

  let awaiters = ref [] in

  let threads =
    List.init !n @@ fun _ ->
    ()
    |> Thread.create @@ fun () ->
       let t = Domain_local_await.prepare_for_await () in
       push awaiters t.release;
       decr n;
       if !n = 0 then barrier.release ();
       t.await ()
  in

  barrier.await ();

  !awaiters |> List.iter (fun awaiter -> awaiter ());

  threads |> List.iter Thread.join

let basics () =
  test_all_threads_are_woken_up ();
  Domain_local_await.per_thread (module Thread);
  test_all_threads_are_woken_up ()

let () =
  Alcotest.run "Domain_local_await"
    [ ("basics", [ Alcotest.test_case "" `Quick basics ]) ]
