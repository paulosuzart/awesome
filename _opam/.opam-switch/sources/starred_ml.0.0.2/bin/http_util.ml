open Cohttp_eio

(** Just a empty authz. Copied from cohttp. Needsinvestigation *)
let null_auth ?ip:_ ~host:_ _ = Ok None

(** Effectively calls the https endpoint *)
let https ~authenticator =
  let tls_config = Tls.Config.client ~authenticator () in
  fun uri raw ->
    let host =
      Uri.host uri
      |> Option.map (fun x -> Domain_name.(host_exn (of_string_exn x)))
    in
    Tls_eio.client_of_flow ?host tls_config raw

(** Github uses rel links to indicate the next page. It's better to rely on them instead of keeping a page counter *)
let next_link s =
  Eio.traceln "%s" @@ Http.Header.to_string s;
  match Http.Header.get s "Link" with
  | None -> None
  | Some l ->
      let re = Re2.create_exn "<([^;]+)>; rel=\"next\"" in
      let link =
        try Some (Re2.find_first_exn ~sub:(`Index 1) re l)
        with Re2.Exceptions.Regex_match_failed _ -> None
      in
      link

let fetch apai_url client token =
  Eio.Switch.run @@ fun sw ->
  let headers =
    Http.Header.of_list [ ("Authorization", Format.sprintf "Bearer %s" token) ]
  in
  let resp, body = Client.get ~headers ~sw client (Uri.of_string apai_url) in

  if Http.Status.compare resp.status `OK = 0 then
    Some
      ( Eio.Buf_read.(parse_exn take_all) body ~max_size:max_int,
        next_link resp.headers )
  else None
