module DLS = struct
  let new_key default = ref (default ())
  let get = ( ! )
  let set = ( := )
end
