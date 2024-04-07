open Printf

let license =
  "Copyright (c) 2010-2012 Martin Jambon\n\
   All rights reserved.\n\n\
   Redistribution and use in source and binary forms, with or without\n\
   modification, are permitted provided that the following conditions\n\
   are met:\n\
   1. Redistributions of source code must retain the above copyright\n\
  \   notice, this list of conditions and the following disclaimer.\n\
   2. Redistributions in binary form must reproduce the above copyright\n\
  \   notice, this list of conditions and the following disclaimer in the\n\
  \   documentation and/or other materials provided with the distribution.\n\
   3. The name of the author may not be used to endorse or promote products\n\
  \   derived from this software without specific prior written permission.\n\n\
   THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR\n\
   IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES\n\
   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.\n\
   IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,\n\
   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT\n\
   NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,\n\
   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY\n\
   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n\
   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF\n\
   THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\n"

let polycat write_one streaming in_file out_file =
  let ic, fname =
    match in_file with `Stdin -> (stdin, "<stdin>") | `File s -> (open_in s, s)
  in
  let oc = match out_file with `Stdout -> stdout | `File s -> open_out s in
  let finally () =
    if oc != stdout then close_out_noerr oc;
    if ic != stdin then close_in_noerr ic
  in
  try
    if streaming then
      Seq.iter (write_one oc) (Yojson.Safe.seq_from_channel ~fname ic)
    else write_one oc (Yojson.Safe.from_channel ~fname ic);
    finally ();
    true
  with e ->
    finally ();
    eprintf "Error:\n";
    (match e with
    | Yojson.Json_error s -> eprintf "%s\n%!" s
    | e -> eprintf "%s\n%!" (Printexc.to_string e));
    false

let cat sort output_biniou std compact streaming in_file out_file =
  if not output_biniou then
    let write_one oc x =
      let x = if sort then Yojson.Safe.sort x else x in
      if compact then Yojson.Safe.to_channel ~std oc x
      else Yojson.Safe.pretty_to_channel ~std oc x;
      output_char oc '\n'
    in
    polycat write_one streaming in_file out_file
  else
    let write_one oc x = output_string oc (Yojson.Safe.to_string x) in
    polycat write_one streaming in_file out_file

let parse_cmdline () =
  let out = ref None in
  let std = ref false in
  let compact = ref false in
  let streaming = ref true in
  let sort = ref false in
  let output_biniou = ref false in
  let options =
    [
      ( "-o",
        Arg.String (fun s -> out := Some s),
        "<file>\n          Output file" );
      ( "-std",
        Arg.Set std,
        "\n\
        \          Convert tuples and variants into standard JSON,\n\
        \          refuse to print NaN and infinities,\n\
        \          require the root node to be either an object or an array." );
      ( "-c",
        Arg.Set compact,
        "\n          Compact output (default: pretty-printed)" );
      ( "-s",
        Arg.Set streaming,
        "\n\
        \          Streaming mode: read and write a sequence of JSON values \
         instead of\n\
        \          just one (default)." );
      ( "-u",
        Arg.Clear streaming,
        "\n\
        \          A single JSON record is expected.\n\
        \          (no longer the default since 1.1.1)" );
      ( "-sort",
        Arg.Set sort,
        "\n          Sort object fields (default: preserve field order)" );
      ("-ob", Arg.Set output_biniou, "Experimental");
      ( "-version",
        Arg.Unit
          (fun () ->
            print_endline Yojson.version;
            exit 0),
        "Print version of yojson and ydump and exit." );
    ]
  in
  let files = ref [] in
  let anon_fun s = files := s :: !files in
  let msg =
    sprintf
      "JSON pretty-printer based on the Yojson library for OCaml\n\n\
       %s\n\n\
       JSON pretty-printer based on the Yojson library for OCaml\n\n\
       Usage: %s [input file]" license Sys.argv.(0)
  in
  Arg.parse options anon_fun msg;
  let in_file =
    match List.rev !files with
    | [] -> `Stdin
    | [ x ] -> `File x
    | _ ->
        eprintf "Too many input files\n%!";
        exit 1
  in
  let out_file = match !out with None -> `Stdout | Some x -> `File x in
  (!sort, !output_biniou, !std, !compact, !streaming, in_file, out_file)

let () =
  let sort, output_biniou, std, compact, streaming, in_file, out_file =
    parse_cmdline ()
  in
  let success = cat sort output_biniou std compact streaming in_file out_file in
  if success then exit 0 else exit 1
