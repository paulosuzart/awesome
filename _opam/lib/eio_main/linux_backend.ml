# 1 "lib_main/linux_backend.enabled.ml"
let run ~fallback fn = Eio_linux.run ~fallback (fun env -> fn (env :> Eio_unix.Stdenv.base))
