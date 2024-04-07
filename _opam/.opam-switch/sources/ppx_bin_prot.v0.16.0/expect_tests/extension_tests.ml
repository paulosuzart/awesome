open! Core
open Expect_test_helpers_core

module type S = sig
  type t [@@deriving equal, quickcheck, sexp_of]
end

(* Testing [%bin_size], [%bin_write], and [%bin_read] *)
let test (type a) bin_size bin_write bin_read (module M : S with type t = a) =
  quickcheck_m
    [%here]
    (module M)
    ~f:(fun t ->
      let computed_size = bin_size t in
      let message = Bigstring.create computed_size in
      let written_size = bin_write message ~pos:0 t in
      match computed_size = written_size with
      | false ->
        print_cr
          [%here]
          [%message
            "did not write entire message"
              (computed_size : int)
              (written_size : int)
              ~written:(Bigstring.sub message ~pos:0 ~len:written_size : Bigstring.t)]
      | true ->
        let pos_ref = ref 0 in
        let round_trip = bin_read message ~pos_ref in
        let read_size = !pos_ref in
        (match computed_size = read_size with
         | false ->
           print_cr
             [%here]
             [%message
               "did not read entire message"
                 (computed_size : int)
                 (read_size : int)
                 (message : Bigstring.t)]
         | true -> require_equal [%here] (module M) t round_trip))
;;

let%expect_test _ = test [%bin_size: int] [%bin_write: int] [%bin_read: int] (module Int)

let%expect_test _ =
  test
    [%bin_size: string list]
    [%bin_write: string list]
    [%bin_read: string list]
    (module struct
      type t = string list [@@deriving equal, quickcheck, sexp_of]
    end)
;;

let%expect_test _ =
  let open struct
    type c = [ `C of string ] [@@deriving bin_io, equal, quickcheck, sexp_of]
  end in
  test
    [%bin_size: [ `A | `B of int | c ]]
    [%bin_write: [ `A | `B of int | c ]]
    [%bin_read: [ `A | `B of int | c ]]
    (module struct
      type t =
        [ `A
        | `B of int
        | c
        ]
      [@@deriving equal, quickcheck, sexp_of]
    end)
;;
