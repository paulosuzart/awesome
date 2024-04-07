open Cohttp_eio
include Util
include Http_util

let () = Logs.set_reporter (Logs_fmt.reporter ())
and () = Logs_threaded.enable ()

let () =
  Eio_main.run @@ fun env ->
  Mirage_crypto_rng_eio.run (module Mirage_crypto_rng.Fortuna) env @@ fun () ->
  let client =
    Client.make ~https:(Some (https ~authenticator:null_auth)) env#net
  in
  let t =
    try Sys.getenv "TOKEN"
    with Not_found ->
      Eio.traceln "You need to provide a TOKEN env";
      raise Not_found
  in

  let rec fetch_github l acc =
    match fetch l client t with
    | Some (r, Some n) -> fetch_github n (Github.from_string r @ acc)
    | Some (r, None) -> Github.from_string r @ acc
    | None -> []
  in
  let content =
    fetch_github "https://api.github.com/user/starred?per_page=100" []
  in
  Eio.Stdenv.stdout env |> Eio.Flow.copy_string @@ print_content content
