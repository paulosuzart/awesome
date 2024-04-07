(* Mixing function proposed by "TheIronBorn" in a Github issue

     https://github.com/skeeto/hash-prospector/issues/19

   in the repository of Hash Prospector by Chris Wellons.

   Note that the mixing function was originally designed for 32-bit unsigned
   integers. *)

let[@inline] int x =
  let x = x lxor (x lsr 16) in
  let x = x * 0x21f0aaad in
  let x = x lxor (x lsr 15) in
  let x = x * 0x735a2d97 in
  x lxor (x lsr 15)
