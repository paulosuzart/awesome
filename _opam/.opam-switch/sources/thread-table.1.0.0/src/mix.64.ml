(* Mixing function proposed by Jon Maiga:

     https://jonkagstrom.com/mx3/mx3_rev2.html

   Note that the mixing function was originally designed for 64-bit unsigned
   integers. *)

let[@inline] int x =
  let x = x lxor (x lsr 32) in
  let x = x * 0xe9846af9b1a615d in
  let x = x lxor (x lsr 32) in
  let x = x * 0xe9846af9b1a615d in
  x lxor (x lsr 28)
