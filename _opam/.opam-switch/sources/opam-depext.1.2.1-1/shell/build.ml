module OCaml_version : sig
   type t
   val v : ?patch:int -> ?extra:string -> int -> int -> t
   val to_string : t -> string
   val of_string : string -> t
   val compare : t -> t -> int
   val t : t  
   module Since : sig
     val bytes: t
   end
   module Has : sig
     val bytes : t -> bool
   end
end = struct
   type t = { major: int; minor: int; patch: int option; extra: string option }

   let v ?patch ?extra major minor = { major; minor; patch; extra }

   let to_string = function
     |{major;minor;patch=None;extra=None} -> Printf.sprintf "%d.%d" major minor
     |{major;minor;patch=Some patch;extra=None} -> Printf.sprintf "%d.%d.%d" major minor patch
     |{major;minor;patch=Some patch;extra=Some extra} -> Printf.sprintf "%d.%d.%d+%s" major minor patch extra
     |{major;minor;patch=None;extra=Some extra} -> Printf.sprintf "%d.%d+%s" major minor extra
    	
   let parse s =
     try Scanf.sscanf s "%d.%d.%d+%s" (fun major minor patch extra -> v ~patch ~extra major minor)
     with End_of_file | Scanf.Scan_failure _ -> begin
       try Scanf.sscanf s "%d.%d+%s" (fun major minor extra -> v ~extra major minor)
       with End_of_file | Scanf.Scan_failure _ -> begin
         try Scanf.sscanf s "%d.%d.%d" (fun major minor patch -> v ~patch major minor)
         with End_of_file | Scanf.Scan_failure _ -> begin
           Scanf.sscanf s "%d.%d" (fun major minor -> v major minor)
         end
       end
     end

   let of_string s =
     try parse s with
     | exn ->
        raise (Invalid_argument (Printf.sprintf "Unable to parse OCaml version '%s'" s))

   let ( ++ ) x fn =
     match x with
     | 0 -> fn ()
     | r -> r

   let compare {major; minor; patch; extra} a =
    compare major a.major ++ fun () ->
    compare minor a.minor ++ fun () ->
    compare patch a.patch ++ fun () ->
    compare extra a.extra

   let t = of_string Sys.ocaml_version

   module Since = struct
     let bytes = of_string "4.03.0"
   end

   module Has = struct
     let bytes v =
       match compare Since.bytes v with
       |(-1) | 0 -> true
       |n -> false
   end

   let test () =
     let vers = [ "3.12.1";"3.12";"4.00.1";"4.01.0+dev-foo";"4.04.0"; "4.04+additional"; "4.05"; "4.05.0+flambda"] in
     let vers_t = List.map parse vers in
     let ts = List.map parse vers in
     List.iter prerr_endline (List.map to_string ts);
     List.iter (fun v -> Printf.eprintf "%s compared to %s: %d\n%!" (to_string t) (to_string v) (compare t v)) vers_t
end

let build_bytecode () =
  print_endline "ocamlc -I src_ext/lib unix.cma cmdliner.cma -o opam-depext depext.ml"

let build_native () =
  print_endline "ocamlopt -I src_ext unix.cmxa cmdliner.cmxa -o opam-depext depext.ml"

let usage () =
  Printf.eprintf "Usage: ocaml build.ml [byte|native]\n\nDefaults to 'native' build.\n%!";
  exit 1

let _ =
  match Sys.argv with
  | [| _; "byte" |] -> build_bytecode ()
  | [| _; "native" |] | [| _ |] -> build_native ()
  | _ -> usage ()
