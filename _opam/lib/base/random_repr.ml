
module Repr = struct
  open Stdlib.Bigarray

  type t = (int64, int64_elt, c_layout) Array1.t

  let of_state : Stdlib.Random.State.t -> t = Stdlib.Obj.magic
end

let assign dst src =
  let dst = Repr.of_state (Lazy.force dst) in
  let src = Repr.of_state (Lazy.force src) in
  Stdlib.Bigarray.Array1.blit src dst

let make_default default =
  let split_from_parent v =
    Stdlib.Lazy.map_val Stdlib.Random.State.split v
  in
  Stdlib.Domain.DLS.new_key ~split_from_parent (fun () -> default)

let get_state random_key = Stdlib.Domain.DLS.get random_key
