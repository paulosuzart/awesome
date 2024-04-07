(** A scheduler independent blocking mechanism.

    This is designed as a low level mechanism intended for writing higher level
    libraries that need to block in a scheduler friendly manner.

    A library that needs to suspend and later resume the current thread of
    execution may simply call {!prepare_for_await} to obtain a pair of [await]
    and [release] operations for the purpose.

    To provide an efficient and scheduler friendly implementation of the
    mechanism, schedulers may install an implementation by wrapping the
    scheduler main loop with a call to {!using}.  The implementation is then
    stored in a domain, and optionally thread, local variable.  The overhead
    that this imposes on a scheduler should be insignificant.

    An application can the choose to use schedulers that provide the necessary
    implementation.  An implementation that works with plain domains and threads
    is provided as a default.

    The end result is effective interoperability between schedulers and
    concurrent programming libraries. *)

(** {1 Interface for blocking} *)

type t = {
  release : unit -> unit;
      (** [t.release ()] resumes the corresponding caller of [t.await ()] or
          does nothing in case the corresponding [t.await ()] has already
          resumed or the target fiber has been canceled.

          {b NOTE}: An implementation of [t.release ()] should never fail. *)
  await : unit -> unit;
      (** [t.await ()] suspends the caller at most until [t.release ()] is
          called. *)
}
(** Represents an asynchronous trigger.

    {b NOTE}: {!release} and {!await} should be parallelism-safe and ideally
    optimized with the assumption that {!release} may be called multiple times
    and even before {!await} is called.  Furthermore, {!await} may be called at
    most once. *)

val prepare_for_await : unit -> t
(** [prepare_for_await ()] prepares and returns a trigger [t] for at most one
    use of [t.await ()] by calling the [prepare] function registered for the
    current domain.

    {!prepare_for_await} and {!t.await} are allowed to raise an (unspecified)
    exception that indicates that the caller's fiber has been canceled (and
    should terminate).  If an exception is raised, then the caller should
    perform whatever cleanup is necessary to e.g. avoid space leaks.

    {b NOTE}: It is allowed for two different calls of [prepare_for_await] to
    return the same trigger and e.g. share a single trigger per domain or per
    fiber or even just have one single trigger. *)

(** {1 Interface for schedulers} *)

val using : prepare_for_await:(unit -> t) -> while_running:(unit -> 'a) -> 'a
(** [using ~prepare_for_await ~while_running] registers the given asynchronous
    trigger mechanism for the current domain, or, if the domain has been
    configured to use {!per_thread} schedulers, the current systhread, for the
    duration of running the given scheduler.  In other words, this sets the
    implementation of {!prepare_for_await} for blocking under the scheduler.

    {b NOTE}: The given [prepare_for_await] function is called every time
    {!prepare_for_await} is called while the scheduler is running.

    {b NOTE}: This is normally only called by libraries that implement
    schedulers and the specified [prepare_for_await] typically returns a trigger
    mechanism {!t} that tightly integrates with the scheduler by e.g. performing
    an effect to suspend the current fiber when {!t.await} is called. *)

(** {2 Per thread configuration} *)

include module type of Thread_intf

val per_thread : (module Thread) -> unit
(** [per_thread (module Thread)] configures the current domain to store and
    select the trigger mechanism per systhread.  This can be called at most once
    per domain before any calls to {!prepare_for_await}.

    The reason why this is an opt-in feature is that this allows domain local
    await to be implemented without depending on [Thread] which also depends on
    [Unix].

    Usage:

    {[
      Domain.spawn @@ fun () ->
        Domain_local_await.per_thread (module Thread);

        (* ... *)

        ()
        |> Thread.create (fun () ->
           Domain_local_await.using
             ~prepare_for_await:prepare_for_scheduler_a
             ~while_running:scheduler_a);

        ()
        |> Thread.create (fun () ->
           Domain_local_await.using
             ~prepare_for_await:prepare_for_scheduler_b
             ~while_running:scheduler_b);

        (* ... *)
    ]}

    {b NOTE}: It is not necessary to use per systhread configuration on a domain
    unless you want different systhreads to use different schedulers. *)
