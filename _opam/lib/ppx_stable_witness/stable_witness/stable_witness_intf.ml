module type T1 = sig
  type _ t
end

module type T2 = sig
  type (_, _) t
end

module type T3 = sig
  type (_, _, _) t
end

module type Stable_witness = sig
  type 'a t

  module Export : sig
    (** Stable witnesses for primitive types exported by [Core.Core_stable]. Code using
        [ppx_stable_witness] is expected to start with [open Stable_witness.Export]. *)

    val stable_witness_array : 'a t -> 'a array t
    val stable_witness_bool : bool t
    val stable_witness_bytes : bytes t
    val stable_witness_char : char t
    val stable_witness_exn : exn t
    val stable_witness_float : float t
    val stable_witness_int : int t
    val stable_witness_int32 : int32 t
    val stable_witness_int64 : int64 t
    val stable_witness_lazy_t : 'a t -> 'a lazy_t t
    val stable_witness_list : 'a t -> 'a list t
    val stable_witness_nativeint : nativeint t
    val stable_witness_option : 'a t -> 'a option t
    val stable_witness_ref : 'a t -> 'a ref t
    val stable_witness_string : string t
    val stable_witness_unit : unit t
  end

  (** This is useful to provide a stable witness on a type that uses another type for
      serialization. *)
  val of_serializable : 'a t -> ('a -> 'b) -> ('b -> 'a) -> 'b t

  module type T1 = T1

  module Of_serializable1 (Stable_format : T1) (M : T1) : sig
    (** This is the analogue of [of_serializable] for types with 1 type parameter, e.g.
        ['a M.t].

        An example usage would look something like this:

        {[
          let stable_witness (type a) : a Stable_witness.t -> a M.t Stable_witness.t =
            fun witness ->
            let module Stable_witness =
              Stable_witness.Of_serializable1 (Stable_format) (M)
            in
            Stable_witness.of_serializable
              Stable_format.stable_witness
              M.of_stable_format
              M.to_stable_format
              witness
          ;;
        ]}
    *)
    val of_serializable
      :  ('a t -> 'a Stable_format.t t) (** witness for stable format *)
      -> ('a Stable_format.t -> 'a M.t) (** conversion from stable format *)
      -> ('a M.t -> 'a Stable_format.t) (** conversion to stable format *)
      -> ('a t -> 'a M.t t)
  end

  module type T2 = T2

  module Of_serializable2 (Stable_format : T2) (M : T2) : sig
    (** This is the analogue of [of_serializable] for types with 2 type parameters. *)
    val of_serializable
      :  ('a1 t -> 'a2 t -> ('a1, 'a2) Stable_format.t t) (** witness for stable format *)
      -> (('a1, 'a2) Stable_format.t -> ('a1, 'a2) M.t) (** from stable format *)
      -> (('a1, 'a2) M.t -> ('a1, 'a2) Stable_format.t) (** to stable format *)
      -> ('a1 t -> 'a2 t -> ('a1, 'a2) M.t t)
  end

  module Of_serializable3 (Stable_format : T3) (M : T3) : sig
    (** This is the analogue of [of_serializable] for types with 3 type parameters. *)
    val of_serializable
      :  ('a1 t -> 'a2 t -> 'a3 t -> ('a1, 'a2, 'a3) Stable_format.t t)
      (** witness for stable format *)
      -> (('a1, 'a2, 'a3) Stable_format.t -> ('a1, 'a2, 'a3) M.t)
      (** from stable format *)
      -> (('a1, 'a2, 'a3) M.t -> ('a1, 'a2, 'a3) Stable_format.t) (** to stable format *)
      -> ('a1 t -> 'a2 t -> 'a3 t -> ('a1, 'a2, 'a3) M.t t)
  end

  (** This is an escape hatch.  Don't use it unless you have to.

      There are two use cases for this:

      1. It allows you to assert that a type that you're writing has stable serialization
      functions, even if the type itself depends on unstable types.

      2. It allows you to assert that a type from some other module is stable (and
      generate a stable witness for it) even if the type doesn't provide one for itself.
      It is almost always better to get the upstream code to provide a stability
      guarantee. At the very least, consult with the upstream maintainer to make sure
      their serializations are stable over time, and document the discussion. *)
  val assert_stable : _ t
end
