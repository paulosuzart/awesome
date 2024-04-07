
# 1 "type.ml"
(** {3 Type of the JSON tree} *)

type t =
    [
    | `Null
    | `Bool of bool
    
# 8 "type.ml"
    | `Int of int
    
# 11 "type.ml"
    | `Intlit of string
    
# 14 "type.ml"
    | `Float of float
    
# 17 "type.ml"
    | `Floatlit of string
    
# 20 "type.ml"
    | `String of string
    
# 23 "type.ml"
    | `Stringlit of string
    
# 25 "type.ml"
    | `Assoc of (string * t) list
    | `List of t list
    
# 28 "type.ml"
    | `Tuple of t list
    
# 31 "type.ml"
    | `Variant of (string * t option)
    
# 33 "type.ml"
    ]
(**
All possible cases defined in Yojson:
- `Null: JSON null
- `Bool of bool: JSON boolean
- `Int of int: JSON number without decimal point or exponent.
- `Intlit of string: JSON number without decimal point or exponent,
	    preserved as a string.
- `Float of float: JSON number, Infinity, -Infinity or NaN.
- `Floatlit of string: JSON number, Infinity, -Infinity or NaN,
	    preserved as a string.
- `String of string: JSON string. Bytes in the range 128-255 are preserved
	    as-is without encoding validation for both reading
	    and writing.
- `Stringlit of string: JSON string literal including the double quotes.
- `Assoc of (string * json) list: JSON object.
- `List of json list: JSON array.
- `Tuple of json list: Tuple (non-standard extension of JSON).
	    Syntax: [("abc", 123)].
- `Variant of (string * json option): Variant (non-standard extension of JSON).
	    Syntax: [<"Foo">] or [<"Bar":123>].
*)

(*
  Note to adventurers: ocamldoc does not support inline comments
  on each polymorphic variant, and cppo doesn't allow to concatenate
  comments, so it would be complicated to document only the
  cases that are preserved by cppo in the type definition.
*)

# 1 "monomorphic.mli"
val pp : Format.formatter -> t -> unit
(** Pretty printer, useful for debugging *)

val show : t -> string
(** Convert value to string, useful for debugging *)

val equal : t -> t -> bool
(** [equal a b] is the monomorphic equality.
      Determines whether two JSON values are considered equal. In the case of
      JSON objects, the order of the keys does not matter, except for
      duplicate keys which will be considered equal as long as they are in the
      same input order.
    *)

# 1 "write.mli"
(** {2 JSON writers} *)

val to_string :
  ?buf:Buffer.t ->
  ?len:int ->
  ?suf:string ->
  ?std:bool ->
  t -> string
  (** Write a compact JSON value to a string.
      @param buf allows to reuse an existing buffer created with
      [Buffer.create]. The buffer is cleared of all contents
      before starting and right before returning.
      @param len initial length of the output buffer.
      @param suf appended to the output as a suffix,
      defaults to empty string.
      @param std use only standard JSON syntax,
      i.e. convert tuples and variants into standard JSON (if applicable),
      refuse to print NaN and infinities,
      require the root node to be either an object or an array.
      Default is [false].
      @raise Json_error if [float] value is not allowed in standard JSON.
  *)

val to_channel :
  ?buf:Buffer.t ->
  ?len:int ->
  ?suf:string ->
  ?std:bool ->
  out_channel -> t -> unit
  (** Write a compact JSON value to a channel.
      Note: the [out_channel] is not flushed by this function.

      See [to_string] for the role of the optional arguments and raised exceptions. *)

val to_output :
  ?buf:Buffer.t ->
  ?len:int ->
  ?suf:string ->
  ?std:bool ->
  < output : string -> int -> int -> int; .. > -> t -> unit
  (** Write a compact JSON value to an OO channel.

      See [to_string] for the role of the optional arguments and raised exceptions. *)

val to_file :
  ?len:int ->
  ?std:bool ->
  ?suf:string ->
  string -> t -> unit
  (** Write a compact JSON value to a file.
      See [to_string] for the role of the optional arguments and raised exceptions.
      @param suf is a suffix appended to the output Newline by default
      for POSIX compliance. *)

val to_buffer :
  ?suf:string ->
  ?std:bool ->
  Buffer.t -> t -> unit
  (** Write a compact JSON value to an existing buffer.
      See [to_string] for the role of the optional argument and raised exceptions. *)

val seq_to_string :
  ?buf:Buffer.t ->
  ?len:int ->
  ?suf:string ->
  ?std:bool ->
  t Seq.t -> string
  (** Write a sequence of [suf]-suffixed compact one-line JSON values to
      a string.
      @param suf is the suffix ouf each value written. Newline by default.
      See [to_string] for the role of the optional arguments and raised exceptions. *)

val seq_to_channel :
  ?buf:Buffer.t ->
  ?len:int ->
  ?suf:string ->
  ?std:bool ->
  out_channel -> t Seq.t -> unit
  (** Write a sequence of [suf]-suffixed compact one-line JSON values to
      a channel.
      @param suf is the suffix of each value written. Newline by default.
      See [to_channel] for the role of the optional arguments and raised exceptions. *)

val seq_to_file :
  ?len:int ->
  ?suf:string ->
  ?std:bool ->
  string -> t Seq.t -> unit
  (** Write a sequence of [suf]-suffixed compact one-line JSON values to
      a file.
      @param suf is the suffix of each value written. Newline by default.
      See [to_string] for the role of the optional arguments and raised exceptions. *)

val seq_to_buffer :
  ?suf:string ->
  ?std:bool ->
  Buffer.t ->
  t Seq.t -> unit
  (** Write a sequence of [suf]-suffixed compact one-line JSON values to
      an existing buffer.
      @param suf is the suffix of each value written. Newline by default.
      See [to_string] for the role of the optional arguments and raised exceptions. *)

val write_t : Buffer.t -> t -> unit
(** Write the given JSON value to the given buffer.
    Provided as a writer function for atdgen.
*)

(** {2 Miscellaneous} *)

val sort : t -> t
  (** Sort object fields (stable sort, comparing field names
      and treating them as byte sequences) *)


(**/**)
(* begin undocumented section *)

val write_null : Buffer.t -> unit -> unit
val write_bool : Buffer.t -> bool -> unit
# 122 "write.mli"
val write_int : Buffer.t -> int -> unit
# 125 "write.mli"
val write_float : Buffer.t -> float -> unit
val write_std_float : Buffer.t -> float -> unit
val write_float_prec : int -> Buffer.t -> float -> unit
val write_std_float_prec : int -> Buffer.t -> float -> unit
# 131 "write.mli"
val write_string : Buffer.t -> string -> unit

# 135 "write.mli"
val write_intlit : Buffer.t -> string -> unit
# 138 "write.mli"
val write_floatlit : Buffer.t -> string -> unit
# 141 "write.mli"
val write_stringlit : Buffer.t -> string -> unit

# 144 "write.mli"
val write_assoc : Buffer.t -> (string * t) list -> unit
val write_list : Buffer.t -> t list -> unit
# 147 "write.mli"
val write_tuple : Buffer.t -> t list -> unit
val write_std_tuple : Buffer.t -> t list -> unit
# 151 "write.mli"
val write_variant : Buffer.t -> string -> t option -> unit
val write_std_variant : Buffer.t -> string -> t option -> unit

# 155 "write.mli"
val write_json : Buffer.t -> t -> unit
val write_std_json : Buffer.t -> t -> unit

(* end undocumented section *)
(**/**)

# 1 "write2.mli"
(** {2 JSON pretty-printing} *)

val pretty_print : ?std:bool -> Format.formatter -> t -> unit
(** Pretty-print into a {!Format.formatter}.
      See [to_string] for the role of the optional [std] argument.
      @raise Json_error if [float] value is not allowed in standard JSON.

      @since 1.3.1 *)

val pretty_to_string : ?std:bool -> t -> string
(** Pretty-print into a string.
      See [to_string] for the role of the optional [std] argument.
      See [pretty_print] for raised exceptions.
  *)

val pretty_to_channel : ?std:bool -> out_channel -> t -> unit
(** Pretty-print to a channel.
      See [to_string] for the role of the optional [std] argument.
      See [pretty_print] for raised exceptions.
  *)

