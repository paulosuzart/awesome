(** Signature for a minimal subset of the [Stdlib.Thread] module needed by
    domain local await. *)
module type Thread = sig
  type t

  val self : unit -> t
  val id : t -> int
end
