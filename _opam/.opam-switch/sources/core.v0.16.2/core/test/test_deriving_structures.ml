open Core
open Stable_witness.Export


(* We just want to make sure all of this compiles. *)

module _ = struct
  type t = Set.M(Int).t [@@deriving compare, hash, sexp]
end

module _ : sig
  type t = Int.Set.t [@@deriving compare, sexp, stable_witness]
end = struct
  type t = Set.Stable.V1.M(Int.Stable.V1).t [@@deriving compare, sexp, stable_witness]
end

module _ = struct
  type t0 = float Map.M(Int).t [@@deriving compare, hash, sexp]
  type 'a t1 = 'a Map.M(Bool).t [@@deriving compare, hash, sexp]
end

module _ : sig
  type t0 = float Int.Map.t [@@deriving compare, sexp, stable_witness]
  type 'a t1 = 'a Int.Map.t [@@deriving compare, sexp, stable_witness]
end = struct
  type t0 = float Map.Stable.V1.M(Int.Stable.V1).t
  [@@deriving compare, sexp, stable_witness]

  type 'a t1 = 'a Map.Stable.V1.M(Int.Stable.V1).t
  [@@deriving compare, sexp, stable_witness]
end

module _ = struct
  type t0 = float Hashtbl.M(Int).t [@@deriving sexp]
  type 'a t1 = 'a Hashtbl.M(Bool).t [@@deriving sexp]
end
