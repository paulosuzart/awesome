open Import
open Memo.O

(* Encoded representation of a set of library names + scope *)
module Key : sig
  (* This module implements a bi-directional function between [encoded] and
     [decoded] *)
  type encoded = Digest.t

  module Decoded : sig
    type t = private
      { pps : Lib_name.t list
      ; project_root : Path.Source.t option
      }

    val of_libs : Lib.t list -> t
  end

  (* [decode y] fails if there hasn't been a previous call to [encode] such that
     [encode x = y]. *)
  val encode : Decoded.t -> encoded
  val decode : encoded -> Decoded.t
end = struct
  type encoded = Digest.t

  module Decoded = struct
    (* Values of type type are preserved in a global table between builds, so
       they must not embed values that are not safe to keep between builds, such
       as [Dune_project.t] values *)
    type t =
      { pps : Lib_name.t list
      ; project_root : Path.Source.t option
      }

    let equal x y =
      List.equal Lib_name.equal x.pps y.pps
      && Option.equal Path.Source.equal x.project_root y.project_root
    ;;

    let to_string { pps; project_root } =
      let s = String.enumerate_and (List.map pps ~f:Lib_name.to_string) in
      match project_root with
      | None -> s
      | Some dir ->
        sprintf "%s (in project: %s)" s (Path.Source.to_string_maybe_quoted dir)
    ;;

    let of_libs libs =
      let pps =
        (let compare a b = Lib_name.compare (Lib.name a) (Lib.name b) in
         List.sort libs ~compare)
        |> List.map ~f:Lib.name
      in
      let project =
        List.fold_left libs ~init:None ~f:(fun acc lib ->
          let scope_for_key =
            let info = Lib.info lib in
            let status = Lib_info.status info in
            match status with
            | Private (scope_name, _) -> Some scope_name
            | Installed_private | Public _ | Installed -> None
          in
          Option.merge acc scope_for_key ~f:(fun a b ->
            assert (Dune_project.equal a b);
            a))
      in
      { pps; project_root = Option.map project ~f:Dune_project.root }
    ;;
  end

  (* This mutable table is safe. Even though it can have stale entries remaining
     from previous runs, the entries themselves are correct, so this seems
     harmless apart from the lack of error in [decode] in this situation. *)
  let reverse_table : (Digest.t, Decoded.t) Table.t = Table.create (module Digest) 128

  let encode ({ Decoded.pps; project_root } as x) =
    let y = Digest.generic (pps, project_root) in
    match Table.find reverse_table y with
    | None ->
      Table.set reverse_table y x;
      y
    | Some x' ->
      if Decoded.equal x x'
      then y
      else
        User_error.raise
          [ Pp.textf "Hash collision between set of ppx drivers:"
          ; Pp.textf "- cache : %s" (Decoded.to_string x')
          ; Pp.textf "- fetch : %s" (Decoded.to_string x)
          ]
  ;;

  let decode y =
    match Table.find reverse_table y with
    | Some x -> x
    | None ->
      User_error.raise
        [ Pp.textf
            "I don't know what ppx rewriters set %s correspond to."
            (Digest.to_string y)
        ]
  ;;
end

let pped_module m ~f =
  let open Memo.O in
  let pped = Module.pped m in
  let+ () =
    Module.iter m ~f:(fun ml_kind file ->
      let pp_path =
        Module.file pped ~ml_kind |> Option.value_exn |> Path.as_in_build_dir_exn
      in
      let file = Path.as_in_build_dir_exn (Module.File.path file) in
      f ml_kind file pp_path)
  in
  pped
;;

module Driver = struct
  module M = struct
    module Info = struct
      let name = Sub_system_name.of_string "ppx.driver"

      type t =
        { loc : Loc.t
        ; flags : Ordered_set_lang.Unexpanded.t
        ; as_ppx_flags : Ordered_set_lang.Unexpanded.t
        ; lint_flags : Ordered_set_lang.Unexpanded.t
        ; main : string
        ; replaces : (Loc.t * Lib_name.t) list
        }

      type Sub_system_info.t += T of t

      let loc t = t.loc

      (* The syntax of the driver sub-system is part of the main dune syntax, so
         we simply don't create a new one.

         If we wanted to make the ppx system an extension, then we would create
         a new one. *)
      let syntax = Stanza.syntax

      open Dune_lang.Decoder

      let decode =
        fields
          (let+ loc = loc
           and+ flags = Ordered_set_lang.Unexpanded.field "flags"
           and+ as_ppx_flags =
             Ordered_set_lang.Unexpanded.field
               "as_ppx_flags"
               ~check:(Dune_lang.Syntax.since syntax (1, 2))
           and+ lint_flags = Ordered_set_lang.Unexpanded.field "lint_flags"
           and+ main = field "main" string
           and+ replaces =
             field "replaces" (repeat (located Lib_name.decode)) ~default:[]
           in
           { loc; flags; as_ppx_flags; lint_flags; main; replaces })
      ;;

      let encode t =
        let open Dune_lang.Encoder in
        let lib (_loc, name) = Lib_name.encode name in
        ( (1, 0)
        , record_fields
          @@ [ field_i "flags" Ordered_set_lang.Unexpanded.encode t.flags
             ; field_i "lint_flags" Ordered_set_lang.Unexpanded.encode t.lint_flags
             ; field "main" string t.main
             ; field_l "replaces" lib t.replaces
             ] )
      ;;
    end

    type t =
      { info : Info.t
      ; lib : Lib.t
      ; replaces : t list Resolve.t
      }

    let desc ~plural = "ppx driver" ^ if plural then "s" else ""
    let desc_article = "a"
    let lib t = t.lib
    let replaces t = t.replaces

    let instantiate ~resolve ~get lib (info : Info.t) =
      let open Memo.O in
      let+ replaces =
        Memo.parallel_map info.replaces ~f:(fun ((loc, name) as x) ->
          Resolve.Memo.bind (resolve x) ~f:(fun lib ->
            get ~loc lib
            >>| function
            | Some t -> Resolve.return t
            | None ->
              Resolve.fail
                (User_error.make
                   ~loc
                   [ Pp.textf
                       "%S is not a %s"
                       (Lib_name.to_string name)
                       (desc ~plural:false)
                   ])))
        >>| Resolve.List.all
      in
      { info; lib; replaces }
    ;;

    let public_info t =
      Memo.return
        (let open Resolve.O in
         let+ replaces = t.replaces in
         { Info.loc = t.info.loc
         ; flags = t.info.flags
         ; as_ppx_flags = t.info.as_ppx_flags
         ; lint_flags = t.info.lint_flags
         ; main = t.info.main
         ; replaces =
             List.map2 t.info.replaces replaces ~f:(fun (loc, _) t -> loc, Lib.name t.lib)
         })
    ;;
  end

  include M
  include Sub_system.Register_backend (M)

  (* Where are we called from? *)
  type loc =
    | User_file of Loc.t * (Loc.t * Lib_name.t) list
    | Dot_ppx of Path.Build.t * Lib_name.t list

  let fail loc msg =
    match loc with
    | User_file (loc, _) -> Resolve.fail (User_error.make ~loc [ Pp.text msg ])
    | Dot_ppx (path, pps) ->
      Resolve.fail
        (User_error.make
           ~loc:(Loc.in_file (Path.build path))
           [ Pp.textf
               "Failed to create on-demand ppx rewriter for %s; %s"
               (String.enumerate_and (List.map pps ~f:Lib_name.to_string))
               (String.uncapitalize msg)
           ])
  ;;

  let select libs ~loc =
    let open Memo.O in
    select_replaceable_backend libs ~replaces
    >>| Resolve.bind ~f:(function
      | Ok x -> Resolve.return x
      | Error Selection_error.No_backend_found ->
        let msg =
          match
            List.filter_map libs ~f:(fun lib ->
              match Lib_name.to_string (Lib.name lib) with
              | ("ocaml-migrate-parsetree" | "ppxlib" | "ppx_driver") as s -> Some s
              | _ -> None)
          with
          | [] ->
            let pps =
              match loc with
              | User_file (_, pps) -> List.map pps ~f:snd
              | Dot_ppx (_, pps) -> pps
            in
            sprintf
              "No ppx driver were found. It seems that %s %s not compatible with Dune. \
               Examples of ppx rewriters that are compatible with Dune are ones using \
               ocaml-migrate-parsetree, ppxlib or ppx_driver."
              (String.enumerate_and (List.map pps ~f:Lib_name.to_string))
              (match pps with
               | [ _ ] -> "is"
               | _ -> "are")
          | names ->
            sprintf
              "No ppx driver were found.\nHint: Try upgrading or reinstalling %s."
              (String.enumerate_and names)
        in
        fail loc msg
      | Error (Too_many_backends ts) ->
        fail
          loc
          (sprintf
             "Too many incompatible ppx drivers were found: %s."
             (String.enumerate_and
                (List.map ts ~f:(fun t -> Lib_name.to_string (Lib.name (lib t)))))))
  ;;
end

let ppx_exe (ctx : Build_context.t) ~key =
  Path.Build.relative ctx.build_dir (".ppx/" ^ key ^ "/ppx.exe")
;;

let build_ppx_driver sctx ~scope ~target ~pps ~pp_names =
  let open Memo.O in
  let* driver_and_libs =
    let ( let& ) t f = Resolve.Memo.bind t ~f in
    let& pps = Resolve.Memo.lift pps in
    let& pps = Lib.closure ~linking:true pps in
    Driver.select pps ~loc:(Dot_ppx (target, pp_names))
    >>| Resolve.map ~f:(fun driver -> driver, pps)
    >>| (* Extend the dependency stack as we don't have locations at this
           point *)
    Resolve.push_stack_frame ~human_readable_description:(fun () ->
      Dyn.pp (List [ String "pps"; Dyn.(list Lib_name.to_dyn) pp_names ]))
  in
  (* CR-someday diml: what we should do is build the .cmx/.cmo once and for all
     at the point where the driver is defined. *)
  let dir = Path.Build.parent_exn target in
  let main_module_name = Module_name.of_string_allow_invalid (Loc.none, "_ppx") in
  let module_ = Module.generated ~kind:Impl ~src_dir:dir [ main_module_name ] in
  let* () =
    let ml_source =
      Module.file ~ml_kind:Impl module_ |> Option.value_exn |> Path.as_in_build_dir_exn
    in
    Super_context.add_rule
      sctx
      ~dir
      (Action_builder.write_file_dyn
         ml_source
         (Resolve.read
            (let open Resolve.O in
             let+ driver, _ = driver_and_libs in
             sprintf "let () = %s ()\n" driver.info.main)))
  and* linkages =
    let ctx = Super_context.context sctx in
    let+ ocaml = Context.ocaml ctx in
    [ Exe.Linkage.native_or_custom ocaml ]
  and+ cctx =
    let obj_dir = Obj_dir.for_pp ~dir in
    let requires_compile = Resolve.map driver_and_libs ~f:snd in
    let requires_link = Memo.lazy_ (fun () -> Memo.return requires_compile) in
    let flags = Ocaml_flags.of_list [ "-g"; "-w"; "-24" ] in
    let opaque = Compilation_context.Explicit false in
    let modules = Modules.singleton_exe module_ in
    Compilation_context.create
      ~super_context:sctx
      ~scope
      ~obj_dir
      ~modules
      ~flags
      ~requires_compile:(Memo.return requires_compile)
      ~requires_link
      ~opaque
      ~js_of_ocaml:None
      ~package:None
      ~bin_annot:false
      ()
  in
  let+ (_ : Exe.dep_graphs) =
    let program : Exe.Program.t =
      { name = Filename.remove_extension (Path.Build.basename target)
      ; main_module_name
      ; loc = Loc.none
      }
    in
    Exe.build_and_link ~program ~linkages cctx ~promote:None
  in
  ()
;;

let get_rules sctx key =
  let ctx = Super_context.context sctx in
  let build_context = Context.build_context ctx in
  let exe = ppx_exe build_context ~key in
  let* pp_names, scope =
    match Digest.from_hex key with
    | None ->
      User_error.raise
        [ Pp.textf "invalid ppx key for %s" (Path.Build.to_string_maybe_quoted exe) ]
    | Some key ->
      let { Key.Decoded.pps; project_root } = Key.decode key in
      let+ scope =
        let dir =
          match project_root with
          | None -> Context.build_dir ctx
          | Some dir -> Path.Build.append_source build_context.build_dir dir
        in
        Scope.DB.find_by_dir dir
      in
      pps, scope
  in
  let open Memo.O in
  let* pps =
    let lib_db = Scope.libs scope in
    List.map pp_names ~f:(fun x -> Loc.none, x) |> Lib.DB.resolve_pps lib_db
  in
  build_ppx_driver sctx ~scope ~pps ~pp_names ~target:exe
;;

let gen_rules sctx components =
  match components with
  | [ key ] -> get_rules sctx key
  | _ -> Memo.return ()
;;

let ppx_driver_exe (ctx : Context.t) libs =
  let key = Digest.to_string (Key.Decoded.of_libs libs |> Key.encode) in
  (* Make sure to compile ppx.exe for the compiling host. See: #2252, #2286 and
     #3698 *)
  Context.host ctx >>| Context.build_context >>| ppx_exe ~key
;;

let get_cookies ~loc ~expander ~lib_name libs =
  let open Memo.O in
  let expander, library_name_cookie =
    match lib_name with
    | None -> expander, None
    | Some lib_name ->
      let library_name = Lib_name.Local.to_string lib_name in
      let bindings =
        Pform.Map.singleton (Var Library_name) [ Value.String library_name ]
      in
      ( Expander.add_bindings expander ~bindings
      , Some ("library-name", (library_name, Lib_name.of_local (loc, lib_name))) )
  in
  let+ cookies =
    Memo.List.concat_map libs ~f:(fun t ->
      let info = Lib.info t in
      let kind = Lib_info.kind info in
      match kind with
      | Normal -> Memo.return []
      | Ppx_rewriter { cookies } | Ppx_deriver { cookies } ->
        Memo.List.map cookies ~f:(fun { Lib_kind.Ppx_args.Cookie.name; value } ->
          let+ value = Expander.No_deps.expand_str expander value in
          name, (value, Lib.name t)))
  in
  (match library_name_cookie with
   | None -> cookies
   | Some cookie -> cookie :: cookies)
  |> String.Map.of_list_reducei ~f:(fun name ((val1, lib1) as res) (val2, lib2) ->
    if String.equal val1 val2
    then res
    else (
      let lib1 = Lib_name.to_string lib1 in
      let lib2 = Lib_name.to_string lib2 in
      User_error.raise
        ~loc
        [ Pp.textf
            "%s and %s have inconsistent requests for cookie %S; %s requests %S and %s \
             requests %S"
            lib1
            lib2
            name
            lib1
            val1
            lib2
            val2
        ]))
  |> String.Map.to_list_map ~f:(fun name (value, _) ->
    [ "--cookie"; sprintf "%s=%S" name value ])
  |> List.concat
;;

let ppx_driver_and_flags_internal
  context
  ~dune_version
  ~loc
  ~expander
  ~lib_name
  ~flags
  libs
  =
  let open Action_builder.O in
  let+ flags =
    if dune_version <= (3, 2)
    then Action_builder.List.map ~f:(Expander.expand_str expander) flags
    else
      (* Allow list expansion *)
      Action_builder.List.concat_map flags ~f:(Expander.expand ~mode:Many expander)
      |> Action_builder.map
           ~f:(List.map ~f:(Value.to_string ~dir:(Path.build @@ Expander.dir expander)))
  and+ cookies = Action_builder.of_memo (get_cookies ~loc ~lib_name ~expander libs)
  and+ ppx_driver_exe = Action_builder.of_memo @@ ppx_driver_exe context libs in
  ppx_driver_exe, flags @ cookies
;;

let ppx_driver_and_flags ctx ~lib_name ~expander ~scope ~loc ~flags pps =
  let open Action_builder.O in
  let* libs = Resolve.Memo.read (Lib.DB.resolve_pps (Scope.libs scope) pps) in
  let+ exe, flags =
    let dune_version = Scope.project scope |> Dune_project.dune_version in
    ppx_driver_and_flags_internal ctx ~loc ~expander ~dune_version ~lib_name ~flags libs
  and+ driver =
    let* libs = Resolve.Memo.read (Lib.closure libs ~linking:true) in
    Action_builder.of_memo (Driver.select libs ~loc:(User_file (loc, pps)))
    >>= Resolve.read
  in
  exe, driver, flags
;;

let promote_correction fn build ~suffix =
  let open Action_builder.O in
  let+ act = build in
  Action.Full.reduce
    [ act
    ; Action.Full.make
        (Action.diff
           ~optional:true
           (Path.build fn)
           (Path.Build.extend_basename fn ~suffix))
    ]
;;

let promote_correction_with_target fn build ~suffix =
  Action_builder.progn
    [ build
    ; Action_builder.with_no_targets
        (Action_builder.return
           (Action.Full.make
              (Action.diff
                 ~optional:true
                 (Path.build fn)
                 (Path.Build.extend_basename fn ~suffix))))
    ]
;;

let sandbox_of_setting = function
  | `Set_by_user d | `Default d -> d
;;

let action_for_pp ~sandbox ~loc ~expander ~action ~src =
  let expander =
    let bindings = Pform.Map.singleton (Var Input_file) [ Value.Path (Path.build src) ] in
    Expander.add_bindings expander ~bindings
  in
  let open Action_builder.O in
  Action_builder.path (Path.build src)
  >>> Action_unexpanded.expand_no_targets
        action
        ~chdir:(Expander.context expander |> Context_name.build_dir)
        ~loc
        ~expander
        ~deps:[]
        ~what:"preprocessing actions"
  >>| Action.Full.add_sandbox sandbox
;;

let action_for_pp_with_target ~sandbox ~loc ~expander ~action ~src ~target =
  let action = action_for_pp ~sandbox ~loc ~expander ~action ~src in
  Action_builder.with_stdout_to target action
;;

(* Generate rules for the dialect modules in [modules] and return a a new module
   with only OCaml sources *)
let setup_dialect_rules sctx ~sandbox ~dir ~expander (m : Module.t) =
  let open Memo.O in
  let ml = Module.ml_source m in
  let+ () =
    Module.iter m ~f:(fun ml_kind f ->
      Dialect.preprocess (Module.File.dialect f) ml_kind
      |> Memo.Option.iter ~f:(fun (loc, action) ->
        let src = Path.as_in_build_dir_exn (Module.File.path f) in
        let dst =
          Module.file ml ~ml_kind |> Option.value_exn |> Path.as_in_build_dir_exn
        in
        Super_context.add_rule
          sctx
          ~dir
          (action_for_pp_with_target ~sandbox ~loc ~expander ~action ~src ~target:dst)))
  in
  ml
;;

let add_corrected_suffix_binding expander suffix =
  let bindings = Pform.Map.singleton (Var Corrected_suffix) [ Value.String suffix ] in
  Expander.add_bindings expander ~bindings
;;

let driver_flags expander ~corrected_suffix ~driver_flags ~standard =
  let expander = add_corrected_suffix_binding expander corrected_suffix in
  Expander.expand_and_eval_set expander driver_flags ~standard
;;

let lint_module sctx ~sandbox ~dir ~expander ~lint ~lib_name ~scope =
  let open Action_builder.O in
  let add_alias build =
    Super_context.add_alias_action sctx (Alias.make Alias0.lint ~dir) build ~dir
  in
  let lint =
    Module_name.Per_item.map lint ~f:(function
      | Preprocess.No_preprocessing -> fun ~source:_ ~ast:_ -> Memo.return ()
      | Future_syntax loc ->
        User_error.raise ~loc [ Pp.text "'compat' cannot be used as a linter" ]
      | Action (loc, action) ->
        fun ~source ~ast:_ ->
          Module.iter source ~f:(fun _ (src : Module.File.t) ->
            let src = Path.as_in_build_dir_exn (Module.File.path src) in
            add_alias ~loc (action_for_pp ~sandbox ~loc ~expander ~action ~src))
      | Pps { loc; pps; flags; staged } ->
        if staged
        then
          User_error.raise
            ~loc
            [ Pp.text "Staged ppx rewriters cannot be used as linters." ];
        let corrected_suffix = ".lint-corrected" in
        let ctx = Super_context.context sctx in
        let driver_and_flags =
          Action_builder.memoize
            ~cutoff:
              (Tuple.T3.equal
                 Path.Build.equal
                 (List.equal String.equal)
                 (List.equal String.equal))
            "ppx driver and flags"
            (let* () = Action_builder.return () in
             let* exe, driver, flags =
               ppx_driver_and_flags ctx ~expander ~loc ~lib_name ~flags ~scope pps
             in
             let+ ppx_flags =
               driver_flags
                 expander
                 ~corrected_suffix
                 ~driver_flags:driver.info.lint_flags
                 ~standard:(Action_builder.return [])
             in
             exe, ppx_flags, flags)
        in
        fun ~source ~ast ->
          Module.iter ast ~f:(fun ml_kind src ->
            add_alias
              ~loc
              (promote_correction
                 ~suffix:corrected_suffix
                 (Path.as_in_build_dir_exn
                    (Option.value_exn (Module.file source ~ml_kind)))
                 (let* exe, flags, args = driver_and_flags in
                  let dir = ctx |> Context.build_dir |> Path.build in
                  Command.run'
                    ~dir
                    (Ok (Path.build exe))
                    [ As args
                    ; Command.Ml_kind.ppx_driver_flag ml_kind
                    ; Dep (Module.File.path src)
                    ; As flags
                    ]))))
  in
  Staged.stage
  @@ fun ~(source : Module.t) ~ast ->
  Module_name.Per_item.get lint (Module.name source) ~source ~ast
;;

let pp_one_module
  sctx
  ~lib_name
  ~scope
  ~preprocessor_deps
  ~(lint_module : source:_ -> ast:_ -> unit Memo.t)
  ~sandbox
  ~dir
  ~expander
  (pp : _ Preprocess.Without_future_syntax.t)
  =
  let open Action_builder.O in
  match pp with
  | No_preprocessing ->
    Staged.stage
    @@ fun m ~lint ->
    let open Memo.O in
    let* ast =
      let sandbox = sandbox_of_setting sandbox in
      setup_dialect_rules sctx ~sandbox ~dir ~expander m
    in
    let+ () = Memo.when_ lint (fun () -> lint_module ~ast ~source:m) in
    ast
  | Action (loc, action) ->
    Staged.stage
    @@ fun m ~lint ->
    let open Memo.O in
    let* ast =
      let sandbox = sandbox_of_setting sandbox in
      pped_module m ~f:(fun _kind src dst ->
        let action =
          action_for_pp_with_target ~sandbox ~loc ~expander ~action ~src ~target:dst
        in
        Super_context.add_rule
          sctx
          ~loc
          ~dir
          (let open Action_builder.With_targets.O in
           Action_builder.with_no_targets preprocessor_deps >>> action))
      >>= setup_dialect_rules sctx ~sandbox ~dir ~expander
    in
    let+ () = Memo.when_ lint (fun () -> lint_module ~ast ~source:m) in
    ast
  | Pps { loc; pps; flags; staged } ->
    Staged.stage
    @@
    if staged
    then (
      let dash_ppx_flag =
        let+ args =
          Action_builder.memoize
            ~cutoff:(List.equal String.equal)
            "ppx command"
            (let* exe, driver, flags =
               ppx_driver_and_flags
                 (Super_context.context sctx)
                 ~expander
                 ~loc
                 ~scope
                 ~flags
                 ~lib_name
                 pps
             in
             let* driver_flags =
               Expander.expand_and_eval_set
                 expander
                 driver.info.as_ppx_flags
                 ~standard:(Action_builder.return [ "--as-ppx" ])
             and* () = preprocessor_deps in
             Command.expand_no_targets
               ~dir:(Super_context.context sctx |> Context.build_dir |> Path.build)
               (S [ Dep (Path.build exe); As driver_flags; As flags ]))
        in
        [ "-ppx"; String.quote_list_for_shell args ]
      in
      let pp =
        let sandbox =
          match sandbox with
          | `Set_by_user d -> d
          | `Default _ -> Sandbox_config.no_special_requirements
        in
        Some (dash_ppx_flag, sandbox)
      in
      let sandbox = sandbox_of_setting sandbox in
      fun m ~lint ->
        let open Memo.O in
        let* ast = setup_dialect_rules sctx ~sandbox ~dir ~expander m in
        let+ () = Memo.when_ lint (fun () -> lint_module ~ast ~source:m) in
        Module.set_pp ast pp)
    else (
      let corrected_suffix = ".ppx-corrected" in
      let driver_and_flags =
        Action_builder.memoize
          ~cutoff:
            (Tuple.T3.equal
               Path.Build.equal
               (List.equal String.equal)
               (List.equal String.equal))
          "ppx driver and flags"
          (let* () = Action_builder.return () in
           let* exe, driver, flags =
             ppx_driver_and_flags
               (Super_context.context sctx)
               ~expander
               ~loc
               ~lib_name
               ~flags
               ~scope
               pps
           in
           let+ ppx_flags =
             driver_flags
               expander
               ~corrected_suffix
               ~driver_flags:driver.info.flags
               ~standard:(Action_builder.return [ "--as-ppx" ])
           in
           exe, ppx_flags, flags)
      in
      let sandbox = sandbox_of_setting sandbox in
      fun m ~lint ->
        let open Memo.O in
        let* ast = setup_dialect_rules sctx ~sandbox ~dir ~expander m in
        let* () = Memo.when_ lint (fun () -> lint_module ~ast ~source:m) in
        pped_module ast ~f:(fun ml_kind src dst ->
          Super_context.add_rule
            sctx
            ~loc
            ~dir
            (promote_correction_with_target
               ~suffix:corrected_suffix
               (Path.as_in_build_dir_exn (Option.value_exn (Module.file m ~ml_kind)))
               (Action_builder.with_file_targets
                  ~file_targets:[ dst ]
                  (let open Action_builder.O in
                   preprocessor_deps
                   >>> let* exe, flags, args = driver_and_flags in
                       let dir =
                         Super_context.context sctx |> Context.build_dir |> Path.build
                       in
                       Command.run'
                         ~dir
                         (Ok (Path.build exe))
                         [ As args
                         ; A "-o"
                         ; Path (Path.build dst)
                         ; Command.Ml_kind.ppx_driver_flag ml_kind
                         ; Dep (Path.build src)
                         ; Hidden_deps
                             (Module.source m ~ml_kind
                              |> Option.value_exn
                              |> Module.File.path
                              |> Dep.file
                              |> Dep.Set.singleton)
                         ; As flags
                         ]
                       >>| Action.Full.add_sandbox sandbox)))))
;;

let make
  sctx
  ~dir
  ~expander
  ~lint
  ~preprocess
  ~preprocessor_deps
  ~instrumentation_deps
  ~lib_name
  ~scope
  =
  let preprocessor_deps = preprocessor_deps @ instrumentation_deps in
  let+ ocaml = Context.ocaml (Super_context.context sctx) in
  let preprocess =
    Module_name.Per_item.map preprocess ~f:(fun pp ->
      Preprocess.remove_future_syntax ~for_:Compiler pp ocaml.version)
  in
  let preprocessor_deps, sandbox = Dep_conf_eval.unnamed preprocessor_deps ~expander in
  let sandbox =
    match Sandbox_config.equal Sandbox_config.no_special_requirements sandbox with
    | false -> `Set_by_user sandbox
    | true ->
      let project = Scope.project scope in
      let dune_version = Dune_project.dune_version project in
      `Default
        (if dune_version >= (3, 3) then Sandbox_config.needs_sandboxing else sandbox)
  in
  let preprocessor_deps = Action_builder.memoize "preprocessor deps" preprocessor_deps in
  let lint_module =
    let sandbox = sandbox_of_setting sandbox in
    Staged.unstage (lint_module sctx ~sandbox ~dir ~expander ~lint ~lib_name ~scope)
  in
  Module_name.Per_item.map preprocess ~f:(fun spec ->
    Staged.unstage
    @@ pp_one_module
         sctx
         ~lib_name
         ~scope
         ~preprocessor_deps
         ~lint_module
         ~sandbox
         ~dir
         ~expander
         spec)
  |> Pp_spec.make
;;

let get_ppx_driver ctx ~loc ~expander ~scope ~lib_name ~flags pps =
  let open Action_builder.O in
  let* libs = Resolve.Memo.read (Lib.DB.resolve_pps (Scope.libs scope) pps) in
  let dune_version = Scope.project scope |> Dune_project.dune_version in
  ppx_driver_and_flags_internal ctx ~loc ~expander ~dune_version ~lib_name ~flags libs
;;

let ppx_exe ctx ~scope pp =
  let open Resolve.Memo.O in
  let* libs = Lib.DB.resolve_pps (Scope.libs scope) [ Loc.none, pp ] in
  ppx_driver_exe ctx libs |> Resolve.Memo.lift_memo
;;

let pped_modules_map preprocess v =
  let map =
    Module_name.Per_item.map preprocess ~f:(fun pp ->
      match Preprocess.remove_future_syntax ~for_:Compiler pp v with
      | No_preprocessing -> Module.ml_source
      | Action (_, _) -> fun m -> Module.ml_source (Module.pped m)
      | Pps { loc = _; pps = _; flags = _; staged } ->
        if staged then Module.ml_source else fun m -> Module.pped (Module.ml_source m))
  in
  Staged.stage (fun m -> Module_name.Per_item.get map (Module.name m) m)
;;
