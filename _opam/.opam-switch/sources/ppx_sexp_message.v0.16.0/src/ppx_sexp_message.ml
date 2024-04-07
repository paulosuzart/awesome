open! Base
open Ppxlib

let pattern =
  let open Ast_pattern in
  map (single_expr_payload __) ~f:(fun f x -> f (Some x))
  ||| map (pstr nil) ~f:(fun f -> f None)
;;

let expand ~omit_nil ~lazy_ ~loc ~path expr_opt =
  let expr = Ppx_sexp_message_expander.expand_opt ~omit_nil ~loc ~path expr_opt in
  if lazy_ then [%expr lazy [%e expr]] else expr
;;

let message ~name ~omit_nil ~lazy_ =
  Extension.declare name Extension.Context.expression pattern (expand ~omit_nil ~lazy_)
;;

let () =
  Driver.register_transformation
    "sexp_message"
    ~extensions:
      [ message ~name:"message" ~omit_nil:false ~lazy_:false
      ; message ~name:"@message.omit_nil" ~omit_nil:true ~lazy_:false
      ; message ~name:"lazy_message" ~omit_nil:false ~lazy_:true
      ; message ~name:"@lazy_message.omit_nil" ~omit_nil:true ~lazy_:true
      ]
;;
