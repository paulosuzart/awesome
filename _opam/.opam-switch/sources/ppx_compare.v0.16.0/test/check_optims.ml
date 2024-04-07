open Ppx_compare_lib

type enum =
  | A
  | B
  | C

module Compare = struct
  let optim_bool : bool compare = Stdlib.compare
  let optim_char : char compare = Stdlib.compare
  let optim_float : float compare = Stdlib.compare
  let optim_int : int compare = Stdlib.compare
  let optim_int32 : int32 compare = Stdlib.compare
  let optim_int64 : int64 compare = Stdlib.compare
  let optim_nativeint : nativeint compare = Stdlib.compare
  let optim_string : string compare = Stdlib.compare
  let optim_unit : unit compare = Stdlib.compare
  let optim_enum : enum compare = Stdlib.compare
end

module Equal = struct
  let optim_bool : bool equal = Stdlib.( = )
  let optim_char : char equal = Stdlib.( = )
  let optim_float : float equal = Stdlib.( = )
  let optim_int : int equal = Stdlib.( = )
  let optim_int32 : int32 equal = Stdlib.( = )
  let optim_nativeint : nativeint equal = Stdlib.( = )
  let optim_string : string equal = Stdlib.( = )
  let optim_unit : unit equal = Stdlib.( = )
  let optim_enum : enum equal = Stdlib.( = )

  let optim_int64 =
    if Sys.word_size = 32
    then
      (* On 32bits, polymmorphic comparison of int64 values is not specialized *)
      fun _ _ ->
        false
    else (Stdlib.( = ) : int64 equal)
  ;;
end
