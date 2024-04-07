module Raw = struct
  external max_open_files : unit -> int = "caml_iomux_poll_max_open_files" [@@noalloc]
end

let max_open_files = Raw.max_open_files

let fd_of_unix (fd : Unix.file_descr) = (Obj.magic fd : int)

let unix_of_fd (fd : int) : Unix.file_descr = (Obj.magic fd)
