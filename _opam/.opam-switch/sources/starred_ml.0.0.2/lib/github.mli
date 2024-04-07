type starred = {
  name : string;
  description : string option;
  topics : string list;
  language : string option;
  url: string
}
[@@deriving show, yojson { strict = false; exn = true }]

type starred_response = starred list
[@@deriving yojson { strict = false; exn = true }]


(** Converts a result page of starred paged result into a list of starred *)
val from_string: string -> starred_response 

(** Converts a list of starred items into a struc grouped by language
 like [("java", [starred; starred]), ("scala", [starred;...])] *)
val by_language: starred list -> (string * starred list) list
