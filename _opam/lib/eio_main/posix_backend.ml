# 1 "lib_main/posix_backend.enabled.ml"
let run ~fallback:_ fn = Eio_posix.run (fun env -> fn (env :> Eio_unix.Stdenv.base))
