[API reference](https://ocaml-multicore.github.io/thread-table/doc/thread-table/Thread_table/index.html)

# **thread-table** &mdash; A lock-free thread-safe integer keyed hash table

A minimalist lock-free thread-safe integer keyed hash table with zero
synchronization overhead on lookups designed for associating thread specific
state with threads within a domain.

⚠️ This is not _parallelism-safe_ &mdash; only _thread-safe_ within a single
domain.
