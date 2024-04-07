(* Allows a single fiber to wait to be notified by another fiber in the same domain.
   If multiple fibers need to wait at once, or the notification comes from another domain,
   this can't be used. *)

type 'a t = {
  mutable wake : ('a, exn) result -> unit;
}

let create () = { wake = ignore }

let wake t v = t.wake v

let await t op id =
  let x =
    Suspend.enter op @@ fun ctx enqueue ->
    Cancel.Fiber_context.set_cancel_fn ctx (fun ex ->
        t.wake <- ignore;
        enqueue (Error ex)
      );
    t.wake <- (fun x ->
        Cancel.Fiber_context.clear_cancel_fn ctx;
        t.wake <- ignore;
        enqueue x
      )
  in
  Trace.get id;
  x

let await_protect t op id =
  let x =
    Suspend.enter_unchecked op @@ fun _ctx enqueue ->
    t.wake <- (fun x -> t.wake <- ignore; enqueue x)
  in
  Trace.get id;
  x
