(** A lock-free thread-safe [int]eger keyed hash table.

    This is designed for associating thread specific state with threads within a
    domain.

    ⚠️ This is not {i parallelism-safe} — only {i thread-safe} within a single
    domain. *)

type 'v t
(** A lock-free thread-safe [int]eger keyed hash table. *)

val create : unit -> 'v t
(** [create ()] returns a new lock-free thread-safe [int]eger keyed hash table.
    The hash table is automatically resized. *)

val length : 'v t -> int
(** [length t] returns the number of {i bindings} in the hash table [t].

    ⚠️ The returned value may be greater than the number of {i distinct keys} in
    the hash table. *)

val find : 'v t -> int -> 'v
(** [find t k] returns the current binding of [k] in hash table [t], or raises
    [Not_found] if no such binding exists.

    ⚠️ This may use [raise_notrace] for performance reasons. *)

val add : 'v t -> int -> 'v -> unit
(** [add t k v] adds a binding of key [k] to value [v] to the hash table
    shadowing the previous binding of the key [k], if any. *)

val remove : 'v t -> int -> unit
(** [remove t k] removes the most recent existing binding of key [k], if any,
    from the hash table [t] thereby revealing the earlier binding of [k], if
    any. *)
