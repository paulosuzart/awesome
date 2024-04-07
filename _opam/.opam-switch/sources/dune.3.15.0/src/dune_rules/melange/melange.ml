open Import

module Module_system = struct
  type t =
    | ESM
    | CommonJS

  let default = CommonJS, ".js"

  let to_string = function
    | ESM -> "es6"
    | CommonJS -> "commonjs"
  ;;
end

module Cm_kind = struct
  type t =
    | Cmi
    | Cmj

  let source = function
    | Cmi -> Ocaml.Ml_kind.Intf
    | Cmj -> Impl
  ;;

  let ext = function
    | Cmi -> ".cmi"
    | Cmj -> ".cmj"
  ;;

  let to_dyn =
    let open Dyn in
    function
    | Cmi -> variant "cmi" []
    | Cmj -> variant "cmj" []
  ;;

  module Map = struct
    type 'a t =
      { cmi : 'a
      ; cmj : 'a
      }

    let make_all x = { cmi = x; cmj = x }
  end
end

module Install = struct
  let dir = "melange"
end

let js_basename m =
  match Module.file ~ml_kind:Impl m with
  | Some s ->
    (* we aren't using Filename.extension because we want to handle
       filenames such as foo.pp.ml *)
    (match String.lsplit2 (Path.basename s) ~on:'.' with
     | None ->
       Code_error.raise
         "could not extract module name from file path"
         [ "module", Module.to_dyn m ]
     | Some (module_name, _) -> module_name)
  | None ->
    Code_error.raise
      "could not find melange source from module"
      [ "module", Module.to_dyn m ]
;;
