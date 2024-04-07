# Io Multiplexers for Ocaml

[API ONLINE](https://haesbaert.github.io/ocaml-iomux)

This aims to provide very direct, as in low level bindings to poll(2),
ppoll(2), kevent(2) and epoll(2). At this time just poll(2) and
ppoll(2) are implemented.

## Poll & Ppoll

Poll and ppoll are the second generation of IO multiplexers, they're
mostly the same, but ppoll takes nanoseconds as a timeout and allows
for a list of signals to be masked atomically. Most people will be
happier with poll.

This binding operates by maintaining an opaque buffer of fd slots. You
access the internal buffer via `Poll.set_index`, `Poll.get_fd`,
`Poll.get_revents` etc. These will just fill the pollfd structure at
the given index. It's way easier to grasp this if you read the poll(2)
manpage first.

### Portability

The poll(2) system call first appeared AT&T System V Release 3 UNIX,
it is present "everywhere" and defined in "POSIX.1".

The ppoll(2) is a linux extension but portable enough:
 * OpenBSD added it in OpenBSD 5.4
 * FreeBSD added it in FreeBSD 11.0
 * NetBSD added it in NetBSD 10.0
 * DragonFly added it in DragonFly 4.6
 * Macos **still does NOT have it as of 2023**

Consider using `Poll.ppoll_or_poll` to make things play nicely with
macos.

### Usage

A very basic usage would be something like this. We create a pipe, and
we want to poll for reading on input and writing on output.

```ocaml
let poll = Poll.create () in
let pipe_r, pipe_w = Unix.pipe () in
(* We'll use index 0 for the pipe, and 7 for pipe output, just because.
   First we want to make sure we can write to the pipe without blocking *)
Poll.set_index poll 7 pipe_w Poll.Flags.pollout;
(* Wait why 8 ? we tell the kernel the number of file descriptors to scan,
   unset filedescriptors are skipped, so indexes 1-6 are ignored *)
let nready = Poll.poll poll 8 Nowait in
assert (nready = 1); (* only one entry should be ready, since we added only one *)
let n = Unix.write pipe_w (Bytes.create 1) 0 1 in
assert (n = 1);
(* We'll now poll for both events, note that we don't need to re-add index 7 *)
Poll.set_index poll 0 pipe_r Poll.Flags.pollin;
let nready = Poll.poll poll 8 Nowait in
assert (nready = 2); (* pipe input + pipe output *)
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
```
Should produce:
```
fd 3 (from index 0) can be read without blocking
fd 4 (from index 7) can be written without blocking
```

This interface might look a bit weird, but it does zero allocations per `set`
or `get` and only one block allocation per actual `poll` or `ppoll`.
