type token =
  | STRING of (
# 53 "src/parser_with_layout.mly"
        string * (Lexing.position * string) option
# 6 "src/parser_with_layout.mli"
)
  | COMMENT of (
# 54 "src/parser_with_layout.mly"
        string * Lexing.position option
# 11 "src/parser_with_layout.mli"
)
  | LPAREN
  | RPAREN
  | EOF
  | HASH_SEMI

val sexp :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Type_with_layout.t_or_comment
val sexp_opt :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Type_with_layout.t_or_comment option
val sexps :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Type_with_layout.t_or_comment list
val sexps_abs :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Type_with_layout.Parsed.t_or_comment list
val rev_sexps :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Type_with_layout.t_or_comment list
