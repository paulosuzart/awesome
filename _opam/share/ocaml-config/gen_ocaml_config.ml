let () =
  let ocaml_version =
    let v = Sys.ocaml_version in
    let l = String.length v in
    let plus = try String.index v '+' with Not_found -> l in
    (* Introduced in 4.11.0; used from 4.12.0 *)
    let tilde = try String.index v '~' with Not_found -> l in
    String.sub v 0 (min (min plus tilde) l)
  in
  if ocaml_version <> Sys.argv.(1) then
    (Printf.eprintf
       "OCaml version mismatch: %s, expected %s"
       ocaml_version Sys.argv.(1);
     exit 1)
  else
  let oc = open_out (Sys.argv.(2) ^ ".config") in
  let exe = ".exe" in
  let (ocaml, suffix) =
    let s = Sys.executable_name in
    if Filename.check_suffix s exe then
      (Filename.chop_suffix s exe, exe)
    else
      (s, "")
  in
  let ocamlc = ocaml^"c"^suffix in
  let libdir =
    if Sys.command (ocamlc^" -where > where") = 0 then
      (* Must be opened in text mode for Windows *)
      let ic = open_in "where" in
      let r = input_line ic in
      close_in ic; r
    else
      failwith "Bad return from 'ocamlc -where'"
  in
  let stubsdir =
    let ic = open_in (Filename.concat libdir "ld.conf") in
    let rec r acc = try r (input_line ic::acc) with End_of_file -> acc in
    let lines = List.rev (r []) in
    close_in ic;
    let sep = if Sys.os_type = "Win32" then ";" else ":" in
    String.concat sep lines
  in
  let has_native_dynlink =
    let check_dir libdir =
      Sys.file_exists (Filename.concat libdir "dynlink.cmxa")
    in
    List.exists check_dir [Filename.concat libdir "dynlink"; libdir]
  in
  let p fmt = Printf.fprintf oc (fmt ^^ "\n") in
  p "opam-version: \"2.0\"";
  p "variables {";
  p "  native: %b"
    (Sys.file_exists (ocaml^"opt"^suffix));
  p "  native-tools: %b"
    (* The variable [ocamlc] already has a suffix on Windows
       (ex. '...\bin\ocamlc.exe') so we use [ocaml] to check *)
    (Sys.file_exists (ocaml^"c.opt"^suffix));
  p "  native-dynlink: %b"
    has_native_dynlink;
  p "  stubsdir: %S"
    stubsdir;
  p "  preinstalled: false";
  p "  compiler: \"5.1.1\"";
  p "}";
  close_out oc
