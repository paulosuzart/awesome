open Base
open Ppxlib
open Ast_builder.Default

(* The scope in which to find [Optional_syntax]. [From_module] means using
   module.Optional_syntax.Optional_syntax *)
type module_scope =
  | Use_optional_syntax
  | Use_optional_syntax_optional_syntax
  | From_module of longident loc

module Matched_expression_element = struct
  type t =
    { module_ : module_scope
    ; exp : expression
    }
end

type t =
  { default_module : module_scope
  ; original_matched_expr : expression
  ; elements : Matched_expression_element.t list
  ; match_loc : Location.t
  ; cases : case list
  }

let module_scope_of_option = function
  | None -> Use_optional_syntax
  | Some module_ -> From_module module_
;;

let infer_module_from_core_type ~module_ (core_type : core_type) =
  let default = module_scope_of_option module_ in
  match core_type.ptyp_desc with
  | Ptyp_constr (longident, _params) ->
    (match longident.txt with
     | Lident _ -> Use_optional_syntax_optional_syntax
     | Ldot (longident, _label) ->
       From_module { txt = longident; loc = core_type.ptyp_loc }
     | Lapply _ -> default)
  | _ -> default
;;

let expand_matched_expr ~(module_ : longident loc option) matched_expr =
  let individual_exprs =
    match matched_expr.pexp_desc with
    | Pexp_tuple exprs -> exprs
    | _ -> [ matched_expr ]
  in
  List.map individual_exprs ~f:(fun exp ->
    match exp.pexp_desc with
    | Pexp_constraint (_exp, core_type) ->
      { Matched_expression_element.module_ =
          infer_module_from_core_type ~module_ core_type
      ; exp
      }
    | _ -> { module_ = module_scope_of_option module_; exp })
;;

let optional_syntax_str = "Optional_syntax"

let optional_syntax ~module_ : Longident.t =
  match (module_ : module_scope) with
  | Use_optional_syntax -> Lident optional_syntax_str
  | Use_optional_syntax_optional_syntax ->
    Ldot (Lident optional_syntax_str, optional_syntax_str)
  | From_module id -> Ldot (Ldot (id.txt, optional_syntax_str), optional_syntax_str)
;;

let eoperator ~loc ~module_ func =
  let lid : Longident.t = Ldot (optional_syntax ~module_, func) in
  pexp_ident ~loc (Located.mk ~loc lid)
;;

let eunsafe_value = eoperator "unsafe_value"
let eis_none = eoperator "is_none"

let rec assert_binder pat =
  match pat.ppat_desc with
  | Ppat_alias (pat, _) | Ppat_constraint (pat, _) ->
    (* Allow "Some (_ as x)" and "Some (_ : typ)" *)
    assert_binder pat
  | Ppat_var _ | Ppat_any -> ()
  | _ ->
    Location.raise_errorf
      ~loc:pat.ppat_loc
      "sub patterns are restricted to variable names, wildcards and aliases"
;;

let disable_all_warnings e =
  let attr =
    let loc = Location.none in
    attribute
      ~loc
      ~name:{ Location.loc; txt = "ocaml.warning" }
      ~payload:(PStr [ pstr_eval ~loc (estring ~loc "-a") [] ])
  in
  { e with pexp_attributes = attr :: e.pexp_attributes }
;;

let varname i = Printf.sprintf "__ppx_optional_e_%i" i
let evar ~loc i = evar ~loc (varname i)
let pvar ~loc i = pvar ~loc (varname i)

let get_pattern_and_bindings ~module_ i pattern =
  let rec loop pat bindings =
    let loc = pat.ppat_loc in
    let option_binding x =
      value_binding ~loc ~pat:(ppat_var ~loc x) ~expr:(evar ~loc i)
    in
    let unsafe_value_binding x =
      value_binding
        ~loc
        ~pat:[%pat? ([%p x] : _)]
        ~expr:(eapply ~loc (eunsafe_value ~loc ~module_) [ evar ~loc i ])
    in
    match pat with
    | { ppat_desc = Ppat_alias (pat, x); _ } ->
      let binding = option_binding x in
      loop pat (binding :: bindings)
    | { ppat_desc = Ppat_var x; _ } ->
      let binding = option_binding x in
      [%pat? _], binding :: bindings
    | [%pat? Some [%p? x]] ->
      assert_binder x;
      let binding = unsafe_value_binding x in
      [%pat? false], binding :: bindings
    | [%pat? None] -> [%pat? true], bindings
    | [%pat? _] -> pat, bindings
    | _ ->
      Location.raise_errorf
        ~loc:pat.ppat_loc
        "only variable names, None, Some, _ and aliases are supported in [%%optional ]"
  in
  let { ppat_desc; _ }, bindings = loop pattern [] in
  (* by only using the ppat_desc from the pattern we just generated we ensure that the
     location of the original pattern is kept. *)
  { pattern with ppat_desc }, bindings
;;

let rewrite_case
      ~match_loc
      ~modules
      ~default_module
      { pc_lhs = pat; pc_rhs = body; pc_guard }
  =
  let modules_array = Array.of_list modules in
  let get_module i =
    (* Sadly, we need to be able to handle the case when the length of the matched
       expression doesn't equal the length of the case, in order to produce useful
       error messages (with the proper types). *)
    if i < Array.length modules_array then modules_array.(i) else default_module
  in
  let ppat_desc, bindings =
    match pat.ppat_desc with
    | (Ppat_alias (_, x) | Ppat_var x) when Array.length modules_array > 1 ->
      Location.raise_errorf
        ~loc:pat.ppat_loc
        "this pattern would bind a tuple to the variable %s, which is unsupported in \
         [%%optional ]"
        x.txt
    | Ppat_tuple patts ->
      let patts, bindings =
        List.mapi patts ~f:(fun i patt ->
          let module_ = get_module i in
          get_pattern_and_bindings ~module_ i patt)
        |> List.unzip
      in
      Ppat_tuple patts, List.concat bindings
    | _ ->
      let pat, bindings = get_pattern_and_bindings 0 pat ~module_:(List.hd_exn modules) in
      pat.ppat_desc, bindings
  in
  let pc_lhs = { pat with ppat_desc } in
  let pc_rhs, pc_guard =
    match bindings with
    | [] -> body, pc_guard
    | _ ->
      ( pexp_let ~loc:match_loc Nonrecursive bindings body
      , Option.map pc_guard ~f:(fun pc_guard ->
          pexp_let ~loc:pc_guard.pexp_loc Nonrecursive bindings pc_guard) )
  in
  { pc_lhs; pc_rhs; pc_guard }
;;

(** Take the matched expression and replace all its components by a variable, which will
    have been bound previously, wrapped by [wrapper].
    We do keep the location of the initial component for the new one. *)
let rewrite_matched_expr t ~wrapper =
  let subst_and_wrap i { Matched_expression_element.module_; exp } =
    let loc = { exp.pexp_loc with loc_ghost = true } in
    wrapper ~module_ i (evar ~loc i)
  in
  let pexp_desc =
    match t.elements with
    | [ singleton ] -> (subst_and_wrap 0 singleton).pexp_desc
    | list -> Pexp_tuple (List.mapi list ~f:subst_and_wrap)
  in
  let pexp_loc = { t.original_matched_expr.pexp_loc with loc_ghost = true } in
  { t.original_matched_expr with pexp_desc; pexp_loc }
;;

let real_match t =
  let new_matched_expr =
    rewrite_matched_expr t ~wrapper:(fun ~module_ (_ : int) expr ->
      let loc = expr.pexp_loc in
      eapply ~loc (eis_none ~loc ~module_) [ expr ])
  in
  let modules = List.map t.elements ~f:(fun { module_; _ } -> module_) in
  let cases =
    List.map
      t.cases
      ~f:(rewrite_case ~match_loc:t.match_loc ~modules ~default_module:t.default_module)
  in
  (* we can disable the warning here as we rely on the other match we generate for
     error messages. *)
  disable_all_warnings (pexp_match ~loc:t.match_loc new_matched_expr cases)
;;

(* Split a [Some _ as x] pattern into two, [Some _] and [_ as x]. The latter could just be
   [x], but we err on the side of caution and replace a [Ppat_alias _] with another
   [Ppat_alias _] rather than a [Ppat_var _]. Because this is taking the [Ppat_constr _]
   pattern that was nested inside the alias and turning it into a sibling AST node, they
   should be ghosts. However, we take some care to provide reasonable locations for the
   new AST nodes, such that the left-hand pattern extends from the start of the outermost
   alias to the end of the innermost pattern, and the right-hand pattern extends from the
   start of the alias binding (i.e. [x]) to the end of the outermost alias. *)
let split_fake_alias_pattern lhs ((x, _) as alias) aliases =
  (* [ppat_loc_stack] represents relocations of a pattern by the parser, in particular due
     to nested parentheses. [ppat_loc] is the outermost span, and the stack is ordered
     from outer to inner. [ppat_loc] and [ppat_loc_stack] can thus be viewed as a
     nonempty stack. Here we take a list of locations ordered from inner to outer (i.e.
     reversed) and push them down onto an existing nonempty stack. [merge] is used to
     enforce constraints on the boundaries of the left and right patterns (see above). *)
  let relocate_from_inner_to_outer locs loc loc_stack ~merge =
    List.fold locs ~init:(loc, loc_stack) ~f:(fun ((hd, tl) as acc) loc ->
      let loc =
        { loc_start = merge loc.loc_start hd.loc_start
        ; loc_end = merge loc.loc_end hd.loc_end
        ; loc_ghost = false (* Needed for unused-var check to work on alias patterns. *)
        }
      in
      if Location.compare loc hd = 0 then acc else loc, hd :: tl)
  in
  List.fold
    (alias :: aliases)
    ~init:(lhs, ppat_any ~loc:{ x.loc with loc_ghost = true })
    ~f:(fun (lhs, rhs) (x, pat) ->
      let inner_loc, rev_loc_stack =
        List.fold pat.ppat_loc_stack ~init:(pat.ppat_loc, []) ~f:(fun (hd, tl) loc ->
          loc, hd :: tl)
      in
      let lhs_loc, lhs_loc_stack =
        relocate_from_inner_to_outer
          (inner_loc :: rev_loc_stack)
          lhs.ppat_loc
          lhs.ppat_loc_stack
          ~merge:Location.min_pos
      in
      let rhs_loc, rhs_loc_stack =
        relocate_from_inner_to_outer
          rev_loc_stack
          { inner_loc with loc_start = rhs.ppat_loc.loc_start }
          []
          ~merge:Location.max_pos
      in
      ( { lhs with ppat_loc = lhs_loc; ppat_loc_stack = lhs_loc_stack }
      , { ppat_desc = Ppat_alias (rhs, x)
        ; ppat_loc = rhs_loc
        ; ppat_loc_stack = rhs_loc_stack
        ; ppat_attributes = pat.ppat_attributes
        } ))
;;

(* A "fake" pattern is one which requires a [Foo.t option] expression to be typed
   correctly, effectively only [Ppat_construct _], but we rely on
   [get_pattern_and_bindings] to complain about other unsupported patterns. A "real"
   pattern is one which requires a [Foo.Option.t] expression. Patterns requiring "both"
   must be matched against a [Foo.t option * Foo.Option.t]. Wildcards can be used with
   "any" of the above. We could always generate "both" patterns but it would come at the
   cost of potentially confusing type errors, so we avoid them where possible. *)
let analyze_fake_pattern pattern =
  match pattern.ppat_desc with
  | Ppat_any -> `Any
  | Ppat_var _ -> `Real
  | Ppat_alias (pat, x) ->
    let rec loop pattern alias aliases =
      match pattern.ppat_desc with
      | Ppat_any | Ppat_var _ -> `Real
      | Ppat_alias (pat, x) -> loop pat (x, pattern) (alias :: aliases)
      | _ -> `Both (split_fake_alias_pattern pattern alias aliases)
    in
    loop pat (x, pattern) []
  | _ -> `Fake
;;

let make_fake_pattern_compatible expr_kind patt_kind pattern =
  match expr_kind, patt_kind with
  | `Fake, `Fake | `Real, `Real | _, `Any -> pattern
  | `Both, ((`Fake | `Real | `Both _) as kind) ->
    let wildcard = lazy (ppat_any ~loc:Location.none) in
    let fake, real =
      match kind with
      | `Fake -> pattern, force wildcard
      | `Real -> force wildcard, pattern
      | `Both both -> both
    in
    ppat_tuple ~loc:{ pattern.ppat_loc with loc_ghost = true } [ fake; real ]
  | `Any, (`Fake | `Real | `Both _) | `Fake, (`Real | `Both _) | `Real, (`Fake | `Both _)
    ->
    Location.raise_errorf
      ~loc:pattern.ppat_loc
      "Bug in [%%optional ]: this pattern is incompatible with the corresponding fake \
       expression"
;;

let translate_fake_match_cases cases ~num_exprs =
  let patt_kinds =
    Array.of_list_map cases ~f:(fun { pc_lhs = pat; _ } ->
      match pat.ppat_desc with
      | Ppat_tuple patts -> Array.of_list_map ~f:analyze_fake_pattern patts
      | _ -> [| analyze_fake_pattern pat |])
  in
  let max_num_kinds =
    Array.fold patt_kinds ~init:num_exprs ~f:(fun num_kinds patt_kinds ->
      max num_kinds (Array.length patt_kinds))
  in
  let expr_kinds = Array.create ~len:max_num_kinds `Any in
  (* We need to ensure the fake expression can generate bindings for all of its
     corresponding patterns. *)
  Array.iter patt_kinds ~f:(fun patt_kinds ->
    Array.iteri patt_kinds ~f:(fun e patt_kind ->
      match expr_kinds.(e), patt_kind with
      | `Both, _ | `Fake, `Fake | `Real, `Real | _, `Any -> ()
      | `Any, ((`Fake | `Real) as kind) -> expr_kinds.(e) <- kind
      | `Fake, `Real | `Real, `Fake | _, `Both _ -> expr_kinds.(e) <- `Both));
  let cases =
    List.mapi cases ~f:(fun c ({ pc_lhs = pat; _ } as case) ->
      let patt_kinds = patt_kinds.(c) in
      let make_fake_pattern_compatible e pat =
        make_fake_pattern_compatible expr_kinds.(e) patt_kinds.(e) pat
      in
      let pat =
        match pat.ppat_desc with
        | Ppat_tuple patts ->
          let patts = List.mapi ~f:make_fake_pattern_compatible patts in
          { pat with ppat_desc = Ppat_tuple patts }
        | _ -> make_fake_pattern_compatible 0 pat
      in
      { case with pc_lhs = pat })
  in
  cases, expr_kinds
;;

(* The fake match's aliases have types like [int option] instead of [Int.Option], so we
   match on tuples e.g. [Some (unsafe_value x), x], then rewrite patterns to attach
   aliases and vars to the second element rather than the first. *)
let fake_match t =
  let cases, kinds =
    translate_fake_match_cases t.cases ~num_exprs:(List.length t.elements)
  in
  let new_matched_expr =
    rewrite_matched_expr t ~wrapper:(fun ~module_ i expr ->
      let loc = expr.pexp_loc in
      let fake_option =
        [%expr
           (* This code will never be executed, it is just here so the type checker
              generates nice error messages. *)
          if [%e eis_none ~loc ~module_] [%e expr]
          then None
          else Some ([%e eunsafe_value ~loc ~module_] [%e expr])]
      in
      match kinds.(i) with
      | `Fake -> fake_option
      | `Any | `Real -> expr
      | `Both -> [%expr [%e fake_option], [%e expr]])
  in
  pexp_match ~loc:{ t.match_loc with loc_ghost = true } new_matched_expr cases
;;

let bindings_for_matched_expr matched_expr =
  let bind i expr =
    let loc = { expr.pexp_loc with loc_ghost = true } in
    value_binding ~loc ~pat:(pvar ~loc i) ~expr
  in
  List.mapi matched_expr ~f:(fun i { Matched_expression_element.exp; _ } -> bind i exp)
;;

let expand_match ~match_loc ~(module_ : longident loc option) matched_expr cases =
  let t =
    { default_module = module_scope_of_option module_
    ; original_matched_expr = matched_expr
    ; elements = expand_matched_expr ~module_ matched_expr
    ; match_loc
    ; cases
    }
  in
  let fake_match =
    (* The types in this branch actually match what the user would expect given the source
       code, so we tell merlin to do all its work in here. *)
    Merlin_helpers.focus_expression (fake_match t)
  in
  let real_match =
    (* The types here actually have nothing to do with what's in the source ([bool]
       appears for example), so we tell merlin to avoid that branch. *)
    Merlin_helpers.hide_expression (real_match t)
  in
  let bindings = bindings_for_matched_expr t.elements in
  let loc = { match_loc with loc_ghost = true } in
  pexp_let
    ~loc
    Nonrecursive
    bindings
    (pexp_ifthenelse ~loc (ebool ~loc false) fake_match (Some real_match))
;;

(* We add the indirection instead of directly matching on [pexp_match] when declaring the
   extension because we want more informative error messages than "Extension was not
   translated". *)
let expand_match ~loc ~path:_ ~arg:(module_ : longident loc option) e =
  Ast_pattern.parse
    Ast_pattern.(pexp_match __ __)
    loc
    e
    ~on_error:(fun () ->
      Location.raise_errorf ~loc "[%%optional ] must apply to a match statement")
    (expand_match ~match_loc:e.pexp_loc ~module_)
;;

let optional =
  Extension.declare_with_path_arg
    "optional"
    Extension.Context.expression
    Ast_pattern.(single_expr_payload __)
    expand_match
;;

let () = Driver.register_transformation "optional" ~extensions:[ optional ]
