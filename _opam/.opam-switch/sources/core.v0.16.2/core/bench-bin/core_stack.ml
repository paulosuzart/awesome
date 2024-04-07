open! Core
module Stack = Core.Stack
module Bench = Core_bench.Bench

let () =
  Bench.bench
    [ Bench.Test.create
        ~name:"Stack.fold"
        (let s = Stack.of_list (List.init 100 ~f:Fn.id) in
         fun () -> ignore (Stack.fold s ~init:0 ~f:( + ) : int))
    ; Bench.Test.create
        ~name:"stack_push_pop"
        (let s = Stack.create () in
         Stack.push s ();
         fun () ->
           for _ = 1 to 10 do
             Stack.push s ();
             Stack.pop_exn s
           done)
    ]
;;
