open Cohttp_eio

let () = Logs.set_reporter (Logs_fmt.reporter ())

and () =
  (* The eio backend does not leverage domains yet, but might in the near future *)
  Logs_threaded.enable ()

and () = Logs.Src.set_level Cohttp_eio.src (Some Debug)

let () =
  Eio_main.run @@ fun env ->
  let client = Client.make ~https:None env#net in
  Eio.Switch.run @@ fun sw ->
  let resp, body = Client.get ~sw client (Uri.of_string "http://example.com") in
  if Http.Status.compare resp.status `OK = 0 then
    print_string @@ Eio.Buf_read.(parse_exn take_all) body ~max_size:max_int
  else Fmt.epr "Unexpected HTTP status: %a" Http.Status.pp resp.status
