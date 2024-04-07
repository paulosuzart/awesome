open Iomux

exception Fdleak

let _check_raises = Alcotest.check_raises
let _check_string = Alcotest.(check string)
let check_int = Alcotest.(check int)
let check_bool = Alcotest.(check bool)

module U = struct
  let with_leak_checker (f : unit -> unit) () =
    let fetch () =
      let l = List.init (Util.max_open_files () / 2) (fun _ -> Unix.(socket PF_UNIX SOCK_STREAM 0)) in
      List.iter Unix.close l;
      l
    in
    let l1 = fetch () in
    match f () with
    | exception exn -> raise exn
    | () ->
      (* Linux is buggy. In multithreaded programs not always the
         file-descriptor is released immediatelly if it has/have been
         used in another thread. This causes the list to be
         re-ordered, with sometimes one file descriptor showing up
         only later (but it shows up so it's not a leak). So we just
         fetch again. *)
        if (l1 <> fetch ()) && (l1 <> fetch ()) then
          raise Fdleak

  let _coinflip () = Random.bool ()

  let one_second_in_ns = 1000_000_000L
  let hundred_ms_in_ns = 100_000_000L

end

module T = struct

  let basic () =
    let poll = Poll.create ~maxfds:16 () in
    let r, w = Unix.pipe () in
    Poll.set_index poll 0 r Poll.Flags.pollin;
    let b = Bytes.create 1 in
    check_int "write" (Unix.write w b 0 1) 1;
    let nready = Poll.poll poll 1 Nowait in
    check_int "nready" nready 1;
    let fd = Poll.get_fd poll 0 in
    let revents = Poll.get_revents poll 0 in
    check_bool "fd" true (r = fd);
    check_bool "revents" true (Poll.Flags.mem revents Poll.Flags.pollin);
    check_bool "revents-eq" true (revents = Poll.Flags.pollin);
    Unix.close w;
    Unix.close r

  let ppoll_timo () =
    let pollfds = Poll.create () in
    try
      ignore @@ Poll.ppoll pollfds 0 (Nanoseconds U.one_second_in_ns) [];
      check_bool "has_ppoll true" Poll.has_ppoll true
    with
      Unix.Unix_error (Unix.ENOSYS,_,_) ->
      check_bool "has_ppoll false" Poll.has_ppoll false

  let ppoll_or_poll () =
    let poll = Poll.create () in
    let n = Poll.ppoll_or_poll poll 0 Nowait in
    check_int "n is zero" n 0;
    let n = Poll.ppoll_or_poll poll 0 (Nanoseconds U.hundred_ms_in_ns) in
    check_int "n is zero" n 0

  let example () =
    let poll = Poll.create () in
    let pipe_r, pipe_w = Unix.pipe () in
    (* We'll use index 0 for the pipe, and 7 for pipe output, just because.
       First we want to make sure we can write to the pipe without blocking *)
    Poll.set_index poll 7 pipe_w Poll.Flags.pollout;
    (* Wait why 8 ? we tell the kernel the number of file descriptors to scan,
       unset filedescriptors are skipped, so indexes 1-6 are ignored *)
    let nready = Poll.poll poll 8 Nowait in
    check_int "nread 1" 1 nready; (* only one entry should be ready, since we added only one *)
    let n = Unix.write pipe_w (Bytes.create 1) 0 1 in
    check_int "n" 1 n;
    (* We'll now poll for both events, note that we don't need to re-add index 7 *)
    Poll.set_index poll 0 pipe_r Poll.Flags.pollin;
    let nready = Poll.poll poll 8 Nowait in
    check_int "nready" 2 nready;
    Poll.iter_ready poll nready (fun index fd flags ->
        if Poll.Flags.mem flags Poll.Flags.pollin then
          Printf.printf "fd %d (from index %d) can be read without blocking\n%!"
            (Util.fd_of_unix fd) index
        else if Poll.Flags.mem flags Poll.Flags.pollout then
          Printf.printf "fd %d (from index %d) can be written without blocking\n%!"
            (Util.fd_of_unix fd) index
        else
          assert false);
    Unix.close pipe_r;
    Unix.close pipe_w;
    (* clean up *)
    Poll.invalidate_index poll 0;
    Poll.invalidate_index poll 7

  let () =
    let open Alcotest in
    let wlc = U.with_leak_checker in
    run "Iomux" [
      "unit",                  [ test_case "" `Quick (wlc basic) ];
      "ppoll_timo",            [ test_case "" `Quick (wlc ppoll_timo) ];
      "ppoll_or_poll",         [ test_case "" `Quick (wlc ppoll_or_poll) ];
      "example",               [ test_case "" `Quick (wlc example) ];
    ]

end
