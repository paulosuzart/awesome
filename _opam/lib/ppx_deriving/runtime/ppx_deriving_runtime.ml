# 1 "ppx_deriving_runtime.cppo.ml"
type nonrec int = int
type nonrec char = char
type nonrec string = string
type nonrec float = float
type nonrec bool = bool
type nonrec unit = unit
type nonrec exn = exn
type nonrec 'a array = 'a array
type nonrec 'a list = 'a list
type nonrec 'a option = 'a option
type nonrec nativeint = nativeint
type nonrec int32 = int32
type nonrec int64 = int64
type nonrec 'a lazy_t = 'a lazy_t
type nonrec bytes = bytes

# 18 "ppx_deriving_runtime.cppo.ml"
(* We require 4.08 while 4.07 already has a Stdlib module.
   In 4.07, the type equalities on Stdlib.Pervasives
   are not strong enough for the 'include Stdlib'
   below to satisfy the signature constraints on
   Ppx_deriving_runtime.Pervasives. *)
module Stdlib = Stdlib

include Stdlib

module Result = struct
  type ('a, 'b) t = ('a, 'b) result =
    | Ok of 'a
    | Error of 'b

  type ('a, 'b) result = ('a, 'b) t =
    | Ok of 'a
    | Error of 'b
end
