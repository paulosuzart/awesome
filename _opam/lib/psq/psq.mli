(* Copyright (c) 2016 David Kaloper Meršinjak. All rights reserved.
   See LICENSE.md *)

(** Functional Priority Search Queues

    [Psq] provides a functional structure that behaves as both a finite map and
    a priority queue.

    {ul
    {- The structure contains a collection of bindings [k -> p], and allows
       efficient {{!S.add}addition}, {{!S.find}lookup} and {{!S.remove}removal}
       of bindings by key.}
    {- It additionally supports {{!S.min}access} to, and {{!S.rest}removal} of
       the binding [k -> p] with the least [p].}}

    The implementation is backed by a weight-balanced semi-heap. Access by key
    is [O(log n)]. Access to the minimal [p] is [O(1)], and its removal is
    [O(log n)].

    {b References}
    {ul
    {- Ralf Hinze.
    {{:https://www.cs.ox.ac.uk/ralf.hinze/publications/ICFP01.pdf} A Simple
    Implementation Technique for Priority Search Queues}. 2001.}}

    {e v0.2.0-7-gb2eb861 — {{:https://github.com/pqwy/psq }homepage}} *)

(** {1 Psq} *)

(** Signature of priority search queues. *)
module type S = sig

  (** {1 Priority Search Queue} *)

  type t
  (** A search queue. *)

  type k
  (** Keys in {{!t}[t]}. *)

  type p
  (** Priorities in {{!t}[t]}. *)

  val empty : t
  (** [empty] is the search queue that contains no bindings. *)

  val sg : k -> p -> t
  (** [sg k p] is the singleton search queue, containing only the
      binding [k -> p]. *)

  val (++) : t -> t -> t
  (** [t1 ++ t2] contains bindings from [t1] and [t2]. If a key [k] is bound in
      both, the result has the binding with lower priority.

      Hence,
      {ul
      {- [t1 ++ t2 = t2 ++ t1]}
      {- [(t1 ++ t2) ++ t3 = t1 ++ (t2 ++ t3)]}} *)

  val is_empty : t -> bool
  (** [is_empty t] is [true] iff [t] is {{!empty}[empty]}. *)

  val size : t -> int
  (** [size t] is the number of distinct bindings in [t]. *)

  (** {1 Access by [k]} *)

  val mem : k -> t -> bool
  (** [find k t] is [true] iff [k] is bound in [t]. *)

  val find : k -> t -> p option
  (** [find k t] is [Some p] if [t] contains the binding [k -> p], or [None]
      otherwise. *)

  val add : k -> p -> t -> t
  (** [add k p t] is [t] with the binding [k -> p].

      Note that [add] does {e not} commute:
      [add k p2 (add k p1 q) <> add k p1 (add k p2 q)] when [p1 <> p2].
      Compare {!push}. *)

  val push : k -> p -> t -> t
  (** [push k p t] is [t] with [k] bound to the lower of [p] and its previous
      priority in [t], if it exists — when [t] contains [k -> p0], the result
      contains [k -> min p0 p], otherwise it contains [k -> p].

      Note that [push] commutes:
      [push k p1 (push k p2 q) = push k p2 (push k p1 q)]. Compare {!add}. *)

  val remove : k -> t -> t
  (** [remove k t] is [t] without any bindings for [k]. *)

  val adjust : k -> (p -> p) -> t -> t
  (** [adjust k f t] is [t] with the binding [k -> p] replaced by [k -> f p].
      When [k] is not bound in [t], the result is [t]. *)

  val update : k -> (p option -> p option) -> t -> t
  (** [update k f t] is [t] with the binding for [k] given by [f].

      When [t] contains a binding [k -> p], the new binding is given by
      [f (Some p)]; otherwise, by [f None].

      When the result of applying [f] is [Some p'], the binding [k -> p'] is
      added to [t]; otherwise, the binding for [k] is removed from [t]. *)

  val split_at : k -> t -> t * t
  (** [split_at k t] splits [t] into [(t0, t1)], such that for all keys [k0] in
      [t0], [k0 <= k], for all keys [k1] in [t1], [k1 > k], and [t = t0 ++ t1].  *)

  (** {1 Access by min [p]} *)

  val min : t -> (k * p) option
  (** [min t] is the binding [Some (k, p)] where [p] is minimal in [t], or
      [None] if [t] is {{!empty}[empty]}.

      When several keys share the minimal priority, [min t] is the binding with
      the smallest key. *)

  val rest : t -> t option
  (** [rest t] is [t] without the binding [min t], or [None]. *)

  val pop : t -> ((k * p) * t) option
  (** [pop t] is [(min t, rest t)], or [None]. *)

  val fold_at_most : p -> (k -> p -> 'a -> 'a) -> 'a -> t -> 'a
  (** [fold_at_most p0 f z q] folds [f] over bindings [k -> p] where [p] is not
      larger than [p0], in key-ascending order. *)

  val iter_at_most : p -> (k -> p -> unit) -> t -> unit
  (** [iter_at_most p0 f q] applies [f] to the bindings [k -> p] where [p] is
      not larger than [p0], in key-ascending order. *)

  val to_seq_at_most : p -> t -> (k * p) Seq.t
  (** [iter_at_most p0 f q] is the sequence of bindings [k -> p] where [p] not
      larger than [p0], in key-ascending order. *)

  (** {1 Aggregate construction} *)

  val of_list : (k * p) list -> t
  (** [of_list kps] is [t] with bindings [kps].

      When [pks] contains multiple priorities for a given [k], the lowest one
      wins. *)

  val of_sorted_list : (k * p) list -> t
  (** [of_sorted_list kps] is [t] with bindings [kps].
      [kps] must contain the bindings in key-ascending order without
      repetitions. When this is not the case, the result is undefined.

      {b Note} When applicable, this operation is faster than
      {{!of_list}[of_list]}. *)

  val of_seq : (k * p) Seq.t -> t
  (** [of_seq kps] is [of_list (List.of_seq kps)]. *)

  val add_seq : (k * p) Seq.t -> t -> t
  (** [of_seq kps t] is [t ++ of_seq kps]. *)

  (** {1 Whole-structure access} *)

  val to_list : t -> (k * p) list
  (** [to_list t] are all the bindings in [t] in key-ascending order. *)

  val to_seq : t -> (k * p) Seq.t
  (** [to_seq t] iterates over bindings in [t] in key-ascending order. *)

  val fold : (k -> p -> 'a -> 'a) -> 'a -> t -> 'a
  (** [fold f z t] is [f k0 p0 (f k1 p1 ... (f kn pn z))], where
      [k0, k1, ..., kn] are in ascending order. *)

  val iter : (k -> p -> unit) -> t -> unit
  (** [iter f t] applies [f] to all bindings in [t] in key-ascending order. *)

  val to_priority_list : t -> (k * p) list
  (** [to_priority_list t] are the bindings in [t] in priority-ascending order.

      {b Note} Priority-ordered traversal is slower than key-ordered traversal. *)

  val to_priority_seq : t -> (k * p) Seq.t
  (** [to_priority_seq t] is the sequence version of [to_priority_list].

      {b Note} For traversing the whole [t], [to_priority_list] is more
      efficient. *)

  val filter : (k -> p -> bool) -> t -> t
  (** [filter p t] is the search queue with exactly the bindings in [t] which
      satisfy the predicate [p]. *)

  val partition : (k -> p -> bool) -> t -> t * t
  (** [partition p t] is [(filter p t, filter np t)] where [np] is the negation
      of [p]. *)

  (** {1 Pretty-printing} *)

  open Format

  val pp : ?sep:(formatter -> unit -> unit) -> (formatter -> k * p -> unit) ->
           formatter -> t -> unit
  (** [pp ?sep pp_kp ppf t] pretty-prints [t] to [ppf], using [pp_kp] to print
      the bindings and [~sep] to separate them.

      [~sep] defaults to {!Format.print_space}. *)

  val pp_dump : (formatter -> k -> unit) -> (formatter -> p -> unit) ->
                formatter -> t -> unit
  (** [pp_dump pp_k pp_f ppf t] is a handier pretty-printer for development. *)

  (**/**)
  (* Debug. *)
  val depth : t -> int
  (**/**)
end

(** Signature of ordered types. *)
module type Ordered = sig
  type t
  val compare : t -> t -> int
  (** [compare] is a total order on {{!t}[t]}. *)
end

(** [Make(K)(P)] is the {{!S}priority search queue} with bindings [K.t -> P.t]. *)
module Make (K: Ordered) (P: Ordered):
  S with type k = K.t and type p = P.t
