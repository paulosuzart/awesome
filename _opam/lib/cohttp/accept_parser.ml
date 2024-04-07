type token =
  | STAR
  | SLASH
  | SEMI
  | COMMA
  | EQUAL
  | EOI
  | TOK of (
# 34 "cohttp/src/accept_parser.mly"
        string
# 12 "cohttp/src/accept_parser.ml"
)
  | QS of (
# 34 "cohttp/src/accept_parser.mly"
        string
# 17 "cohttp/src/accept_parser.ml"
)

open Parsing
let _ = parse_error;;
# 20 "cohttp/src/accept_parser.mly"
  open Accept_types

  type param = Q of int | Kv of p

  let rec get_q = function
    | (Q q)::_ -> q
    | _::r -> get_q r
    | [] -> 1000

  let get_rest pl = List.fold_right
    (function Kv p -> fun l -> p::l | Q _ -> fun l -> l) pl []
# 34 "cohttp/src/accept_parser.ml"
let yytransl_const = [|
  257 (* STAR *);
  258 (* SLASH *);
  259 (* SEMI *);
  260 (* COMMA *);
  261 (* EQUAL *);
  262 (* EOI *);
    0|]

let yytransl_block = [|
  263 (* TOK *);
  264 (* QS *);
    0|]

let yylhs = "\255\255\
\005\000\005\000\006\000\006\000\007\000\007\000\007\000\001\000\
\001\000\001\000\008\000\008\000\002\000\002\000\009\000\009\000\
\003\000\003\000\003\000\010\000\010\000\004\000\004\000\000\000\
\000\000\000\000\000\000"

let yylen = "\002\000\
\004\000\004\000\002\000\000\000\004\000\004\000\004\000\002\000\
\003\000\001\000\002\000\002\000\002\000\003\000\002\000\002\000\
\002\000\003\000\001\000\002\000\002\000\002\000\003\000\002\000\
\002\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\010\000\000\000\
\024\000\000\000\000\000\000\000\025\000\000\000\000\000\019\000\
\000\000\026\000\000\000\000\000\000\000\027\000\000\000\000\000\
\000\000\000\000\008\000\000\000\000\000\012\000\011\000\000\000\
\013\000\016\000\015\000\000\000\017\000\021\000\020\000\000\000\
\022\000\000\000\000\000\000\000\009\000\000\000\003\000\014\000\
\018\000\023\000\005\000\006\000\007\000\000\000\002\000\001\000"

let yydgoto = "\005\000\
\009\000\013\000\018\000\022\000\029\000\030\000\010\000\014\000\
\019\000\023\000"

let yysindex = "\020\000\
\000\255\011\255\009\255\012\255\000\000\027\255\000\000\035\255\
\000\000\254\254\008\255\008\255\000\000\021\255\008\255\000\000\
\008\255\000\000\022\255\008\255\008\255\000\000\029\255\039\255\
\013\255\000\255\000\000\034\255\008\255\000\000\000\000\011\255\
\000\000\000\000\000\000\009\255\000\000\000\000\000\000\012\255\
\000\000\008\255\008\255\008\255\000\000\037\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\031\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\030\255\030\255\000\000\000\000\030\255\000\000\
\030\255\000\000\000\000\030\255\030\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\030\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\030\255\030\255\030\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\017\000\012\000\009\000\006\000\000\000\244\255\000\000\000\000\
\000\000\000\000"

let yytablesize = 46
let yytable = "\031\000\
\006\000\026\000\034\000\027\000\035\000\007\000\008\000\038\000\
\039\000\015\000\028\000\011\000\020\000\043\000\016\000\017\000\
\047\000\012\000\021\000\044\000\001\000\002\000\003\000\004\000\
\032\000\036\000\033\000\037\000\024\000\051\000\052\000\053\000\
\040\000\004\000\041\000\004\000\025\000\055\000\056\000\042\000\
\046\000\054\000\045\000\048\000\049\000\050\000"

let yycheck = "\012\000\
\001\001\004\001\015\000\006\001\017\000\006\001\007\001\020\000\
\021\000\001\001\003\001\001\001\001\001\001\001\006\001\007\001\
\029\000\007\001\007\001\007\001\001\000\002\000\003\000\004\000\
\004\001\004\001\006\001\006\001\002\001\042\000\043\000\044\000\
\004\001\004\001\006\001\006\001\002\001\007\001\008\001\001\001\
\007\001\005\001\026\000\032\000\036\000\040\000"

let yynames_const = "\
  STAR\000\
  SLASH\000\
  SEMI\000\
  COMMA\000\
  EQUAL\000\
  EOI\000\
  "

let yynames_block = "\
  TOK\000\
  QS\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 43 "cohttp/src/accept_parser.mly"
                    ( Kv (_2, _4) )
# 135 "cohttp/src/accept_parser.ml"
               : 'param))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 44 "cohttp/src/accept_parser.mly"
                     (
  if _2="q" then try Q (truncate (1000.*.(float_of_string _4)))
    with Failure _ -> raise Parsing.Parse_error
  else Kv (_2, _4)
)
# 147 "cohttp/src/accept_parser.ml"
               : 'param))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'param) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 51 "cohttp/src/accept_parser.mly"
               ( _1::_2 )
# 155 "cohttp/src/accept_parser.ml"
               : 'params))
; (fun __caml_parser_env ->
    Obj.repr(
# 52 "cohttp/src/accept_parser.mly"
  ( [] )
# 161 "cohttp/src/accept_parser.ml"
               : 'params))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 55 "cohttp/src/accept_parser.mly"
                         (
  (get_q _4, (AnyMedia, get_rest _4))
)
# 170 "cohttp/src/accept_parser.ml"
               : 'media_range))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 58 "cohttp/src/accept_parser.mly"
                        (
  (get_q _4, (AnyMediaSubtype (String.lowercase_ascii _1), get_rest _4))
)
# 180 "cohttp/src/accept_parser.ml"
               : 'media_range))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 61 "cohttp/src/accept_parser.mly"
                       (
  (get_q _4, (MediaType (String.lowercase_ascii _1, String.lowercase_ascii _3), get_rest _4))
)
# 191 "cohttp/src/accept_parser.ml"
               : 'media_range))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'media_range) in
    Obj.repr(
# 66 "cohttp/src/accept_parser.mly"
                  ( [_1] )
# 198 "cohttp/src/accept_parser.ml"
               : (Accept_types.media_range * Accept_types.p list) Accept_types.qlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'media_range) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : (Accept_types.media_range * Accept_types.p list) Accept_types.qlist) in
    Obj.repr(
# 67 "cohttp/src/accept_parser.mly"
                                 ( _1::_3 )
# 206 "cohttp/src/accept_parser.ml"
               : (Accept_types.media_range * Accept_types.p list) Accept_types.qlist))
; (fun __caml_parser_env ->
    Obj.repr(
# 68 "cohttp/src/accept_parser.mly"
      ( [] )
# 212 "cohttp/src/accept_parser.ml"
               : (Accept_types.media_range * Accept_types.p list) Accept_types.qlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 71 "cohttp/src/accept_parser.mly"
             ( (get_q _2, Charset (String.lowercase_ascii _1)) )
# 220 "cohttp/src/accept_parser.ml"
               : 'charset))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 72 "cohttp/src/accept_parser.mly"
              ( (get_q _2, AnyCharset) )
# 227 "cohttp/src/accept_parser.ml"
               : 'charset))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'charset) in
    Obj.repr(
# 75 "cohttp/src/accept_parser.mly"
              ( [_1] )
# 234 "cohttp/src/accept_parser.ml"
               : Accept_types.charset Accept_types.qlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'charset) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Accept_types.charset Accept_types.qlist) in
    Obj.repr(
# 76 "cohttp/src/accept_parser.mly"
                         ( _1::_3 )
# 242 "cohttp/src/accept_parser.ml"
               : Accept_types.charset Accept_types.qlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 79 "cohttp/src/accept_parser.mly"
             (
  (get_q _2, match (String.lowercase_ascii _1) with
    | "gzip" -> Gzip
    | "compress" -> Compress
    | "deflate" -> Deflate
    | "identity" -> Identity
    | enc -> Encoding enc
  )
)
# 258 "cohttp/src/accept_parser.ml"
               : 'encoding))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 88 "cohttp/src/accept_parser.mly"
              ( (get_q _2, AnyEncoding) )
# 265 "cohttp/src/accept_parser.ml"
               : 'encoding))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'encoding) in
    Obj.repr(
# 91 "cohttp/src/accept_parser.mly"
               ( [_1] )
# 272 "cohttp/src/accept_parser.ml"
               : Accept_types.encoding Accept_types.qlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'encoding) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Accept_types.encoding Accept_types.qlist) in
    Obj.repr(
# 92 "cohttp/src/accept_parser.mly"
                           ( _1::_3 )
# 280 "cohttp/src/accept_parser.ml"
               : Accept_types.encoding Accept_types.qlist))
; (fun __caml_parser_env ->
    Obj.repr(
# 93 "cohttp/src/accept_parser.mly"
      ( [] )
# 286 "cohttp/src/accept_parser.ml"
               : Accept_types.encoding Accept_types.qlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 96 "cohttp/src/accept_parser.mly"
             (
  (get_q _2, Language (String.split_on_char '-' (String.lowercase_ascii _1)))
)
# 296 "cohttp/src/accept_parser.ml"
               : 'language))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'params) in
    Obj.repr(
# 99 "cohttp/src/accept_parser.mly"
              ( (get_q _2, AnyLanguage) )
# 303 "cohttp/src/accept_parser.ml"
               : 'language))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'language) in
    Obj.repr(
# 102 "cohttp/src/accept_parser.mly"
               ( [_1] )
# 310 "cohttp/src/accept_parser.ml"
               : Accept_types.language Accept_types.qlist))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'language) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Accept_types.language Accept_types.qlist) in
    Obj.repr(
# 103 "cohttp/src/accept_parser.mly"
                           ( _1::_3 )
# 318 "cohttp/src/accept_parser.ml"
               : Accept_types.language Accept_types.qlist))
(* Entry media_ranges *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry charsets *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry encodings *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
(* Entry languages *)
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
let media_ranges (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : (Accept_types.media_range * Accept_types.p list) Accept_types.qlist)
let charsets (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 2 lexfun lexbuf : Accept_types.charset Accept_types.qlist)
let encodings (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 3 lexfun lexbuf : Accept_types.encoding Accept_types.qlist)
let languages (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 4 lexfun lexbuf : Accept_types.language Accept_types.qlist)
;;
