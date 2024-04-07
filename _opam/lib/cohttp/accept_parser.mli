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
# 12 "cohttp/src/accept_parser.mli"
)
  | QS of (
# 34 "cohttp/src/accept_parser.mly"
        string
# 17 "cohttp/src/accept_parser.mli"
)

val media_ranges :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> (Accept_types.media_range * Accept_types.p list) Accept_types.qlist
val charsets :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Accept_types.charset Accept_types.qlist
val encodings :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Accept_types.encoding Accept_types.qlist
val languages :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Accept_types.language Accept_types.qlist
