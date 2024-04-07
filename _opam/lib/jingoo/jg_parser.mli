
(* The type of tokens. *)

type token = 
  | WITHOUT
  | WITH
  | VLINE
  | TRUE
  | TIMES
  | TEXT of (string)
  | SWITCH
  | STRING of (string)
  | SET
  | RPAREN
  | RBRACKET
  | RBRACE
  | RAWINCLUDE
  | QUESTION
  | POWER
  | PLUS
  | OR
  | OPEN_EXPRESSION
  | NULL
  | NOT
  | NEQ
  | MOD
  | MINUS
  | MACRO
  | LT_EQ
  | LT
  | LPAREN
  | LBRACKET
  | LBRACE
  | IS
  | INT of (int)
  | INCLUDE
  | IN
  | IMPORT
  | IF
  | IDENT of (string)
  | GT_EQ
  | GT
  | FUNCTION
  | FROM
  | FOR
  | FLOAT of (float)
  | FILTER
  | FATARROW
  | FALSE
  | EXTENDS
  | EQ_EQ
  | EQ
  | EOF
  | ENDWITH
  | ENDSWITCH
  | ENDSET
  | ENDMACRO
  | ENDIF
  | ENDFUNCTION
  | ENDFOR
  | ENDFILTER
  | ENDCALL
  | ENDBLOCK
  | ENDAUTOESCAPE
  | ELSEIF
  | ELSE
  | DOT
  | DIV
  | DEFAULT
  | CONTEXT
  | COMMA
  | COLON
  | CLOSE_EXPRESSION
  | CASE
  | CALL
  | BLOCK
  | AUTOESCAPE
  | AS
  | AND

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val input: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Jg_types.ast)
