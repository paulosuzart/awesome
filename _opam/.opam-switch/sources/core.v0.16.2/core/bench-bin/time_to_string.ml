open Core
open Core_bench

let date = Date.create_exn ~d:14 ~m:Month.Jul ~y:1789

let () =
  Command_unix.run
    (Bench.make_command
       [ Bench.Test.create ~name:"Date.to_string" (fun () ->
           ignore (Date.to_string date : string))
       ])
;;
