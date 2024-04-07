[@@@alert unstable "The API of this library is not stable and may change without notice."]

type code =
  { code : int
  ; name : string
  }

type source =
  | Code of code
  | Alert of string

type lines =
  | Single of int
  | Range of int * int

type loc =
  { chars : (int * int) option
  ; lines : lines
  ; path : string
  }

type severity =
  | Error of source option
  | Warning of code
  | Alert of
      { name : string
      ; source : string
      }

type report =
  { loc : loc
  ; severity : severity
  ; message : string
  ; related : (loc * string) list
  }

val dyn_of_report : report -> Dyn.t
val dyn_of_raw : [ `Loc of loc | `Message of string ] list -> Dyn.t
val parse_raw : string -> [ `Loc of loc | `Message of string ] list
val parse : string -> report list
