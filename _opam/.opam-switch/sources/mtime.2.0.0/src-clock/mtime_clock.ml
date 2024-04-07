(*---------------------------------------------------------------------------
   Copyright (c) 2017 The mtime programmers. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
  ---------------------------------------------------------------------------*)

(* Raw interface *)

external elapsed_ns : unit -> int64 = "ocaml_mtime_clock_elapsed_ns"
external now_ns : unit -> int64 = "ocaml_mtime_clock_now_ns"
external period_ns : unit -> int64 option = "ocaml_mtime_clock_period_ns"

let () = ignore (elapsed_ns ()) (* Initalize elapsed_ns's origin. *)

(* Monotonic clock *)

let elapsed () = Mtime.Span.of_uint64_ns (elapsed_ns ())
let now () = Mtime.of_uint64_ns (now_ns ())
let period () = Mtime.Span.unsafe_of_uint64_ns_option (period_ns ())

(* Counters *)

type counter = int64
let counter = elapsed_ns
let count c = Mtime.Span.of_uint64_ns (Int64.sub (elapsed_ns ()) c)

(*---------------------------------------------------------------------------
   Copyright (c) 2017 The mtime programmers

   Permission to use, copy, modify, and/or distribute this software for any
   purpose with or without fee is hereby granted, provided that the above
   copyright notice and this permission notice appear in all copies.

   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
   WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
   MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
   ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  ---------------------------------------------------------------------------*)
