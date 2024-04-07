include Stable_witness_intf

(* The runtime representation of stable witnesses does not matter. *)
type _ t = unit

module Export = struct
  let stable_witness_array () = ()
  let stable_witness_bool = ()
  let stable_witness_bytes = ()
  let stable_witness_char = ()
  let stable_witness_exn = ()
  let stable_witness_float = ()
  let stable_witness_int = ()
  let stable_witness_int32 = ()
  let stable_witness_int64 = ()
  let stable_witness_lazy_t () = ()
  let stable_witness_list () = ()
  let stable_witness_nativeint = ()
  let stable_witness_option () = ()
  let stable_witness_ref () = ()
  let stable_witness_string = ()
  let stable_witness_unit = ()
end

let of_serializable () _ _ = ()

module Of_serializable1 (_ : T1) (_ : T1) = struct
  let of_serializable _ _ _ () = ()
end

module Of_serializable2 (_ : T2) (_ : T2) = struct
  let of_serializable _ _ _ () () = ()
end

module Of_serializable3 (_ : T3) (_ : T3) = struct
  let of_serializable _ _ _ _ () () = ()
end

let assert_stable = ()
