type token =
  | STRING of (
# 53 "src/parser_with_layout.mly"
        string * (Lexing.position * string) option
# 6 "src/parser_with_layout.ml"
)
  | COMMENT of (
# 54 "src/parser_with_layout.mly"
        string * Lexing.position option
# 11 "src/parser_with_layout.ml"
)
  | LPAREN
  | RPAREN
  | EOF
  | HASH_SEMI

open Parsing
let _ = parse_error;;
# 2 "src/parser_with_layout.mly"
  (* Parser: Grammar Specification for Parsing S-expressions *)
  (* compare to parser.mly *)

  open Lexing

  let parse_failure what =
    let pos = Parsing.symbol_start_pos () in
    let msg =
      Printf.sprintf "Sexplib.Parser: failed to parse line %d char %d: %s"
        pos.pos_lnum (pos.pos_cnum - pos.pos_bol) what in
    failwith msg

  module With_pos = struct

    open Type_with_layout.Parsed

    let coerce = Src_pos.Absolute.of_lexing

    let start_pos () = coerce (Parsing.symbol_start_pos ())

    let end_pos () =
      let p = Parsing.symbol_end_pos () in
      coerce { p with Lexing.pos_cnum = p.Lexing.pos_cnum - 1 }

    let atom (x, y) =
      let (pos, y) =
        match y with
        | None -> (start_pos (), Some x)
        | Some (pos, x) -> (coerce pos, Some x)
      in
      Atom (pos, x, y)

    let list ts = List (start_pos (), ts, end_pos ())

    let sexp    x = Sexp    x
    let comment x = Comment x

    let sexp_comment cs t = Sexp_comment (start_pos (), cs, t)

    let plain_comment (x, pos_opt) =
      let pos =
        match pos_opt with
        | None -> start_pos ()
        | Some pos -> coerce pos
      in
      Plain_comment (pos, x)

  end

# 70 "src/parser_with_layout.ml"
let yytransl_const = [|
  259 (* LPAREN *);
  260 (* RPAREN *);
    0 (* EOF *);
  261 (* HASH_SEMI *);
    0|]

let yytransl_block = [|
  257 (* STRING *);
  258 (* COMMENT *);
    0|]

let yylhs = "\255\255\
\006\000\006\000\006\000\008\000\008\000\009\000\009\000\010\000\
\010\000\007\000\007\000\001\000\002\000\002\000\011\000\011\000\
\005\000\005\000\003\000\003\000\004\000\000\000\000\000\000\000\
\000\000\000\000"

let yylen = "\002\000\
\001\000\003\000\001\000\001\000\003\000\000\000\002\000\001\000\
\001\000\000\000\002\000\001\000\001\000\001\000\001\000\002\000\
\002\000\001\000\002\000\001\000\002\000\002\000\002\000\002\000\
\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\010\000\000\000\000\000\003\000\001\000\
\004\000\010\000\006\000\022\000\008\000\009\000\012\000\014\000\
\013\000\023\000\020\000\015\000\024\000\000\000\025\000\000\000\
\018\000\026\000\000\000\000\000\000\000\019\000\016\000\021\000\
\011\000\017\000\002\000\005\000\007\000"

let yydgoto = "\006\000\
\020\000\018\000\021\000\023\000\026\000\013\000\024\000\014\000\
\029\000\015\000\022\000"

let yysindex = "\037\000\
\009\255\001\000\007\000\000\000\013\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\019\000\000\000\025\000\
\000\000\000\000\031\000\032\255\009\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\002\000\000\000\000\000\000\000\000\000\227\255\251\255\235\255\
\000\000\234\255\010\000"

let yytablesize = 292
let yytable = "\036\000\
\016\000\033\000\012\000\017\000\028\000\033\000\019\000\037\000\
\007\000\008\000\009\000\010\000\025\000\011\000\027\000\000\000\
\000\000\000\000\030\000\000\000\000\000\000\000\000\000\031\000\
\032\000\000\000\000\000\000\000\031\000\000\000\034\000\007\000\
\008\000\009\000\010\000\035\000\011\000\001\000\002\000\003\000\
\004\000\005\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\007\000\008\000\009\000\010\000\000\000\011\000\007\000\008\000\
\009\000\010\000\000\000\011\000\007\000\008\000\009\000\010\000\
\000\000\011\000\007\000\008\000\009\000\010\000\000\000\011\000\
\007\000\008\000\009\000\010\000\000\000\011\000\007\000\008\000\
\009\000\010\000\000\000\011\000"

let yycheck = "\029\000\
\000\000\024\000\001\000\002\000\010\000\028\000\000\000\029\000\
\000\001\001\001\002\001\003\001\000\000\005\001\005\000\255\255\
\255\255\255\255\000\000\255\255\255\255\255\255\255\255\022\000\
\000\000\255\255\255\255\255\255\027\000\255\255\000\000\000\001\
\001\001\002\001\003\001\004\001\005\001\001\000\002\000\003\000\
\004\000\005\000\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\000\001\001\001\002\001\003\001\255\255\005\001\000\001\001\001\
\002\001\003\001\255\255\005\001\000\001\001\001\002\001\003\001\
\255\255\005\001\000\001\001\001\002\001\003\001\255\255\005\001\
\000\001\001\001\002\001\003\001\255\255\005\001\000\001\001\001\
\002\001\003\001\255\255\005\001"

let yynames_const = "\
  LPAREN\000\
  RPAREN\000\
  EOF\000\
  HASH_SEMI\000\
  "

let yynames_block = "\
  STRING\000\
  COMMENT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string * (Lexing.position * string) option) in
    Obj.repr(
# 75 "src/parser_with_layout.mly"
           ( With_pos.atom _1 )
# 222 "src/parser_with_layout.ml"
               : 'sexp_but_no_comment_abs))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'rev_sexps_abs) in
    Obj.repr(
# 76 "src/parser_with_layout.mly"
                                ( With_pos.list (List.rev _2) )
# 229 "src/parser_with_layout.ml"
               : 'sexp_but_no_comment_abs))
; (fun __caml_parser_env ->
    Obj.repr(
# 77 "src/parser_with_layout.mly"
          ( parse_failure "sexp" )
# 235 "src/parser_with_layout.ml"
               : 'sexp_but_no_comment_abs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string * Lexing.position option) in
    Obj.repr(
# 80 "src/parser_with_layout.mly"
            ( With_pos.plain_comment _1 )
# 242 "src/parser_with_layout.ml"
               : 'comment_abs))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'rev_comments_abs) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'sexp_but_no_comment_abs) in
    Obj.repr(
# 81 "src/parser_with_layout.mly"
                                                       ( With_pos.sexp_comment (List.rev _2) _3 )
# 250 "src/parser_with_layout.ml"
               : 'comment_abs))
; (fun __caml_parser_env ->
    Obj.repr(
# 84 "src/parser_with_layout.mly"
                  ( [] )
# 256 "src/parser_with_layout.ml"
               : 'rev_comments_abs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'rev_comments_abs) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'comment_abs) in
    Obj.repr(
# 85 "src/parser_with_layout.mly"
                                 ( _2 :: _1 )
# 264 "src/parser_with_layout.ml"
               : 'rev_comments_abs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'sexp_but_no_comment_abs) in
    Obj.repr(
# 88 "src/parser_with_layout.mly"
                            ( With_pos.sexp _1 )
# 271 "src/parser_with_layout.ml"
               : 'sexp_abs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'comment_abs) in
    Obj.repr(
# 89 "src/parser_with_layout.mly"
                ( With_pos.comment _1 )
# 278 "src/parser_with_layout.ml"
               : 'sexp_abs))
; (fun __caml_parser_env ->
    Obj.repr(
# 92 "src/parser_with_layout.mly"
                ( [] )
# 284 "src/parser_with_layout.ml"
               : 'rev_sexps_abs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'rev_sexps_abs) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'sexp_abs) in
    Obj.repr(
# 93 "src/parser_with_layout.mly"
                           ( _2 :: _1 )
# 292 "src/parser_with_layout.ml"
               : 'rev_sexps_abs))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'sexp_abs) in
    Obj.repr(
# 96 "src/parser_with_layout.mly"
             ( Type_with_layout.relativize _1 )
# 299 "src/parser_with_layout.ml"
               : Type_with_layout.t_or_comment))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Type_with_layout.t_or_comment) in
    Obj.repr(
# 99 "src/parser_with_layout.mly"
         ( Some _1 )
# 306 "src/parser_with_layout.ml"
               : Type_with_layout.t_or_comment option))
; (fun __caml_parser_env ->
    Obj.repr(
# 100 "src/parser_with_layout.mly"
        ( None )
# 312 "src/parser_with_layout.ml"
               : Type_with_layout.t_or_comment option))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Type_with_layout.t_or_comment) in
    Obj.repr(
# 103 "src/parser_with_layout.mly"
         ( [_1] )
# 319 "src/parser_with_layout.ml"
               : 'rev_sexps_aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'rev_sexps_aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Type_with_layout.t_or_comment) in
    Obj.repr(
# 104 "src/parser_with_layout.mly"
                       ( _2 :: _1 )
# 327 "src/parser_with_layout.ml"
               : 'rev_sexps_aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'rev_sexps_aux) in
    Obj.repr(
# 107 "src/parser_with_layout.mly"
                      ( _1 )
# 334 "src/parser_with_layout.ml"
               : Type_with_layout.t_or_comment list))
; (fun __caml_parser_env ->
    Obj.repr(
# 108 "src/parser_with_layout.mly"
        ( [] )
# 340 "src/parser_with_layout.ml"
               : Type_with_layout.t_or_comment list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'rev_sexps_aux) in
    Obj.repr(
# 111 "src/parser_with_layout.mly"
                      ( List.rev _1 )
# 347 "src/parser_with_layout.ml"
               : Type_with_layout.t_or_comment list))
; (fun __caml_parser_env ->
    Obj.repr(
# 112 "src/parser_with_layout.mly"
        ( [] )
# 353 "src/parser_with_layout.ml"
               : Type_with_layout.t_or_comment list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'rev_sexps_abs) in
    Obj.repr(
# 116 "src/parser_with_layout.mly"
                      ( List.rev _1 )
# 360 "src/parser_with_layout.ml"
               : Type_with_layout.Parsed.t_or_comment list))
(* Entry sexp *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry sexp_opt *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry sexps *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry sexps_abs *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry rev_sexps *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let sexp (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Type_with_layout.t_or_comment)
let sexp_opt (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 2 lexfun lexbuf : Type_with_layout.t_or_comment option)
let sexps (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 3 lexfun lexbuf : Type_with_layout.t_or_comment list)
let sexps_abs (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 4 lexfun lexbuf : Type_with_layout.Parsed.t_or_comment list)
let rev_sexps (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 5 lexfun lexbuf : Type_with_layout.t_or_comment list)
