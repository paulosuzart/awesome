open! Base
open Ppxlib

(* Copies source syntax to be used in generated code. Strips attributes and ensures all
   locations are marked as "ghost". *)
let copy =
  object
    inherit Ast_traverse.map
    method! location loc = { loc with loc_ghost = true }
    method! attributes _ = []
  end
;;

let error ~loc fmt = Location.raise_errorf ~loc (Stdlib.( ^^ ) "ppx_globalize: " fmt)

(* Attribute for marking local parameters *)
let local_loc = Loc.make ~loc:Location.none "ocaml.local"

let local_attr =
  Ast_builder.Default.attribute ~loc:Location.none ~name:local_loc ~payload:(PStr [])
;;

(* Checking for attribute on global fields *)
let has_global_attr attributes =
  List.exists
    ~f:(fun attr ->
      String.equal attr.attr_name.txt "ocaml.global"
      || String.equal attr.attr_name.txt "extension.global")
    attributes
;;

let is_global_field ld =
  match ld.pld_mutable with
  | Mutable -> true
  | Immutable -> has_global_attr ld.pld_attributes
;;

(* Check if types are really recursive ignoring global and mutable
   fields *)
class is_recursive rec_flag decls =
  object
    inherit type_is_recursive rec_flag decls as super

    method! label_declaration ld =
      if is_global_field ld then () else super#label_declaration ld
  end

let really_recursive rec_flag decls = (new is_recursive rec_flag decls)#go ()

(* Type with local attribute attached *)
let ptyp_local typ = { typ with ptyp_attributes = local_attr :: typ.ptyp_attributes }

(* The name of the globalize function for a given type name as a string *)
let globalize_name type_name =
  if String.equal type_name "t" then "globalize" else "globalize_" ^ type_name
;;

(* The name of the globalize function for a given type name as a
   longident *)
let globalize_lid = function
  | Lident name -> Lident (globalize_name name)
  | Ldot (p, name) -> Ldot (p, globalize_name name)
  | Lapply _ -> assert false
;;

module Env : sig
  (* A mapping from type variables to globalize functions *)
  type t

  (* An empty mapping *)
  val empty : t

  type var =
    | Universal
    | Globalize of expression

  (* Lookup a globalize function *)
  val lookup : t -> string -> var option

  (* Create a mapping for the type parameters of a type
     declaration. Returns both the mapping and a list of names that
     should be bound to the globalize functions of the parameters of the
     type *)
  val of_type_decl : (module Ast_builder.S) -> type_declaration -> t * string list

  (* Update a mapping for the body of a variant constructor. In the
     non-GADT case the mapping is unchanged. In the GADT case we need to
     build the mapping by looking at the result type of the
     constructor. *)
  val enter_constructor_declaration
    :  (module Ast_builder.S)
    -> t
    -> constructor_declaration
    -> t

  (* Update a mapping for the body of a polytype. *)
  val enter_poly : (module Ast_builder.S) -> t -> string loc list -> t
end = struct
  type var =
    | Universal
    | Globalize of expression

  type t =
    { vars : var Map.M(String).t
    ; params : string list
    }

  let empty = { vars = Map.empty (module String); params = [] }
  let lookup t name = Map.find t.vars name

  let of_type_decl builder decl =
    let open (val builder : Ast_builder.S) in
    let vars = Map.empty (module String) in
    let params = [] in
    let t =
      List.fold_right
        decl.ptype_params
        ~init:{ vars; params }
        ~f:(fun (typ, _) { vars; params } ->
          let vars, sym =
            match typ.ptyp_desc with
            | Ptyp_var name ->
              let prefix = "_globalize_" ^ name in
              let sym = gen_symbol ~prefix () in
              let vars = Map.add_exn vars ~key:name ~data:(Globalize (evar sym)) in
              vars, sym
            | _ ->
              let prefix = "_globalize_param" in
              let sym = gen_symbol ~prefix () in
              vars, sym
          in
          let params = sym :: params in
          { vars; params })
    in
    t, t.params
  ;;

  (* This is for GADTs; it finds the indices (as opposed to the
     parameters) of the type and makes them their own globalize
     parameters.  Given a definition like:

     {[
       type ('a, 'b) t =
         | Foo : ... -> ('c, 'd) t
     ]}

     we are making a mapping from ['c] and ['d] to the globalize
     functions of the first and second parameters. [params] has the list
     of globalize functions so we just fold2 along that list and the
     list of arguments to [t] in the result type adding mappings for
     it. This completely replaces the outer mapping, which would have
     mapped ['a] and ['b] to those parameters.

     If the index is not a variable, or if the variable has already
     appeared for another index, then we don't add a mapping. *)
  let enter_constructor_declaration builder { vars; params } cd =
    let open (val builder : Ast_builder.S) in
    let vars =
      match cd.pcd_res with
      | None -> vars
      | Some ty ->
        let vars = Map.empty (module String) in
        (match ty.ptyp_desc with
         | Ptyp_constr (_, args) when List.length params = List.length args ->
           List.fold2_exn params args ~init:vars ~f:(fun vars param arg ->
             match arg.ptyp_desc with
             | Ptyp_var name | Ptyp_alias (_, name) ->
               (match Map.add vars ~key:name ~data:(Globalize (evar param)) with
                | `Duplicate -> vars
                | `Ok vars -> vars)
             | _ -> vars)
         | _ -> vars)
    in
    { vars; params }
  ;;

  let enter_poly _builder { vars; params } names =
    let vars =
      List.fold ~init:vars names ~f:(fun vars name ->
        Map.set vars ~key:name.txt ~data:Universal)
    in
    { vars; params }
  ;;
end

(* Generate the type for a copier function for a given list of type
   parameters and type name
*)
let generate_typ builder params type_name =
  let open (val builder : Ast_builder.S) in
  let type_lid = Located.lident type_name in
  let type_ =
    ptyp_arrow
      Nolabel
      (ptyp_local (ptyp_constr type_lid params))
      (ptyp_constr type_lid params)
  in
  List.fold_right params ~init:type_ ~f:(fun param acc ->
    ptyp_arrow Nolabel (ptyp_arrow Nolabel (ptyp_local param) param) acc)
;;

(* Is an object field a polymorphic method? *)
let is_polymorphic_method field =
  match field.pof_desc with
  | Otag (_, ct) ->
    (match ct.ptyp_desc with
     | Ptyp_poly _ -> true
     | _ -> false)
  | Oinherit _ -> false
;;

(* Strip a type to just its head for use in a coercion. This avoids
   needing to worry about the scope of type variables. *)
let rec type_head builder typ =
  let open (val builder : Ast_builder.S) in
  match typ.ptyp_desc with
  | Ptyp_any | Ptyp_var _ | Ptyp_extension _ -> ptyp_any
  | Ptyp_tuple args ->
    let args = List.map ~f:(fun _ -> ptyp_any) args in
    ptyp_tuple args
  | Ptyp_constr (lid, []) -> ptyp_constr (Located.mk lid.txt) []
  | Ptyp_constr (lid, _ :: _) -> ptyp_constr (Located.mk lid.txt) [ ptyp_any ]
  | Ptyp_variant (fields, closed, labels) ->
    let fields =
      List.map fields ~f:(fun field ->
        match field.prf_desc with
        | Rtag (label, const, args) ->
          rtag label const (List.map ~f:(fun _ -> ptyp_any) args)
        | Rinherit typ -> rinherit (type_head builder typ))
    in
    ptyp_variant fields closed labels
  | Ptyp_alias (typ, _) -> type_head builder typ
  | Ptyp_arrow (lbl, _, _) -> ptyp_arrow lbl ptyp_any ptyp_any
  | Ptyp_package (mty, constrs) ->
    let constrs = List.map ~f:(fun (lid, _) -> lid, ptyp_any) constrs in
    ptyp_package (mty, constrs)
  | Ptyp_object (fields, closed) ->
    if List.exists fields ~f:is_polymorphic_method
    then ptyp_any
    else (
      let fields =
        List.map fields ~f:(fun field ->
          match field.pof_desc with
          | Otag (lbl, _) -> otag lbl ptyp_any
          | Oinherit typ -> oinherit (type_head builder typ))
      in
      ptyp_object fields closed)
  | Ptyp_class (lid, args) ->
    let args = List.map ~f:(fun _ -> ptyp_any) args in
    ptyp_class (Located.mk lid.txt) args
  | Ptyp_poly _ -> assert false
;;

let mode_crossing_attr_name = "globalized"

let mode_crossing_attr_core_type =
  Attribute.declare
    mode_crossing_attr_name
    Attribute.Context.core_type
    Ast_pattern.(pstr nil)
    ()
;;

let mode_crossing_attr_label_declaration =
  Attribute.declare
    mode_crossing_attr_name
    Attribute.Context.label_declaration
    Ast_pattern.(pstr nil)
    ()
;;

(* We generate a beta-redex to give a better error message
   if the type does not cross modes. *)
let globalized_mode_crossing exp typ loc =
  let loc = { loc with loc_ghost = true } in
  let builder = Ast_builder.make loc in
  let open (val builder : Ast_builder.S) in
  pexp_apply
    (pexp_constraint
       (pexp_fun
          Nolabel
          None
          (ppat_var { txt = "x"; loc })
          (pexp_ident { txt = Lident "x"; loc }))
       (ptyp_arrow Nolabel (ptyp_local typ) (copy#core_type typ)))
    [ Nolabel, exp ]
;;

(* Generate code to create a globalized copy of the value produced by
   the expression [exp] of type [typ]. *)
let rec generate_globalized_for_typ builder env exp name_opt typ =
  let open (val builder : Ast_builder.S) in
  let typ_loc = typ.ptyp_loc in
  match Attribute.consume mode_crossing_attr_core_type typ with
  | Some (typ, ()) -> globalized_mode_crossing exp typ typ_loc
  | None ->
    (match typ.ptyp_desc with
     | Ptyp_var name ->
       (match Env.lookup env name with
        | Some (Globalize fn) -> eapply fn [ exp ]
        | Some Universal ->
          error
            ~loc:typ.ptyp_loc
            "Cannot generate globalize function for universal type variable '%s"
            name
        | None ->
          error
            ~loc:typ.ptyp_loc
            "Cannot generate globalize function for unbound type variable '%s"
            name)
     | Ptyp_tuple args ->
       let tpat, texp = generate_globalized_for_tuple_args builder env args in
       pexp_let Nonrecursive [ value_binding ~pat:tpat ~expr:exp ] texp
     | Ptyp_constr (lid, args) ->
       let args =
         List.map ~f:(generate_globalized_for_typ_as_function builder env None) args
       in
       let lid = globalize_lid lid.txt in
       eapply (pexp_ident (Located.mk lid)) (args @ [ exp ])
     | Ptyp_variant (fields, Closed, None) ->
       let inherits, constants, nonconstants =
         List.fold_right
           fields
           ~init:([], [], [])
           ~f:(fun field (inherits, consts, nonconsts) ->
             match field.prf_desc with
             | Rtag (name, false, [ arg ]) -> inherits, consts, (name.txt, arg) :: nonconsts
             | Rtag (name, true, []) -> inherits, name.txt :: consts, nonconsts
             | Rtag (_, _, _) ->
               error
                 ~loc:typ.ptyp_loc
                 "Cannot generate globalize function for partial variant type"
             | Rinherit typ ->
               (match typ.ptyp_desc with
                | Ptyp_constr (lid, _) -> (lid.txt, typ) :: inherits, consts, nonconsts
                | _ ->
                  error
                    ~loc:typ.ptyp_loc
                    "Cannot generate globalize function for unnamed inherited variant \
                     constructors"))
       in
       let inherit_cases =
         List.map inherits ~f:(fun (lid, inher) ->
           let v = gen_symbol ~prefix:"x" () in
           let lid = Located.mk lid in
           let lhs = ppat_alias (ppat_type lid) (Located.mk v) in
           let typ =
             match name_opt with
             | None -> typ
             | Some typ -> typ
           in
           let rhs =
             pexp_coerce
               (generate_globalized_for_typ builder env (evar v) None inher)
               (Some (type_head builder inher))
               (type_head builder typ)
           in
           case ~lhs ~rhs ~guard:None)
       in
       let constants_case =
         match constants with
         | [] -> None
         | first :: rest ->
           let v = gen_symbol ~prefix:"x" () in
           let first_pat = ppat_variant first None in
           let lhs =
             ppat_alias
               (List.fold ~init:first_pat rest ~f:(fun acc name ->
                  ppat_or acc (ppat_variant name None)))
               (Located.mk v)
           in
           let rhs = evar v in
           Some (case ~lhs ~rhs ~guard:None)
       in
       let nonconstants_cases =
         List.map nonconstants ~f:(fun (name, arg) ->
           let v = gen_symbol ~prefix:"arg" () in
           let lhs = ppat_variant name (Some (pvar v)) in
           let arg = generate_globalized_for_typ builder env (evar v) None arg in
           let rhs = pexp_variant name (Some arg) in
           case ~lhs ~rhs ~guard:None)
       in
       let cases = inherit_cases @ Option.to_list constants_case @ nonconstants_cases in
       pexp_match exp cases
     | Ptyp_variant (_, Open, _) ->
       error ~loc:typ.ptyp_loc "Cannot generate globalize function for open variant type"
     | Ptyp_variant (_, Closed, Some _) ->
       error
         ~loc:typ.ptyp_loc
         "Cannot generate globalize function for partial variant type"
     | Ptyp_alias (typ, name) ->
       (match Env.lookup env name with
        | Some (Globalize fn) -> eapply fn [ exp ]
        | Some Universal | None ->
          generate_globalized_for_typ builder env exp name_opt typ)
     | Ptyp_poly (names, typ) ->
       let env = Env.enter_poly builder env names in
       generate_globalized_for_typ builder env exp None typ
     | Ptyp_any ->
       error ~loc:typ.ptyp_loc "Cannot generate globalize function for unknown type"
     | Ptyp_arrow (_, _, _) ->
       error ~loc:typ.ptyp_loc "Cannot generate globalize function for function type"
     | Ptyp_object (_, _) ->
       error ~loc:typ.ptyp_loc "Cannot generate globalize function for object type"
     | Ptyp_class (_, _) ->
       error ~loc:typ.ptyp_loc "Cannot generate globalize function for class type"
     | Ptyp_package _ ->
       error
         ~loc:typ.ptyp_loc
         "Cannot generate globalize function for first-class module type"
     | Ptyp_extension _ ->
       error ~loc:typ.ptyp_loc "Cannot generate globalize function for unknown extension")

(* Generate code for a function to globalize values of type [type]. *)
and generate_globalized_for_typ_as_function builder env name_opt typ =
  let open (val builder : Ast_builder.S) in
  let v = gen_symbol ~prefix:"x" () in
  let lhs = pvar v in
  let rhs = generate_globalized_for_typ builder env (evar v) name_opt typ in
  eta_reduce_if_possible (pexp_fun Nolabel None lhs rhs)

(* Generate code to create a globalized copy of the arguments of a tuple
   with types [args]. Returns a pattern to match the tuple, an
   expression to produce the copy, and some value bindings for
   intermediate values. *)
and generate_globalized_for_tuple_args builder env args =
  let open (val builder : Ast_builder.S) in
  let pats, exps =
    List.fold_right
      ~init:([], [])
      ~f:(fun arg (pats, exps) ->
        let vin = gen_symbol ~prefix:"arg" () in
        let pat = pvar vin in
        let local_exp = evar vin in
        let exp =
          if has_global_attr arg.ptyp_attributes
          then local_exp
          else generate_globalized_for_typ builder env local_exp None arg
        in
        pat :: pats, exp :: exps)
      args
  in
  let pat =
    match pats with
    | [] -> assert false
    | [ pat ] -> pat
    | _ :: _ -> ppat_tuple pats
  in
  let exp =
    match exps with
    | [] -> assert false
    | [ exp ] -> exp
    | _ :: _ -> pexp_tuple exps
  in
  pat, exp
;;

(* Generate code to create a globalized copy of the arguments of a
   record with labels [lds].  Returns a pattern to match the record, an
   expression to produce the copy, and some value bindings for
   intermediate values. *)
let generate_globalized_for_record_args builder env lds =
  let open (val builder : Ast_builder.S) in
  let pats, exps =
    List.fold_right
      ~init:([], [])
      ~f:(fun ld (pats, exps) ->
        let name = ld.pld_name.txt in
        let lid = Located.mk (Lident name) in
        let vin = gen_symbol ~prefix:name () in
        let pat = lid, pvar vin in
        let local_exp = evar vin in
        let ld_loc = ld.pld_loc in
        let exp =
          match Attribute.consume mode_crossing_attr_label_declaration ld with
          | Some (ld, ()) -> globalized_mode_crossing local_exp ld.pld_type ld_loc
          | None ->
            if is_global_field ld
            then local_exp
            else generate_globalized_for_typ builder env local_exp None ld.pld_type
        in
        pat :: pats, (lid, exp) :: exps)
      lds
  in
  ppat_record pats Closed, pexp_record exps None
;;

(* Generate code to create a globalized copy of the value produced by
   the expression [exp] of a type with record labels [lds]. *)
let generate_globalized_for_record builder env exp lds =
  let open (val builder : Ast_builder.S) in
  let rpat, rexp = generate_globalized_for_record_args builder env lds in
  pexp_let Nonrecursive [ value_binding ~pat:rpat ~expr:exp ] rexp
;;

(* Generate code to create a globalized copy of the value produced by
   the expression [exp] of a type with variant constructors [cds]. *)
let generate_globalized_for_variant builder env exp cds =
  let open (val builder : Ast_builder.S) in
  let constants, nonconstants =
    List.fold_right
      cds
      ~init:([], [])
      ~f:(fun (cd : constructor_declaration) (consts, nonconsts) ->
        match cd.pcd_args with
        | Pcstr_tuple [] ->
          let name = cd.pcd_name.txt in
          let consts = name :: consts in
          consts, nonconsts
        | (Pcstr_tuple _ | Pcstr_record _) as args ->
          let name = cd.pcd_name.txt in
          let env = Env.enter_constructor_declaration builder env cd in
          let nonconsts = (name, args, env) :: nonconsts in
          consts, nonconsts)
  in
  let constants_case =
    match constants with
    | [] -> None
    | first :: rest ->
      let v = gen_symbol ~prefix:"x" () in
      let first_lid = Located.mk (Lident first) in
      let first_pat = ppat_construct first_lid None in
      let lhs =
        ppat_alias
          (List.fold ~init:first_pat rest ~f:(fun acc name ->
             let lid = Located.mk (Lident name) in
             ppat_or acc (ppat_construct lid None)))
          (Located.mk v)
      in
      let rhs = evar v in
      Some (case ~lhs ~rhs ~guard:None)
  in
  let nonconstants_cases =
    List.map nonconstants ~f:(fun (name, args, env) ->
      let pat, exp =
        match args with
        | Pcstr_tuple args -> generate_globalized_for_tuple_args builder env args
        | Pcstr_record lds -> generate_globalized_for_record_args builder env lds
      in
      let lid = Located.mk (Lident name) in
      let lhs = ppat_construct lid (Some pat) in
      let rhs = pexp_construct lid (Some exp) in
      case ~lhs ~rhs ~guard:None)
  in
  let cases = Option.to_list constants_case @ nonconstants_cases in
  pexp_match exp cases
;;

(* Generate code to create a globalized copy of the value produced by
   the expression [exp] of a type with declaration [decl]. *)
let generate_globalized_for_decl builder env exp name decl =
  let open (val builder : Ast_builder.S) in
  match decl.ptype_kind with
  | Ptype_abstract ->
    (match decl.ptype_manifest with
     | Some typ ->
       let name =
         let args =
           match decl.ptype_params with
           | [] -> []
           | _ :: _ -> [ ptyp_any ]
         in
         ptyp_constr (Located.lident name) args
       in
       generate_globalized_for_typ builder env exp (Some name) typ
     | None -> error ~loc "Cannot generate globalize function for abstract type")
  | Ptype_record lds -> generate_globalized_for_record builder env exp lds
  | Ptype_variant cds -> generate_globalized_for_variant builder env exp cds
  | Ptype_open -> error ~loc "Cannot generate globalize function for extensible variants"
;;

(* Generate code for a function to globalize values of a type with
   declaration [decl]. *)
let generate_globalized_for_decl_as_function builder env name decl =
  let open (val builder : Ast_builder.S) in
  let v = gen_symbol ~prefix:"x" () in
  let lhs = pvar v in
  let rhs = generate_globalized_for_decl builder env (evar v) name decl in
  pexp_fun Nolabel None lhs rhs
;;

(* Generate a value binding for a function to globalize values of a type with
   declaration [decl]. *)
let generate_vb rec_flag decl =
  let loc = { decl.ptype_loc with loc_ghost = true } in
  let builder = Ast_builder.make loc in
  let open (val builder : Ast_builder.S) in
  let type_name = decl.ptype_name.txt in
  let name = globalize_name type_name in
  let pat = pvar name in
  let param_names =
    List.mapi decl.ptype_params ~f:(fun i (param, _) ->
      match param.ptyp_desc with
      | Ptyp_var name -> name
      | _ -> "param" ^ Int.to_string i)
  in
  let external_params = List.map param_names ~f:(fun name -> ptyp_var name) in
  let external_param_bindings = List.map param_names ~f:(fun name -> Located.mk name) in
  let external_type =
    ptyp_poly external_param_bindings (generate_typ builder external_params type_name)
  in
  let pat = ppat_constraint pat external_type in
  let internal_param_names =
    List.map param_names ~f:(fun name -> gen_symbol ~prefix:name ())
  in
  let internal_params =
    List.map internal_param_names ~f:(fun name -> ptyp_constr (Located.lident name) [])
  in
  let internal_type = generate_typ builder internal_params type_name in
  let env, params = Env.of_type_decl builder decl in
  let fn = generate_globalized_for_decl_as_function builder env type_name decl in
  let fn = eabstract (List.map ~f:pvar params) fn in
  let fn = eta_reduce_if_possible_and_nonrec ~rec_flag fn in
  let expr = pexp_constraint fn internal_type in
  let expr =
    List.fold_right
      ~init:expr
      ~f:(fun name acc -> pexp_newtype (Located.mk name) acc)
      internal_param_names
  in
  value_binding ~pat ~expr
;;

(* Generate a value declaration for a function to globalize values of a type
   with declaration [decl]. *)
let generate_val decl =
  let loc = { decl.ptype_loc with loc_ghost = true } in
  let builder = Ast_builder.make loc in
  let open (val builder : Ast_builder.S) in
  let type_name = decl.ptype_name.txt in
  let name = Located.mk (globalize_name type_name) in
  let params = List.map decl.ptype_params ~f:(fun (param, _) -> param) in
  let type_ = generate_typ builder params type_name in
  let vd = value_description ~name ~type_ ~prim:[] in
  psig_value vd
;;

(* The deriver for types in structures *)
let generate_str ~ctxt:_ (rec_flag, decls) =
  let rec_flag = really_recursive rec_flag decls in
  let vbs = List.map ~f:(generate_vb rec_flag) decls in
  [ Ast_builder.Default.pstr_value ~loc:Location.none rec_flag vbs ]
;;

(* The deriver for types in signatures *)
let generate_sig ~ctxt:_ (_rec_flag, decls) = List.map ~f:generate_val decls

(* The implementation of `[%globalize: ...]` *)
let extension ~loc:_ ~path:_ typ =
  let loc = { typ.ptyp_loc with loc_ghost = true } in
  let builder = Ast_builder.make loc in
  generate_globalized_for_typ_as_function builder Env.empty None typ
;;

let extension_name = "globalize"

let globalize =
  let str_type_decl = Deriving.Generator.V2.make_noarg generate_str in
  let sig_type_decl = Deriving.Generator.V2.make_noarg generate_sig in
  Deriving.add extension_name ~str_type_decl ~sig_type_decl ~extension
;;
