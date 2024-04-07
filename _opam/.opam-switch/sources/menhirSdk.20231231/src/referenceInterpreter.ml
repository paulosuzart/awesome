(******************************************************************************)
(*                                                                            *)
(*                                    Menhir                                  *)
(*                                                                            *)
(*   Copyright Inria. All rights reserved. This file is distributed under     *)
(*   the terms of the GNU General Public License version 2, as described in   *)
(*   the file LICENSE.                                                        *)
(*                                                                            *)
(******************************************************************************)

open Grammar
open Cst
let dummy_pos = Lexing.dummy_pos

(* ------------------------------------------------------------------------ *)

(* Set up all of the information required by the LR engine. Everything is
   read directly from [Grammar] and [Lr1]. *)

module T = struct

  type state =
      Lr1.node

  let number =
    Lr1.number

  type token =
      Terminal.t

  type terminal =
      Terminal.t

  type nonterminal =
      Nonterminal.t

  type semantic_value =
      cst

  let token2terminal (token : token) : terminal =
    token

  let token2value (token : token) : semantic_value =
    CstTerminal token

  let error_terminal =
    Terminal.error

  let error_value =
    CstError

  let foreach_terminal =
    Terminal.foldx

  type production =
      Production.index

  let production_index = Production.p2i
  let find_production  = Production.i2p

  let default_reduction (s : state) defred nodefred env =
    match Default.has_default_reduction s with
    | Some (prod, _) ->
        defred env prod
    | None ->
        nodefred env

  let action (s : state) (tok : terminal) value shift reduce fail env =

    (* Check whether [s] has an outgoing shift transition along [tok]. *)

    try

      let s' : state = SymbolMap.find (Symbol.T tok) (Lr1.transitions s) in

      (* There is such a transition. Return either [ShiftDiscard] or
         [ShiftNoDiscard], depending on the existence of a default
         reduction on [#] at [s']. *)

      match Default.has_default_reduction s' with
      | Some (_, toks) when TerminalSet.mem Terminal.sharp toks ->
          shift env false tok value s'
      | _ ->
          shift env true tok value s'

    (* There is no such transition. Look for a reduction. *)

    with Not_found ->
      try

        let prod = Misc.single (TerminalMap.find tok (Lr1.reductions s)) in
        reduce env prod

      (* There is no reduction either. Fail. *)

      with Not_found ->
        fail env

  let maybe_shift_t (s : state) (tok : terminal) : state option =
    try
      let s' : state = SymbolMap.find (Symbol.T tok) (Lr1.transitions s) in
      Some s'
    with Not_found ->
      None

  let may_reduce_prod (s : state) (tok : terminal) (prod : production) =
    match Default.has_default_reduction s with
    | Some (prod', _) ->
        prod = prod'
    | None ->
        try
          let prod' = Misc.single (TerminalMap.find tok (Lr1.reductions s)) in
          prod = prod'
        with Not_found ->
          false

  let goto_nt (s : state) (nt : nonterminal) : state =
    try
      SymbolMap.find (Symbol.N nt) (Lr1.transitions s)
    with Not_found ->
      assert false

  let goto_prod (s : state) (prod : production) : state =
    goto_nt s (Production.nt prod)

  let maybe_goto_nt (s : state) (nt : nonterminal) : state option =
    try
      Some (SymbolMap.find (Symbol.N nt) (Lr1.transitions s))
    with Not_found ->
      None

  open MenhirLib.EngineTypes

  exception Error
  exception Abort

  (* By convention, a semantic action returns a new stack. It does not
     affect [env]. *)

  let lhs =
    Production.nt

  let is_start =
    Production.is_start

  type semantic_action =
      (state, semantic_value, token) env -> (state, semantic_value) stack

  let semantic_action (prod : production) : semantic_action =
    fun env ->
      assert (not (Production.is_start prod));

      (* Reduce. Pop a suffix of the stack, and use it to construct a
         new concrete syntax tree node. *)

      let n = Production.length prod in

      let values : semantic_value array =
        Array.make n CstError (* dummy *)
      and startp =
        ref dummy_pos
      and endp =
        ref dummy_pos
      and current =
        ref env.current
      and stack =
        ref env.stack
      in

      (* We now enter a loop to pop [k] stack cells and (after that) push
         a new cell onto the stack. *)

      (* This loop does not update [env.current]. Instead, the state in
         the newly pushed stack cell will be used (by our caller) as a
         basis for a goto transition, and [env.current] will be updated
         (if necessary) then. *)

      for k = n downto 1 do

        (* Fetch a semantic value. *)

        values.(k - 1) <- !stack.semv;

        (* Pop one cell. The stack must be non-empty. As we pop a cell,
           change the automaton's current state to the one stored within
           the cell. (It is sufficient to do this only when [k] is 1,
           since the last write overwrites any and all previous writes.)
           If this is the first (last) cell that we pop, update [endp]
           ([startp]). *)

        let next = !stack.next in
        assert (!stack != next);
        if k = n then begin
          endp := !stack.endp
        end;
        if k = 1 then begin
          current := !stack.state;
          startp := !stack.startp
        end;
        stack := next

      done;

      (* Done popping. *)

      (* As a special case, under the simplified strategy, if the production
         that we are reducing involves the [error] token, then we assume that
         the semantic action aborts the parser. We might otherwise enter an
         infinite loop. *)

      if Settings.strategy = `Simplified
      && not (Production.error_free prod) then
        raise Abort;

      (* Construct and push a new stack cell. The associated semantic
         value is a new concrete syntax tree. *)

      {
        state = !current;
        semv = CstNonTerminal (prod, values);
        startp = !startp;
        endp = !endp;
        next = !stack
      }

  let may_reduce node prod =
    Lr1.NodeSet.mem node (Lr1.production_where prod)

end

(* ------------------------------------------------------------------------ *)

(* The strategy used by the reference interpreter is determined by the
   command line switch [--strategy]. *)

let strategy =
  Settings.strategy

(* ------------------------------------------------------------------------ *)

(* Define a palatable user entry point. *)

let interpret nt log lexer lexbuf =

  (* Instantiate the LR engine. *)

  let module E =
    MenhirLib.Engine.Make (struct
      include T
      (* The logging hooks. *)
      module Log = (val log : Logging.LOG)
      (* We want our logging hooks to be called. *)
      let log = true
    end)
  in

  (* Run it. *)

  try
    let cst = E.entry strategy (Lr1.entry_of_nt nt) lexer lexbuf in
    Some cst
  with T.Error | T.Abort ->
    None

(* ------------------------------------------------------------------------ *)

(* Another entry point, used internally by [LRijkstra] to check that the
   sentences that [LRijkstra] produces do lead to an error in the expected
   state. *)

type spurious_reduction =
  Lr1.node * Production.index

type target =
  Lr1.node * spurious_reduction list

type check_error_path_outcome =
  (* Bad: the input was read past its end. *)
| OInputReadPastEnd
  (* Bad: a syntax error occurred before all of the input was read. *)
| OInputNotFullyConsumed
  (* Bad: the parser unexpectedly accepted (part of) this input. *)
| OUnexpectedAccept
  (* Good: a syntax error occurred after reading the last input token. We
     report in which state the error took place, as well as a list of spurious
     reductions. A non-default reduction that takes place after looking at the
     last input token (i.e., the erroneous token) is spurious. Furthermore, any
     reduction that takes place after a spurious reduction is itself spurious.
     We note that a spurious reduction can take place only in a non-canonical
     LR automaton. *)
| OK of target

let check_error_path log nt input =

  (* Instantiate the LR engine. *)

  let module E =
    MenhirLib.Engine.Make (struct
      include T
      (* The logging hooks. *)
      module Log = (val log : Logging.LOG)
      (* We want our logging hooks to be called. *)
      let log = true
    end)
  in

  (* Determine the initial state. *)

  let entry = Lr1.entry_of_nt nt in

  (* This function helps extract the current parser state out of [env].
     It may become unnecessary if the [Engine] API offers it. *)

  let current env =
    (* Peek at the stack. If empty, then we must be in the initial state. *)
    match E.top env with
    | None ->
        entry
    | Some (E.Element (s, _, _, _)) ->
        s
  in

  (* Set up a function that delivers tokens one by one. *)

  let input = ref input in
  let next () =
    match !input with
    | [] ->
        None
    | t :: ts ->
        input := ts;
        Some t
  in

  let looking_at_last_token () : bool =
    !input = []
  in

  (* Run. We wish to stop at the first error (without handling the error
     in any way) and report in which state the error occurred. A clean way
     of doing this is to use the incremental API, as follows. The main loop
     resembles the [loop] function in [Engine]. *)

  (* Another reason why we write our own loop is that we wish to detect
     spurious reductions. We accumulate these reductions in [spurious], a
     (reversed) list of productions. *)

  let rec loop (checkpoint : cst E.checkpoint) (spurious : spurious_reduction list) =
    match checkpoint with
    | E.InputNeeded _ ->
        begin match next() with
        | None ->
            OInputReadPastEnd
        | Some t ->
            let checkpoint = E.offer checkpoint (t, dummy_pos, dummy_pos) in
            loop checkpoint spurious
        end
    | E.Shifting _ ->
        loop (E.resume ~strategy checkpoint) spurious
    | E.AboutToReduce (env, prod) ->
        (* If we have requested the last input token and if this is not
           a default reduction, then this is a spurious reduction.
           Furthermore, if a spurious reduction has taken place already,
           then this is also a spurious reduction. *)
        let spurious =
          if looking_at_last_token() && not (E.env_has_default_reduction env)
          || spurious <> []
          then
            (current env, prod) :: spurious
          else
            spurious
        in
        loop (E.resume ~strategy checkpoint) spurious
    | E.HandlingError env ->
        (* Check that all of the input has been read. Otherwise, the error
           has occurred sooner than expected. *)
        if !input = [] then
          (* Return the current state and the list of spurious reductions. *)
          OK (current env, List.rev spurious)
        else
          OInputNotFullyConsumed
    | E.Accepted _ ->
        (* The parser has succeeded. This is unexpected. *)
        OUnexpectedAccept
    | E.Rejected ->
        (* The parser rejects this input. This should not happen; we
           should observe [HandlingError _] first. *)
        assert false
  in

  loop (E.start entry dummy_pos) []
