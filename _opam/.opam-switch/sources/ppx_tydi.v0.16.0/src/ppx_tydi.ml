open Base
open Ppxlib

let extension =
  let pattern
    : ( payload, (pattern * expression) list -> expression -> expression, expression )
        Ast_pattern.t
    =
    let open Ast_pattern in
    single_expr_payload (pexp_let __ (many (pack2 (value_binding ~pat:__ ~expr:__))) __)
    |> map2 ~f:(fun rec_flag bindings ->
      match rec_flag with
      | Recursive -> Location.raise_errorf "[let rec] is not supported."
      | Nonrecursive -> bindings)
  in
  Extension.declare "tydi" Expression pattern (fun ~loc ~path:_ bindings rhs ->
    let open (val Ast_builder.make loc) in
    let patterns, expressions = List.unzip bindings in
    pexp_match
      (pexp_tuple expressions)
      [ case ~lhs:(ppat_tuple patterns) ~guard:None ~rhs ])
;;

let () =
  Driver.register_transformation "tydi" ~rules:[ Context_free.Rule.extension extension ]
;;
