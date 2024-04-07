(******************************************************************************)
(*                                                                            *)
(*                                    Menhir                                  *)
(*                                                                            *)
(*   Copyright Inria. All rights reserved. This file is distributed under     *)
(*   the terms of the GNU General Public License version 2, as described in   *)
(*   the file LICENSE.                                                        *)
(*                                                                            *)
(******************************************************************************)

(** This module parses the command line. *)

(** The back-end that must be used. *)
val backend: [
  | `ReferenceInterpreter
  | `CoqBackend
  | `NewCodeBackend
  | `OldCodeBackend
  | `TableBackend
]

(** The file name extension that is expected for sources files. *)
val extension: string

(** The list of file names that appear on the command line. *)
val filenames: string list

type token_type_mode =
  | TokenTypeAndCode   (** produce the definition of the [token] type and code for the parser *)
  | TokenTypeOnly      (** produce the type definition only *)
  | CodeOnly of string (** produce the code only, by relying on an external token type *)

(** How to deal with the type of tokens. *)
val token_type_mode: token_type_mode

type construction_mode =
  | ModeCanonical     (** --canonical: canonical Knuth LR(1) automaton *)
  | ModeInclusionOnly (** --no-pager : states are merged when there is an inclusion
                                      relationship, default reductions are used *)
  | ModePager         (** normal mode: states are merged as per Pager's criterion,
                                      default reductions are used *)
  | ModeLALR          (** --lalr     : states are merged as in an LALR generator,
                                      i.e. as soon as they have the same LR(0) core *)

(** How to construct the automaton. *)
val construction_mode: construction_mode

(** Whether conflicts should be explained. *)
val explain: bool

(** Whether the automaton should be dumped before conflict resolution. *)
val dump: bool

(** Whether the automaton should be dumped after conflict resolution. *)
val dump_resolved: bool

(** Whether the grammar's reference graph should be dumped. *)
val reference_graph: bool

(** Whether the automaton's graph should be dumped. *)
val automaton_graph: bool

(** Whether tracing instructions should be generated. *)
val trace: bool

type print_mode =
    | PrintNormal
    | PrintForOCamlyacc
    | PrintUnitActions of bool       (** if true, declare unit tokens *)

type preprocess_mode =
    | PMNormal                       (** preprocess and continue *)
    | PMOnlyPreprocess of print_mode (** preprocess, print grammar, stop *)

(** Whether one should stop and print the grammar after joining and
   expanding the grammar. *)
val preprocess_mode: preprocess_mode

type infer_mode =
  (* Perform no type inference. This is the default mode. *)
  | IMNone
  (* Perform type inference by invoking ocamlc directly. *)
  | IMInfer                (** --infer *)
  | IMDependRaw            (** --raw-depend *)
  | IMDependPostprocess    (** --depend *)
  (* Perform type inference by writing a mock .ml file and reading the
     corresponding inferred .mli file. *)
  | IMWriteQuery of string (** --infer-write-query <filename> *)
  | IMReadReply of string  (** --infer-read-reply <filename> *)

(** Whether and how OCaml type inference (for semantic actions and nonterminal
    symbols) should be performed. See the manual for details. *)
val infer: infer_mode

(** Whether one should inline the non terminal definitions marked
    with the %inline keyword. *)
val inline: bool

(** Whether comments should be printed or discarded. *)
val comment: bool

(** This undocumented flag suppresses prefixing of identifiers with an
    unlikely prefix in the generated code. This increases the code's
    readability, but can cause identifiers in semantic actions to be
    captured. *)
val noprefix: bool

(** This undocumented flag causes the code to be transformed by
    [Inline] or [StackLangTransform.inline]. It is on by default. *)
val code_inlining: bool

(**[represent_positions] forces every stack cell to contain a start position
   and an end position. This flag is [false] by default. It influences the
   code back-end only. *)
val represent_positions: bool

(**[represent_states] forces every stack cell to contain a state. This flag
   is [false] by default. It influences the code back-end only. *)
val represent_states: bool

(**[represent_values] forces every stack cell to contain a semantic value.
   This flag is [false] by default. It influences the code back-end only. *)
val represent_values: bool

(** How [ocamlc] and [ocamldep] should be invoked. *)
val ocamlc: string
val ocamldep: string

(** How verbose we should be. *)

val logG: int (** diagnostics on the grammar *)

val logA: int (** diagnostics on the automaton *)

val logC: int (** diagnostics on the generated code *)

(** Whether tasks should be timed. *)
val timings: out_channel option

(** The base name that should be used for the files that we create.
   This name can contain a path. *)
val base: string

(** The filename of the standard library. *)
val stdlib_filename : string

(**This setting determines Menhir should behave as an interpreter of sentences
   provided by the user on the standard input channel. Two interpretation
   modes exist. In the mode [`Normal], Menhir interprets the sentence and
   indicates whether it is rejected or accepted. (The flag --trace is taken
   into account, so trace messages can be emitted if desired by the user.) In
   this mode, an additional flag indicates whether a concrete syntax tree
   should be displayed after an input is accepted. In the mode [`Error],
   Menhir expects just one input sentence, expects it to trigger an error at
   the very last token, and displays which state was reached. *)
val interpret :
  [ `No
  | `Normal of [`ShowCST | `DoNotShowCST]
  | `Error ]

(** Whether to generate the inspection API (which requires GADTs, and
   requires producing more tables). *)
val inspection : bool

(** Whether to generate the unparsing API (which offers facilities for
    constructing and displaying concrete syntax trees). *)
val unparsing : bool

(** Whether the standard menhir library should be used. *)
val no_stdlib : bool

(** Whether to generate a version check for MenhirLib in the generated parser. *)
val coq_no_version_check : bool

(** Whether the coq description must contain completeness proofs. *)
val coq_no_complete : bool

(** Whether the coq backend should ignore types and semantic actions. *)
val coq_no_actions : bool

(** Whether unresolved LR(1) conflicts, useless precedence declarations,
   productions that are never reduced, etc. should be treated as errors. *)
val strict: bool

(** This flag causes the exception [Error] to be declared equal to
   [Parsing.Parse_error]. This is useful when full compatibility with
   ocamlyacc is desired. *)
val fixedexc: bool

(**This flag causes the exception [Error] to carry an integer state.
   This is the state where a syntax error is detected.
   This feature is supported only by the new code back-end. *)
val exn_carries_state: bool

(** This is a set of tokens which may be unused and about which we should not
   emit a warning. *)
val ignored_unused_tokens: StringSet.t

(** This flag supersedes the set [ignored_unused_tokens]. If it is set, then
   we should not emit a warning about any unused tokens. *)
val ignore_all_unused_tokens: bool

(** This flag suppresses all warnings about unused precedence levels. *)
val ignore_all_unused_precedence_levels: bool

(** This flag causes Menhir to produce a list of erroneous input sentences.
   Enough sentences are computed to produce exactly one error in every state
   where an error can occur. *)
val list_errors: bool

type list_errors_algorithm = [
  | `Fast
  | `Classic
  | `Validate
]

(** When using --list-errors, this setting determines which algorithm is used
   to produce a list of erroneous input sentences.
   Fast is the default, described in the SLE 2021 paper by Bour and Pottier.
   Classic is described in the CC 2016 paper by Pottier and was default
   before september 2021.
   Validate runs both algorithms and checks they agree on their output.  *)
val list_errors_algorithm: list_errors_algorithm

(** This flag causes Menhir to read the error message descriptions stored in
   [filename] and compile them to OCaml code. *)
val compile_errors: string option

(** If present, this is a pair of .messages files whose contents should
   be compared. *)
val compare_errors: (string * string) option

(** If present, this is a pair of .messages files whose contents should
   be merged. *)
val merge_errors: (string * string) option

(** This flag causes Menhir to read the error message descriptions stored in
   [filename] and re-generate the auto-generated comments, which begin with
   [##]. This allows bringing these comments up to date when the grammar
   evolves. *)
val update_errors: string option

(** This flag causes Menhir to read the error message descriptions stored in
   [filename] and echo the error sentences (and nothing else; no messages,
   no comments). *)
val echo_errors: string option

(** This flag causes Menhir to read the error message descriptions stored in
   [filename] and echo the error sentences, including the concrete syntax
   of each sentence, in an auto-comment. *)
val echo_errors_concrete: string option

(** This flag causes Menhir to produce a [.cmly] file, which contains a
   binary-format description of the grammar and automaton. *)
val cmly: bool

(** This name is used in --coq mode. It appears in the generated Coq file,
   and indicates under what name (or path) the Coq library MenhirLib is
   known. Its default value is [Some "MenhirLib"]. *)
val coq_lib_path: string option

(** This flag tells whether [$i] notation in semantic actions is allowed. *)
type dollars =
  | DollarsDisallowed
  | DollarsAllowed

(** This flag tells whether [$i] notation in semantic actions is allowed. *)
val dollars: dollars

(** This flag requires every token to come with a token alias. If that is
   not the case, warnings are emitted. *)
val require_aliases : bool

(**When [random_sentence] is [Some (nt, goal, style)], the user is asking
   Menhir to show a random sentence. The sentence must be generated by the
   nonterminal symbol [nt]. Its goal length is [goal]. The [style] parameter
   indicates whether the sentence should be displayed in concrete syntax; if
   it is [`Concrete], then every token must have a token alias. *)
val random_sentence : (string * int * [`Abstract | `Concrete]) option

(**The error handling strategy that should be used by the code back-end, the
   table back-end, and the reference interpreter. See [IncrementalEngine] for
   an explanation of the available strategies. *)
val strategy: [`Legacy | `Simplified]

(**The setting -O allows choosing an optimization level. It is used only by
   the new code back-end. *)
val optimization_level: int

(**The undocumented flag [--stacklang-dump] causes the StackLang program to be
   printed. *)
val stacklang_dump: bool

(**The undocumented flag [--stacklang-graph] causes the StackLang program to be
   dumped in the form of a control flow graph in the file [<basename>.dot]. *)
val stacklang_graph: bool

(**The undocumented flag [--stacklang-test] causes the StackLang program to be
   tested (by comparison with the reference interpreter). *)
val stacklang_test: bool

(**The undocumented flag [--specialize-token] causes the StackLang program to
   be specialized with respect to the current token. This guarantees that
   every token is case-analyzed exactly once, immediately after it has been
   read from the lexer. *)
val specialize_token: bool
