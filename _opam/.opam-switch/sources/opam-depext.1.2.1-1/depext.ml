(* misc functions *)

let debug = ref false

let cli_2_0 =
  try Sys.getenv "OPAMCLI" = "2.0"
  with Not_found -> false

let lines_of_channel ic =
  let rec aux acc =
    let line = try Some (input_line ic) with End_of_file -> None in
    match line with
    | Some s -> aux (s::acc)
    | None -> acc
  in
  List.rev (aux [])

exception Fatal_error of string * int

let fatal_error ?(exit_code=1) fmt =
  Printf.ksprintf (fun s -> raise (Fatal_error (s, exit_code))) fmt

let lines_of_command c =
  if !debug then Printf.eprintf "+ %s\n%!" c;
  let ic = Unix.open_process_in c in
  let lines = lines_of_channel ic in
  match Unix.close_process_in ic with
  | Unix.WEXITED 0 -> lines
  | Unix.WEXITED 127 ->
    fatal_error "Command not found: %s" c
  | Unix.WEXITED i ->
    fatal_error ~exit_code:i "Command failed: %s returned %d" c i
  | Unix.WSIGNALED i ->
    fatal_error "Command failed: %s signal %d" c i
  | Unix.WSTOPPED i ->
    fatal_error "Command failed: %s stopped %d" c i

let lines_of_file f =
  let ic = open_in f in
  let lines = lines_of_channel ic in
  close_in ic;
  lines

let command_output c =
  match List.filter (fun s -> String.trim s <> "") (lines_of_command c) with
  | [s] -> s
  | _ -> fatal_error "Output of command too long: %S" c

let string_split char str =
  let rec aux pos =
    try
      let i = String.index_from str pos char in
      String.sub str pos (i - pos) :: aux (succ i)
    with Not_found | Invalid_argument _ ->
        let l = String.length str in
        [ String.sub str pos (l - pos) ]
  in
  aux 0

let filter_map f =
  let rec loop acc = function
  | [] -> List.rev acc
  | x :: l ->
      match f x with
      | None -> loop acc l
      | Some x -> loop (x::acc) l
  in loop []

let has_command c =
  let cmd = Printf.sprintf "command -v %s >/dev/null" c in
  try Sys.command cmd = 0 with Sys_error _ -> false

let run_command ?(no_stderr=false) c =
  let c = if no_stderr then c @ ["2>/dev/null"] else c in
  let c = String.concat " " c in
  if !debug then Printf.eprintf "+ %s\n%!" c;
  Unix.system c

let ask ?(default=false) fmt =
  Printf.ksprintf (fun s ->
      Printf.printf "%s [%s] %!" s (if default then "Y/n" else "y/N");
      try match read_line () with
        | "y" | "Y" | "yes" | "Yes" | "yEs" | "yeS" | "YEs" | "yES" | "YeS" | "YES" -> true
        | "n" | "N" | "no" | "nO" | "No" | "NO" -> false
        | _  -> default
      with End_of_file -> false)
    fmt

(* version *)

let opam_version = lazy (
  command_output "opam --version"
)

(* system detection *)

let has_prefix s pfx =
  let pfxlen = String.length pfx in
  pfxlen <= String.length s &&
  try for i = 0 to pfxlen do
      if pfx.[i] <> s.[i] then raise Exit
    done;
    true
  with Exit -> false

let is_opam_2_0 =
  let is = lazy (let v = Lazy.force opam_version in
                 String.length v >= 4 && String.sub (Lazy.force opam_version) 0 4 = "2.0.") in
  fun () -> Lazy.force is

let run_opam f fmt =
  let execute command =
    let opam =
      if is_opam_2_0 () then
        "opam "
      else
        "opam --cli=2.1 "
    in
      f (opam ^ command)
  in
    Printf.ksprintf execute fmt

let lines_of_opam fmt = run_opam lines_of_command fmt

let opam_output fmt = run_opam command_output fmt

let run_opam ?(via=run_command ?no_stderr:None) args =
  let args =
    if is_opam_2_0 () then
      "opam" :: args
    else
      "opam" :: "--cli=2.1" :: args
  in
  via args

let opam_query_global var =
  let opt =
    if is_opam_2_0 () then "" else " --global"
  in
  opam_output "var %s --readonly%s" var opt

let arch = opam_query_global "arch"
let os = opam_query_global "os"
let distribution = opam_query_global "os-distribution"
let family = opam_query_global "os-family"

let opam_vars = [
  "arch", arch;
  "os", os;
  "os-distribution", distribution;
  "os-family", family;
]

(* processing *)

let depexts ~with_tests ~with_docs opam_packages =
  let opam_version = Lazy.force opam_version in
  let recent_enough_opam =
    let newer_beta5 s = s = "" || s.[0] <> '~' || s >= "~beta5" in
    Scanf.sscanf opam_version "%d.%d.%d%s"
      (fun a b c s -> a = 2 && (b > 0 || c > 0 || newer_beta5 s) || a > 2)
  in
  if not recent_enough_opam then
    fatal_error
      "This version of opam-depext requires opam 2.0.0~beta5 or higher";
  let s = lines_of_opam "list --readonly %s%s--external%s"
    (if with_tests then "--with-test " else "")
    (if with_docs then "--with-doc " else "")
    (match opam_packages with
     | [] -> ""
     | ps -> " " ^ Filename.quote ("--resolve=" ^ String.concat "," ps))
  in
  let lines = List.filter (fun s -> String.length s > 0 && s.[0] <> '#') s in
  List.flatten (List.map (string_split ' ') lines)

let install_packages_commands ~interactive packages =
  let yes ?(no=[]) yes r =
    if not interactive then yes @ r else no @ r
  in
  match family with
  | "homebrew" ->
    ["brew"::"install"::packages]
  | "macports" ->
    ["port"::"install"::packages]
  | "debian" ->
    ["apt-get"::"install"::yes ["-qq"; "-yy"] packages]
  | "rhel" | "centos" | "fedora" | "mageia" | "oraclelinux" | "ol" ->
    (* todo: check if they all declare "rhel" as primary family *)
    (* When opem-packages specify the epel-release package, usually it
       means that other dependencies require the EPEL repository to be
       already setup when yum-install is called. Cf. #70, #76. *)
    let epel_release = "epel-release" in
    let install_epel =
      try [
        "yum"::"install"::yes ["-y"] [List.find ((=) epel_release) packages];
      ] with _ -> [] in
    install_epel @
    ["yum"::"install"::yes ["-y"] (List.filter ((<>) epel_release) packages);
     "rpm"::"-q"::"--whatprovides"::packages]
  | "bsd" ->
    if distribution = "freebsd" then ["pkg"::"install"::yes ["-y"] packages]
    else if distribution = "openbsd" then ["pkg_add"::yes ~no:["-i"] ["-I"] packages]
    else ["pkgin"::yes ["-y"] ("install"::packages)]
  | "archlinux" | "arch" ->
    ["pacman"::"-Su"::yes ["--noconfirm"] packages]
  | "gentoo" ->
    ["emerge"::yes ~no:["-a"] [] packages]
  | "alpine" ->
    ["apk"::"add"::yes ~no:["-i"] [] packages]
  | "suse" | "opensuse" ->
    ["zypper"::yes ["--non-interactive"] ("install"::packages)]
  | s ->
    fatal_error "Sorry, don't know how to install packages on your %s system" s

let update_command =
  match family with
  | "debian" ->
     ["apt-get";"update"]
  | "homebrew" ->
     ["brew"; "update"]
  | "rhel" | "centos" | "fedora" | "mageia" | "oraclelinux" | "ol" ->
     ["yum"; "makecache"]
  | "archlinux" | "arch" ->
     ["pacman"; "-Sy"]
  | "gentoo" ->
     ["emerge"; "-u"]
  | "alpine" ->
     ["apk"; "update"]
  | "suse" | "opensuse" ->
     ["zypper"; "--non-interactive"; "update"]
  | _ -> ["echo"; "Skipping system update on this platform."]

exception Signaled_or_stopped of string list * Unix.process_status

module StringMap = Map.Make(String)

(* filter 'packages' to retain only the installed ones *)
let get_installed_packages (packages: string list): string list =
  match family with
  | "homebrew" ->
    let lines = try lines_of_command "brew list" with _ -> [] in
    let installed = List.flatten (List.map (string_split ' ') lines) in
    List.filter (fun p -> List.mem p packages) installed
  | "suse" | "opensuse" ->
    let lines = try lines_of_command "zypper --quiet se -i -t package|grep '^i '|awk -F'|' '{print $2}'|xargs echo" with _ -> [] in
    let installed = List.flatten (List.map (string_split ' ') lines) in
    List.filter (fun p -> List.mem p packages) installed
  | "debian" ->
    (* First query regular package *)
    let cmd =
      (* ${db:Status-Status} would give only the column we're interested in, but
         it's quite new in dpkg-query. *)
      String.concat " "
        ("dpkg-query -W -f '${Package} ${Status}\\n'" :: packages
         @ ["2>/dev/null"])
    in
    let lines = try lines_of_command cmd with _ -> [] in
    let installed =
      List.fold_left
        (fun acc l -> match string_split ' ' l with
           | [pkg;_;_;"installed"] -> pkg :: acc
           | _ -> acc)
        [] lines in
    if List.length installed = List.length packages then installed else
    (* If package are missing look for virtual package. *)
    let missing =
      (* quadratic should not be a problem... *)
      List.filter (fun x -> not (List.mem x installed)) packages in
    let resolve_virtual name =
      let cmd =
        Printf.sprintf "apt-cache --names-only search '^%s$' 2>/dev/null" name in
      let lines = try lines_of_command cmd with _ -> [] in
      List.fold_left
        (fun acc l -> match string_split ' ' l with
           | pkg :: _ -> pkg :: acc
           | [] -> acc)
        [] lines in
    let virtual_map =
      List.fold_left
        (fun acc vpkg ->
           List.fold_left
             (fun acc pkg ->
                let old = try StringMap.find pkg acc with Not_found -> [] in
                StringMap.add pkg (vpkg :: old) acc)
             acc (resolve_virtual vpkg))
        StringMap.empty missing in
    let real_packages = List.map fst (StringMap.bindings virtual_map) in
    let cmd =
      (* ${db:Status-Status} would give only the column we're interested in, but
         it's quite new in dpkg-query. *)
      String.concat " "
        ("dpkg-query -W -f '${Package} ${Status}\\n'" :: real_packages
         @ ["2>/dev/null"])
    in
    let lines = try lines_of_command cmd with _ -> [] in
    List.fold_left
      (fun acc l -> match string_split ' ' l with
         | [pkg;_;_;"installed"] -> (try StringMap.find pkg virtual_map @ acc with Not_found -> acc)
         | _ -> acc)
      installed lines
  | "amzn" | "centos" | "fedora" | "mageia" | "archlinux" | "arch" | "gentoo" | "alpine" | "rhel" | "oraclelinux" | "ol" ->
    let query_command_prefix = match distribution with
      | "amzn" | "centos" | "fedora" | "mageia" | "rhel" | "oraclelinux" | "ol" -> ["rpm"; "-qi"]
      | "archlinux" | "arch" -> ["pacman"; "-Q"]
      | "gentoo" -> ["equery"; "list"]
      | "alpine" -> ["apk"; "info"; "-e"]
      | _ -> fatal_error "Distribution %s is not supported" distribution
    in
    List.filter
      (fun pkg_name ->
         let cmd = query_command_prefix @ [pkg_name] in
         match run_command ~no_stderr:true cmd with
         | Unix.WEXITED 0 -> true (* installed *)
         | Unix.WEXITED 1 -> false (* not installed *)
         | exit_status -> raise (Signaled_or_stopped (cmd, exit_status))
      ) packages
  | "bsd" ->
    (match distribution with
     | "freebsd" ->
       let installed = try lines_of_command "pkg query %n" with _ -> [] in
       List.filter (fun p -> List.mem p packages) installed
     | "openbsd" ->
       let installed = try lines_of_command "pkg_info -mqP" with _ -> [] in
       List.filter (fun p -> List.mem p packages) installed
     | _ -> [])
  | "macports" -> []
  | _ -> []

let sudo_run_command ~su ~interactive cmd =
  let cmd =
    match os, distribution with
    | "openbsd", _ ->
      if Unix.getuid () <> 0 then (
        Printf.printf
          "The following command needs to be run through %S:\n    %s\n%!"
          "doas" (String.concat " " cmd);
        if interactive && not (ask ~default:true "Allow ?") then
          exit 1;
        "doas"::cmd
      ) else cmd
    | ("linux" | "unix" | "freebsd" | "netbsd" | "dragonfly"), _
    | "macos", "macports" ->
      (* not sure about this list *)
      if Unix.getuid () <> 0 then (
        Printf.printf
          "The following command needs to be run through %S:\n    %s\n%!"
          (if su then "su" else "sudo") (String.concat " " cmd);
        if interactive && not (ask ~default:true "Allow ?") then
          exit 1;
        if su then
          ["su"; "root"; "-c"; Printf.sprintf "%S" (String.concat " " cmd)]
        else
          "sudo"::cmd
      ) else cmd
    | _ -> cmd
  in
  run_command cmd

let update ~su ~interactive =
  match sudo_run_command ~su ~interactive update_command with
  | Unix.WEXITED 0 ->
    Printf.eprintf "# OS package update successful\n%!"
  | _ -> fatal_error "OS package update failed"

let install ~su ~interactive = function
  | [] -> ()
  | os_packages ->
    let cmds =
      install_packages_commands ~interactive os_packages
    in
    let is_success r = (r = Unix.WEXITED 0) in
    let ok =
      List.fold_left (fun ok cmd ->
          ok &&
          is_success (sudo_run_command ~su ~interactive cmd))
        true cmds
    in
    if ok then Printf.eprintf "# OS packages installation successful\n%!"
    else fatal_error "OS package installation failed"


(* Command-line handling *)

let checkenv var opt =
  let v = try Unix.getenv var with _ -> "" in
  match v with
  |"true"|"1"|"yes"|"y" -> true
  |"false"|"0"|"no"|"n" -> false
  |_ -> opt

let exec_opam =
  let via args =
    if !debug then Printf.eprintf "+ %s\n%!" (String.concat " " args);
    Unix.execvp "opam" (Array.of_list args)
  in
  run_opam ~via

let main print_flags list short
    debug_arg install_arg update_arg dryrun_arg
    with_tests_arg with_docs_arg
    su_arg interactive_arg opam_args opam_packages =
  let with_tests_arg = checkenv "OPAMWITHTEST" with_tests_arg in
  let with_docs_arg = checkenv "OPAMWITHDOC" with_docs_arg in
  if debug_arg then debug := true;
  if not (is_opam_2_0 () || cli_2_0)  then
    Printf.eprintf
      "You are using opam 2.1+, where external dependency handling has been \
       integrated: consider calling opam directly, the 'depext' plugin \
       interface is provided for backwards compatibility only\n";
  if print_flags then
    (if short then
       List.iter (fun (v,x) -> Printf.eprintf "%s=%s\n" v x) opam_vars
     else
       Printf.eprintf "# Depexts vars detected on this system: %s\n%!"
         (String.concat ", " (List.map (fun (v,x) -> v^"="^x) opam_vars));
     exit 0);
  if not short then
    Printf.eprintf "# Detecting depexts using vars: %s\n%!"
      (String.concat ", " (List.map (fun (v,x) -> v^"="^x) opam_vars));
  let os_packages =
    depexts ~with_tests:with_tests_arg ~with_docs:with_docs_arg opam_packages
  in
  if os_packages <> [] && not short then
    begin
      prerr_endline "# The following system packages are needed:";
      Printf.printf "%s\n%!" (String.concat "\n" os_packages)
    end
  else if list && not short then
    prerr_endline "# No required system packages found";
  if list then exit 0;
  if os_packages = [] && not short then
    Printf.eprintf "# No extra OS packages requirements found.\n%!";
  let interactive = match interactive_arg with
    | Some i -> i
    | None -> not (List.mem "--yes" opam_args) && Unix.isatty Unix.stdin
  in
  if not (is_opam_2_0 ()) then
    let opam_run_args =
      (if interactive then [] else ["--confirm-level=unsafe-yes"])
      @ (if dryrun_arg then ["--dry-run"] else [])
    in
    let opam_install_args =
      opam_args
      @ (if with_tests_arg then ["--with-test"] else [])
      @ (if with_docs_arg then ["--with-doc"] else [])
      @ opam_run_args
    in
    (let opam_packages =
       let toreinstall =
         let pending =
           filter_map (fun nv ->
             match string_split '.' nv with
             | n::_ -> Some n
             | _ -> None) (lines_of_opam "reinstall --list-pending")
         in
         let pin = lines_of_opam ("pin list --short") in
         List.filter (fun p -> not (List.mem p pin)) pending
       in
       opam_packages @ toreinstall
     in
     if opam_packages <> [] then
       (if update_arg then
          (match run_opam ("update" :: "--depexts" :: opam_run_args) with
           | Unix.WEXITED 0 ->
             Printf.eprintf "# OS package update successful\n%!"
           | _ -> fatal_error "OS package update failed");
        let opam_cmdline =
          let opam_install =
            "install" :: opam_packages @ opam_install_args
          in
          if install_arg then opam_install else
          if interactive &&
             not (ask ~default:true "Allow installing depexts via opam ?") then
            exit 1
          else
            opam_install @ ["--depext-only"]
        in
        ignore (exec_opam opam_cmdline)))
  else
    (let installed = get_installed_packages os_packages in
     let os_packages =
       List.filter (fun p -> not (List.mem p installed)) os_packages
     in
     if short then List.iter print_endline os_packages
     else if installed <> [] then
       if os_packages <> [] then
         Printf.eprintf
           "# The following new OS packages need to be installed: %s\n%!"
           (String.concat " " os_packages)
       else
         Printf.eprintf
           "# All required OS packages found.\n%!";
     if dryrun_arg then exit (if os_packages = [] then 0 else 1);
     let su = su_arg || not (has_command "sudo") in
     if (os_packages <> [] || opam_packages = []) && update_arg then
       update ~su ~interactive;
     install ~su ~interactive os_packages;
     let opam_cmdline = "install":: opam_args @ opam_packages in
     if install_arg && opam_packages <> [] then
       ((if not short then
           Printf.eprintf "# Now letting opam install the packages\n%!");
        let opam_cmdline =
          opam_cmdline @ (if with_tests_arg then ["--with-test"] else [])
          @ (if with_docs_arg then ["--with-doc"] else [])
        in
        ignore (exec_opam opam_cmdline)))

open Cmdliner

let packages_arg =
  Arg.(value & pos_all string [] &
       info ~docv:"PACKAGES"
         ~doc:"opam packages to install external dependencies for. \
               All installed packages if omitted" [])

let print_flags_arg =
  Arg.(value & flag &
       info ~doc:"Only display the inferred \"depexts\" variables" ["flags"])

let list_arg =
  Arg.(value & flag &
       info ~doc:"Only list the system packages needed" ["l";"list"])

let short_arg =
  Arg.(value & flag &
       info ~doc:"Only output the raw item lists" ["s";"short"])

let debug_arg =
  Arg.(value & flag &
       info ~doc:"Print commands that are run by the program" ["d";"debug"])

let update_arg =
  Arg.(value & flag &
       info ~doc:"Update the OS package sets before installation" ["u";"update"])

let install_arg =
  Arg.(value & flag &
       info ~doc:"Install the packages through \"opam install\" after \
                  installing external dependencies" ["i";"install"])

let su_arg =
  Arg.(value & flag &
       info ~doc:"Attempt 'su' rather than 'sudo' when requiring root rights"
         ["su"])

let interactive_arg =
  Arg.(value & vflag None [
      Some true, info
        ~doc:"Run the system package manager interactively (default if run \
              from a tty and $(i,--yes) was not also specified)"
        ["interactive";"I"];
      Some false, info
        ~doc:"Run the system package manager non-interactively \
              (default when not running from a tty)"
        ["noninteractive"];
    ])

let with_tests_arg =
  Arg.(value & flag &
    info ~doc:"Install test dependencies" ["with-test";"t"])

let with_docs_arg =
  Arg.(value & flag &
    info ~doc:"Install doc dependencies" ["with-doc"])

let dryrun_arg =
  Arg.(value & flag &
       info ~doc:"Only list the new system packages that would need to be \
                  installed, don't try to install them. Exits with 0 if all \
                  required system packages are already installed, 1 \
                  otherwise."
         ["n";"dry-run"])

let opam_args =
  let docs = "OPAM OPTIONS" in
  let flags =
    List.map
      (fun (fs,env) ->
         let term = Arg.(value & flag_all & info ?env ~docs fs) in
         Term.(pure (List.map (fun _ -> "--"^List.hd fs))
               $ term))
      [ ["verbose";"v"], (Some (Arg.env_var "OPAMVERBOSE" ~doc:"Force a verbose session"));
        ["yes";"y"], (Some (Arg.env_var "OPAMYES" ~doc:"Force a non-interactive session"))]
  in
  let options =
    List.map
      (fun fs ->
         let term = Arg.(value & opt_all string [] & info ~docs fs) in
         Term.(pure (List.map (Printf.sprintf "--%s=%s" (List.hd fs)))
               $ term))
      [ ["jobs";"j"] ]
  in
  List.fold_left (fun acc t ->
      Term.(pure (@) $ acc $ t))
    Term.(pure []) (flags @ options)

let command =
  let man = [
    `S "DESCRIPTION";
    `P "$(b,opam-depext) is a simple program intended to facilitate the \
        interaction between opam packages and the host package management \
        system. It can perform OS and distribution detection, query opam for \
        the right external dependencies on a set of packages, and call the OS \
        package manager in the appropriate way to install then.";
    `S "OPAM OPTIONS";
    `P "These options are passed through to the child opam process when used \
        in conjunction with the $(i,-i) flag. Additionally, $(i,--yes) implies \
        $(i,--noninteractive) unless $(i,--interactive) was made explicit.";
    `S "COPYRIGHT";
    `P "$(b,opam-depext) is written by Louis Gesbert \
        <louis.gesbert@ocamlpro.com>, copyright OCamlPro 2014-2021 with \
        contributions from David Allsopp, Raja Boujbel, Kate Deplaix, \
        Anil Madhavapeddy, distributed under the terms of \
        the LGPL v2.1 with linking exception. Full source available at \
        $(i,https://github.com/ocaml/opam-depext)";
    `S "BUGS";
    `P "Bugs are tracked at $(i,https://github.com/ocaml/opam-depext/issues) \
        or can be reported to $(i,<opam-devel@lists.ocaml.org>).";
  ] in
  let doc = "Query and install external dependencies of opam packages" in
  Term.(pure main $ print_flags_arg $ list_arg $ short_arg $
        debug_arg $ install_arg $ update_arg $ dryrun_arg $
        with_tests_arg $ with_docs_arg $
        su_arg $ interactive_arg $ opam_args $
        packages_arg),
  Term.info "opam-depext" ~version:"1.2.1" ~doc ~man

let () =
  Sys.catch_break true;
  Unix.putenv "OPAMCLI" "2.0";
  try
    match Term.eval ~catch:false command with
    | `Ok () | `Version | `Help -> exit 0
    | `Error (`Parse | `Term) -> exit 2
    | `Error `Exn -> exit 1
  with
  | Sys.Break ->
    prerr_endline "Interrupted.";
    exit 130
  | Fatal_error (m, exit_code) ->
    prerr_endline m;
    exit exit_code
