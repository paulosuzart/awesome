ppx_pipebang
============

A ppx rewriter that inlines the reverse application operator `|>`.

`ppx_pipebang` rewrites `x |> f` as `f x`, regardless of whether `|>` has been redefined.

This inlining is mostly done for historical reasons but it also allows `f` to have
optional arguments (like `Option.value_exn`).
