open Import

let pp_with_ocamlc env ~ocamlc pp_file dump_file =
  let open Dune_engine in
  let open Fiber.O in
  let+ () =
    Process.run
      ~display:!Clflags.display
      ~env
      Strict
      ocamlc
      [ "-stop-after"; "parsing"; "-dsource"; Path.to_string pp_file; "-dump-into-file" ]
  in
  match Path.stat dump_file with
  | Ok { st_kind = S_REG; _ } ->
    Io.cat dump_file;
    Path.unlink_no_err dump_file
  | _ ->
    User_error.raise [ Pp.textf "cannot find a dump file: %s" (Path.to_string dump_file) ]
;;

let files_for_source file dialects =
  let base, ext = Path.split_extension file in
  let dialect, kind =
    match Dune_rules.Dialect.DB.find_by_extension dialects ext with
    | None -> User_error.raise [ Pp.textf "unsupported extension: %s" ext ]
    | Some x -> x
  in
  let pp_file_base = Path.extend_basename base ~suffix:ext in
  let pp_file =
    match Dune_rules.Dialect.ml_suffix dialect kind with
    | None -> pp_file_base
    | Some suffix -> Path.extend_basename pp_file_base ~suffix
  in
  let dump_file =
    Path.set_extension
      pp_file
      ~ext:
        (match kind with
         | Intf -> ".cmi.dump"
         | Impl -> ".cmo.dump")
  in
  pp_file, dump_file
;;

let get_pped_file super_context file =
  let open Memo.O in
  let context = Super_context.context super_context in
  let in_build_dir file =
    file |> Path.to_string |> Path.Build.relative (Context.build_dir context)
  in
  let file_in_build_dir =
    if String.is_empty file
    then User_error.raise [ Pp.textf "No file given." ]
    else Path.of_string file |> in_build_dir |> Path.build
  in
  let pp_file = file_in_build_dir |> Path.map_extension ~f:(fun ext -> ".pp" ^ ext) in
  Build_system.file_exists pp_file
  >>= function
  | true ->
    let* project = Source_tree.root () >>| Source_tree.Dir.project in
    let dialects = Dune_project.dialects project in
    let pp_file, dump_file = files_for_source pp_file dialects in
    let+ () = Build_system.build_file pp_file in
    Ok (pp_file, dump_file)
  | false ->
    Build_system.file_exists file_in_build_dir
    >>= (function
     | true ->
       let* dir =
         Source_tree.nearest_dir (Path.Source.of_string file)
         >>| Source_tree.Dir.path
         >>| Path.source
       in
       let* dune_file = Dune_rules.Dune_load.stanzas_in_dir (dir |> in_build_dir) in
       let* staged_pps =
         match dune_file with
         | None -> Memo.return None
         | Some dune_file ->
           Dune_file.find_stanzas dune_file Dune_rules.Library.key
           >>| List.fold_left ~init:None ~f:(fun acc (lib : Dune_rules.Library.t) ->
             let preprocess =
               Dune_rules.Preprocess.Per_module.(
                 lib.buildable.preprocess |> single_preprocess)
             in
             match preprocess with
             | Dune_rules.Preprocess.Pps ({ staged = true; _ } as pps) -> Some pps
             | _ -> acc)
       in
       (match staged_pps with
        | None ->
          let+ () = Build_system.build_file file_in_build_dir in
          Error file_in_build_dir
        | Some { loc; _ } ->
          User_error.raise ~loc [ Pp.text "staged_pps are not supported." ])
     | false ->
       User_error.raise
         [ Pp.textf "%s does not exist" (Path.to_string_maybe_quoted file_in_build_dir) ])
;;

let term =
  let+ builder = Common.Builder.term
  and+ context_name = Common.context_arg ~doc:"Build context to use."
  and+ _ = Describe_lang_compat.arg
  and+ file = Arg.(required & pos 0 (some string) None (Arg.info [] ~docv:"FILE")) in
  let common, config = Common.init builder in
  Scheduler.go ~common ~config
  @@ fun () ->
  let open Fiber.O in
  let* setup = Import.Main.setup () in
  let* setup = Memo.run setup in
  let super_context = Import.Main.find_scontext_exn setup ~name:context_name in
  Build_system.run_exn
  @@ fun () ->
  let open Memo.O in
  let* result = get_pped_file super_context file in
  match result with
  | Error file -> Io.cat file |> Memo.return
  | Ok (pp_file, dump_file) ->
    let* ocamlc =
      let+ ocaml = Context.ocaml (Super_context.context super_context) in
      ocaml.ocamlc
    in
    let* env = Super_context.context_env super_context in
    pp_with_ocamlc env ~ocamlc pp_file dump_file |> Memo.of_non_reproducible_fiber
;;

let command =
  let doc = "Build a given FILE and print the preprocessed output." in
  let info = Cmd.info ~doc "pp" in
  Cmd.v info term
;;
