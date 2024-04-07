open! Base
open Ppxlib

module Part : sig
  type t =
    | Literal of label loc
    | Interpreted of
        { loc_start : position
        ; value : expression
        ; module_path : longident_loc option
        ; pad_length : expression option
        ; loc_end : position
        }
end

module Parse_result : sig
  type t =
    { parts : Part.t list
    ; locations_are_precise : bool
    }
end

val parse_parts : string_loc:location -> delimiter:label option -> label -> Parse_result.t

val expand
  :  expr_loc:location
  -> string_loc:location
  -> string:label
  -> delimiter:label option
  -> expression
