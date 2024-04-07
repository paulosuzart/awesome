open Import

type fetch =
  { url : Loc.t * OpamUrl.t
  ; checksum : (Loc.t * Checksum.t) option
  }

type t =
  | External_copy of Loc.t * Path.External.t
  | Fetch of fetch

let remove_locs = function
  | External_copy (_loc, path) -> External_copy (Loc.none, path)
  | Fetch { url = _loc, url; checksum } ->
    Fetch
      { url = Loc.none, url
      ; checksum = Option.map checksum ~f:(fun (_loc, checksum) -> Loc.none, checksum)
      }
;;

let equal a b =
  match a, b with
  | External_copy (loc, path), External_copy (other_loc, other_path) ->
    Loc.equal loc other_loc && Path.External.equal path other_path
  | ( Fetch { url = loc, url; checksum }
    , Fetch { url = other_loc, other_url; checksum = other_checksum } ) ->
    Loc.equal loc other_loc
    && OpamUrl.equal url other_url
    && Option.equal
         (fun (loc, checksum) (other_loc, other_checksum) ->
           Loc.equal loc other_loc && Checksum.equal checksum other_checksum)
         checksum
         other_checksum
  | _ -> false
;;

let to_dyn = function
  | External_copy (_loc, path) ->
    Dyn.variant "External_copy" [ Path.External.to_dyn path ]
  | Fetch { url = _loc, url; checksum } ->
    Dyn.variant
      "Fetch"
      [ Dyn.string (OpamUrl.to_string url)
      ; Dyn.option (fun (_loc, checksum) -> Checksum.to_dyn checksum) checksum
      ]
;;

let fetch_and_hash_archive_cached =
  let cache = Single_run_file_cache.create () in
  fun url ->
    let open Fiber.O in
    Single_run_file_cache.with_ cache ~key:(OpamUrl.to_string url) ~f:(fun target ->
      Fetch.fetch ~unpack:false ~checksum:None ~target url)
    >>| function
    | Ok target -> Some (Dune_digest.file target |> Checksum.of_dune_digest)
    | Error (Checksum_mismatch _) ->
      Code_error.raise "Checksum mismatch when no checksum was provided" []
    | Error (Unavailable message_opt) ->
      let message =
        match message_opt with
        | Some message -> message
        | None ->
          User_message.make
            [ Pp.textf
                "Failed to retrieve source archive from: %s"
                (OpamUrl.to_string url)
            ]
      in
      User_warning.emit_message message;
      None
;;

let compute_missing_checksum_of_fetch
  ({ url = url_loc, url; checksum } as fetch)
  package_name
  ~pinned
  =
  let open Fiber.O in
  match checksum with
  | Some _ -> Fiber.return fetch
  | None when OpamUrl.is_local url || OpamUrl.is_version_control url -> Fiber.return fetch
  | None ->
    if not pinned
       (* No point in warning this about pinned packages. The user explicitly
          asked for the pins *)
    then
      User_message.print
        (User_message.make
           [ Pp.textf
               "Package %S has source archive which lacks a checksum."
               (Package_name.to_string package_name)
           ; Pp.textf
               "The source archive will be downloaded from: %s"
               (OpamUrl.to_string url)
           ; Pp.text "Dune will compute its own checksum for this source archive."
           ]);
    fetch_and_hash_archive_cached url
    >>| Option.map ~f:(fun checksum ->
      { url = url_loc, url; checksum = Some (Loc.none, checksum) })
    >>| Option.value ~default:fetch
;;

let compute_missing_checksum t package_name ~pinned =
  let open Fiber.O in
  match t with
  | External_copy _ -> Fiber.return t
  | Fetch fetch ->
    let+ fetch = compute_missing_checksum_of_fetch fetch package_name ~pinned in
    Fetch fetch
;;

module Fields = struct
  let copy = "copy"
  let fetch = "fetch"
  let url = "url"
  let checksum = "checksum"
end

let decode_fetch =
  let open Decoder in
  let+ url_loc, url = field Fields.url OpamUrl.decode_loc
  and+ checksum = field_o Fields.checksum (located string) in
  let checksum =
    match checksum with
    | None -> None
    | Some ((loc, _) as checksum) ->
      let checksum = Checksum.of_string_user_error checksum |> User_error.ok_exn in
      Some (loc, checksum)
  in
  { url = url_loc, url; checksum }
;;

let decode =
  let open Decoder in
  sum
    [ ( Fields.copy
      , located string
        >>| fun (loc, source) path ->
        External_copy
          ( loc
          , if Filename.is_relative source
            then Path.External.relative path source
            else Path.External.of_string source ) )
    ; ( Fields.fetch
      , let+ fetch = fields decode_fetch in
        fun _ -> Fetch fetch )
    ]
;;

let encode_fetch_field { url = _loc, url; checksum } =
  let open Encoder in
  [ field Fields.url string (OpamUrl.to_string url)
  ; field_o Fields.checksum Checksum.encode (Option.map checksum ~f:snd)
  ]
;;

let encode t =
  let open Encoder in
  match t with
  | External_copy (_loc, path) -> constr Fields.copy string (Path.External.to_string path)
  | Fetch fetch -> named_record_fields Fields.fetch (encode_fetch_field fetch)
;;
