open Import

let latest_lang_version =
  Cmd.v
    (Cmd.info "latest-lang-version")
    (let+ () = Term.const () in
     print_endline
       (Dune_lang.Syntax.greatest_supported_version_exn Stanza.syntax
        |> Dune_lang.Syntax.Version.to_string))
;;

let group =
  Cmd.group
    (Cmd.info "internal")
    [ Internal_dump.command; latest_lang_version; Internal_action_runner.group ]
;;
