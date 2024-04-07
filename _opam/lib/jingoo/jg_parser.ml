
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | WITHOUT
    | WITH
    | VLINE
    | TRUE
    | TIMES
    | TEXT of (
# 59 "src/jg_parser.mly"
       (string)
# 20 "src/jg_parser.ml"
  )
    | SWITCH
    | STRING of (
# 58 "src/jg_parser.mly"
       (string)
# 26 "src/jg_parser.ml"
  )
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
    | INT of (
# 56 "src/jg_parser.mly"
       (int)
# 53 "src/jg_parser.ml"
  )
    | INCLUDE
    | IN
    | IMPORT
    | IF
    | IDENT of (
# 60 "src/jg_parser.mly"
       (string)
# 62 "src/jg_parser.ml"
  )
    | GT_EQ
    | GT
    | FUNCTION
    | FROM
    | FOR
    | FLOAT of (
# 57 "src/jg_parser.mly"
       (float)
# 72 "src/jg_parser.ml"
  )
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
  
end

include MenhirBasics

# 1 "src/jg_parser.mly"
  
(*
  jg_parser.mly

  Copyright (c) 2011- by Masaki WATANABE

  License: see LICENSE
*)
  open Jg_types

  let debug = false

  let pel x = if debug then print_endline x else ()

# 127 "src/jg_parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState000 : ('s, _menhir_box_input) _menhir_state
    (** State 000.
        Stack shape : .
        Start symbol: input. *)

  | MenhirState001 : (('s, _menhir_box_input) _menhir_cell1_WITH, _menhir_box_input) _menhir_state
    (** State 001.
        Stack shape : WITH.
        Start symbol: input. *)

  | MenhirState003 : (('s, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_state
    (** State 003.
        Stack shape : IDENT.
        Start symbol: input. *)

  | MenhirState007 : (('s, _menhir_box_input) _menhir_cell1_NOT, _menhir_box_input) _menhir_state
    (** State 007.
        Stack shape : NOT.
        Start symbol: input. *)

  | MenhirState008 : (('s, _menhir_box_input) _menhir_cell1_MINUS, _menhir_box_input) _menhir_state
    (** State 008.
        Stack shape : MINUS.
        Start symbol: input. *)

  | MenhirState009 : (('s, _menhir_box_input) _menhir_cell1_LPAREN, _menhir_box_input) _menhir_state
    (** State 009.
        Stack shape : LPAREN.
        Start symbol: input. *)

  | MenhirState010 : (('s, _menhir_box_input) _menhir_cell1_LBRACKET, _menhir_box_input) _menhir_state
    (** State 010.
        Stack shape : LBRACKET.
        Start symbol: input. *)

  | MenhirState011 : (('s, _menhir_box_input) _menhir_cell1_LBRACE, _menhir_box_input) _menhir_state
    (** State 011.
        Stack shape : LBRACE.
        Start symbol: input. *)

  | MenhirState013 : (('s, _menhir_box_input) _menhir_cell1_STRING, _menhir_box_input) _menhir_state
    (** State 013.
        Stack shape : STRING.
        Start symbol: input. *)

  | MenhirState019 : (('s, _menhir_box_input) _menhir_cell1_DEFAULT, _menhir_box_input) _menhir_state
    (** State 019.
        Stack shape : DEFAULT.
        Start symbol: input. *)

  | MenhirState021 : (('s, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_state
    (** State 021.
        Stack shape : IDENT.
        Start symbol: input. *)

  | MenhirState022 : ((('s, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 022.
        Stack shape : IDENT expr.
        Start symbol: input. *)

  | MenhirState023 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_VLINE, _menhir_box_input) _menhir_state
    (** State 023.
        Stack shape : expr VLINE.
        Start symbol: input. *)

  | MenhirState024 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_VLINE, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 024.
        Stack shape : expr VLINE expr.
        Start symbol: input. *)

  | MenhirState025 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_POWER, _menhir_box_input) _menhir_state
    (** State 025.
        Stack shape : expr POWER.
        Start symbol: input. *)

  | MenhirState026 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_POWER, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 026.
        Stack shape : expr POWER expr.
        Start symbol: input. *)

  | MenhirState027 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_LPAREN, _menhir_box_input) _menhir_state
    (** State 027.
        Stack shape : expr LPAREN.
        Start symbol: input. *)

  | MenhirState031 : (('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 031.
        Stack shape : expr.
        Start symbol: input. *)

  | MenhirState032 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_TIMES, _menhir_box_input) _menhir_state
    (** State 032.
        Stack shape : expr TIMES.
        Start symbol: input. *)

  | MenhirState033 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_TIMES, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 033.
        Stack shape : expr TIMES expr.
        Start symbol: input. *)

  | MenhirState034 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_LBRACKET, _menhir_box_input) _menhir_state
    (** State 034.
        Stack shape : expr LBRACKET.
        Start symbol: input. *)

  | MenhirState035 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_LBRACKET, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 035.
        Stack shape : expr LBRACKET expr.
        Start symbol: input. *)

  | MenhirState037 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_QUESTION, _menhir_box_input) _menhir_state
    (** State 037.
        Stack shape : expr QUESTION.
        Start symbol: input. *)

  | MenhirState038 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_QUESTION, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 038.
        Stack shape : expr QUESTION expr.
        Start symbol: input. *)

  | MenhirState039 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_PLUS, _menhir_box_input) _menhir_state
    (** State 039.
        Stack shape : expr PLUS.
        Start symbol: input. *)

  | MenhirState040 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_PLUS, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 040.
        Stack shape : expr PLUS expr.
        Start symbol: input. *)

  | MenhirState041 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_MOD, _menhir_box_input) _menhir_state
    (** State 041.
        Stack shape : expr MOD.
        Start symbol: input. *)

  | MenhirState042 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_MOD, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 042.
        Stack shape : expr MOD expr.
        Start symbol: input. *)

  | MenhirState045 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_DIV, _menhir_box_input) _menhir_state
    (** State 045.
        Stack shape : expr DIV.
        Start symbol: input. *)

  | MenhirState046 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_DIV, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 046.
        Stack shape : expr DIV expr.
        Start symbol: input. *)

  | MenhirState047 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_OR, _menhir_box_input) _menhir_state
    (** State 047.
        Stack shape : expr OR.
        Start symbol: input. *)

  | MenhirState048 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_OR, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 048.
        Stack shape : expr OR expr.
        Start symbol: input. *)

  | MenhirState049 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_NEQ, _menhir_box_input) _menhir_state
    (** State 049.
        Stack shape : expr NEQ.
        Start symbol: input. *)

  | MenhirState050 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_NEQ, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 050.
        Stack shape : expr NEQ expr.
        Start symbol: input. *)

  | MenhirState051 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_MINUS, _menhir_box_input) _menhir_state
    (** State 051.
        Stack shape : expr MINUS.
        Start symbol: input. *)

  | MenhirState052 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_MINUS, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 052.
        Stack shape : expr MINUS expr.
        Start symbol: input. *)

  | MenhirState053 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_LT_EQ, _menhir_box_input) _menhir_state
    (** State 053.
        Stack shape : expr LT_EQ.
        Start symbol: input. *)

  | MenhirState054 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_LT_EQ, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 054.
        Stack shape : expr LT_EQ expr.
        Start symbol: input. *)

  | MenhirState055 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_LT, _menhir_box_input) _menhir_state
    (** State 055.
        Stack shape : expr LT.
        Start symbol: input. *)

  | MenhirState056 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_LT, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 056.
        Stack shape : expr LT expr.
        Start symbol: input. *)

  | MenhirState057 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_GT_EQ, _menhir_box_input) _menhir_state
    (** State 057.
        Stack shape : expr GT_EQ.
        Start symbol: input. *)

  | MenhirState058 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_GT_EQ, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 058.
        Stack shape : expr GT_EQ expr.
        Start symbol: input. *)

  | MenhirState059 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_GT, _menhir_box_input) _menhir_state
    (** State 059.
        Stack shape : expr GT.
        Start symbol: input. *)

  | MenhirState060 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_GT, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 060.
        Stack shape : expr GT expr.
        Start symbol: input. *)

  | MenhirState062 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_IS _menhir_cell0_IDENT, _menhir_box_input) _menhir_state
    (** State 062.
        Stack shape : expr IS IDENT.
        Start symbol: input. *)

  | MenhirState063 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_IS _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 063.
        Stack shape : expr IS IDENT expr.
        Start symbol: input. *)

  | MenhirState064 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_IN, _menhir_box_input) _menhir_state
    (** State 064.
        Stack shape : expr IN.
        Start symbol: input. *)

  | MenhirState065 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_IN, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 065.
        Stack shape : expr IN expr.
        Start symbol: input. *)

  | MenhirState066 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_EQ_EQ, _menhir_box_input) _menhir_state
    (** State 066.
        Stack shape : expr EQ_EQ.
        Start symbol: input. *)

  | MenhirState067 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_EQ_EQ, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 067.
        Stack shape : expr EQ_EQ expr.
        Start symbol: input. *)

  | MenhirState068 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_FATARROW, _menhir_box_input) _menhir_state
    (** State 068.
        Stack shape : expr FATARROW.
        Start symbol: input. *)

  | MenhirState069 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_FATARROW, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 069.
        Stack shape : expr FATARROW expr.
        Start symbol: input. *)

  | MenhirState070 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_AND, _menhir_box_input) _menhir_state
    (** State 070.
        Stack shape : expr AND.
        Start symbol: input. *)

  | MenhirState071 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_AND, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 071.
        Stack shape : expr AND expr.
        Start symbol: input. *)

  | MenhirState072 : ((((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_QUESTION, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COLON, _menhir_box_input) _menhir_state
    (** State 072.
        Stack shape : expr QUESTION expr COLON.
        Start symbol: input. *)

  | MenhirState073 : (((((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_QUESTION, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COLON, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 073.
        Stack shape : expr QUESTION expr COLON expr.
        Start symbol: input. *)

  | MenhirState074 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COMMA, _menhir_box_input) _menhir_state
    (** State 074.
        Stack shape : expr COMMA.
        Start symbol: input. *)

  | MenhirState076 : (((('s, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COMMA, _menhir_box_input) _menhir_state
    (** State 076.
        Stack shape : IDENT expr COMMA.
        Start symbol: input. *)

  | MenhirState080 : ((('s, _menhir_box_input) _menhir_cell1_STRING, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 080.
        Stack shape : STRING expr.
        Start symbol: input. *)

  | MenhirState081 : (((('s, _menhir_box_input) _menhir_cell1_STRING, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COMMA, _menhir_box_input) _menhir_state
    (** State 081.
        Stack shape : STRING expr COMMA.
        Start symbol: input. *)

  | MenhirState083 : (('s, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_state
    (** State 083.
        Stack shape : IDENT.
        Start symbol: input. *)

  | MenhirState084 : ((('s, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 084.
        Stack shape : IDENT expr.
        Start symbol: input. *)

  | MenhirState085 : (((('s, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COMMA, _menhir_box_input) _menhir_state
    (** State 085.
        Stack shape : IDENT expr COMMA.
        Start symbol: input. *)

  | MenhirState094 : (('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 094.
        Stack shape : expr.
        Start symbol: input. *)

  | MenhirState095 : ((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COMMA, _menhir_box_input) _menhir_state
    (** State 095.
        Stack shape : expr COMMA.
        Start symbol: input. *)

  | MenhirState099 : ((('s, _menhir_box_input) _menhir_cell1_MINUS, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 099.
        Stack shape : MINUS expr.
        Start symbol: input. *)

  | MenhirState100 : ((('s, _menhir_box_input) _menhir_cell1_NOT, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 100.
        Stack shape : NOT expr.
        Start symbol: input. *)

  | MenhirState101 : ((('s, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 101.
        Stack shape : IDENT expr.
        Start symbol: input. *)

  | MenhirState102 : (((('s, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COMMA, _menhir_box_input) _menhir_state
    (** State 102.
        Stack shape : IDENT expr COMMA.
        Start symbol: input. *)

  | MenhirState105 : ((('s, _menhir_box_input) _menhir_cell1_WITH, _menhir_box_input) _menhir_cell1_loption_separated_nonempty_list_COMMA_separated_pair_IDENT_EQ_expr___, _menhir_box_input) _menhir_state
    (** State 105.
        Stack shape : WITH loption(separated_nonempty_list(COMMA,separated_pair(IDENT,EQ,expr))).
        Start symbol: input. *)

  | MenhirState107 : (('s, _menhir_box_input) _menhir_cell1_SWITCH, _menhir_box_input) _menhir_state
    (** State 107.
        Stack shape : SWITCH.
        Start symbol: input. *)

  | MenhirState108 : ((('s, _menhir_box_input) _menhir_cell1_SWITCH, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 108.
        Stack shape : SWITCH expr.
        Start symbol: input. *)

  | MenhirState110 : (((('s, _menhir_box_input) _menhir_cell1_SWITCH, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_option_TEXT_, _menhir_box_input) _menhir_state
    (** State 110.
        Stack shape : SWITCH expr option(TEXT).
        Start symbol: input. *)

  | MenhirState111 : (('s, _menhir_box_input) _menhir_cell1_CASE, _menhir_box_input) _menhir_state
    (** State 111.
        Stack shape : CASE.
        Start symbol: input. *)

  | MenhirState112 : ((('s, _menhir_box_input) _menhir_cell1_CASE, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 112.
        Stack shape : CASE expr.
        Start symbol: input. *)

  | MenhirState114 : (('s, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_state
    (** State 114.
        Stack shape : SET IDENT.
        Start symbol: input. *)

  | MenhirState115 : (('s, _menhir_box_input) _menhir_cell1_RAWINCLUDE, _menhir_box_input) _menhir_state
    (** State 115.
        Stack shape : RAWINCLUDE.
        Start symbol: input. *)

  | MenhirState116 : ((('s, _menhir_box_input) _menhir_cell1_RAWINCLUDE, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 116.
        Stack shape : RAWINCLUDE expr.
        Start symbol: input. *)

  | MenhirState117 : (('s, _menhir_box_input) _menhir_cell1_OPEN_EXPRESSION, _menhir_box_input) _menhir_state
    (** State 117.
        Stack shape : OPEN_EXPRESSION.
        Start symbol: input. *)

  | MenhirState118 : ((('s, _menhir_box_input) _menhir_cell1_OPEN_EXPRESSION, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 118.
        Stack shape : OPEN_EXPRESSION expr.
        Start symbol: input. *)

  | MenhirState122 : (('s, _menhir_box_input) _menhir_cell1_MACRO _menhir_cell0_IDENT, _menhir_box_input) _menhir_state
    (** State 122.
        Stack shape : MACRO IDENT.
        Start symbol: input. *)

  | MenhirState124 : (('s, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_state
    (** State 124.
        Stack shape : IDENT.
        Start symbol: input. *)

  | MenhirState125 : ((('s, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 125.
        Stack shape : IDENT expr.
        Start symbol: input. *)

  | MenhirState127 : (('s, _menhir_box_input) _menhir_cell1_IDENT _menhir_cell0_option_preceded_EQ_expr__, _menhir_box_input) _menhir_state
    (** State 127.
        Stack shape : IDENT option(preceded(EQ,expr)).
        Start symbol: input. *)

  | MenhirState131 : ((('s, _menhir_box_input) _menhir_cell1_MACRO _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_loption_separated_nonempty_list_COMMA_argument_definition__, _menhir_box_input) _menhir_state
    (** State 131.
        Stack shape : MACRO IDENT loption(separated_nonempty_list(COMMA,argument_definition)).
        Start symbol: input. *)

  | MenhirState132 : (('s, _menhir_box_input) _menhir_cell1_INCLUDE, _menhir_box_input) _menhir_state
    (** State 132.
        Stack shape : INCLUDE.
        Start symbol: input. *)

  | MenhirState133 : ((('s, _menhir_box_input) _menhir_cell1_INCLUDE, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 133.
        Stack shape : INCLUDE expr.
        Start symbol: input. *)

  | MenhirState140 : (('s, _menhir_box_input) _menhir_cell1_IMPORT _menhir_cell0_STRING, _menhir_box_input) _menhir_state
    (** State 140.
        Stack shape : IMPORT STRING.
        Start symbol: input. *)

  | MenhirState144 : (('s, _menhir_box_input) _menhir_cell1_IF, _menhir_box_input) _menhir_state
    (** State 144.
        Stack shape : IF.
        Start symbol: input. *)

  | MenhirState145 : ((('s, _menhir_box_input) _menhir_cell1_IF, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 145.
        Stack shape : IF expr.
        Start symbol: input. *)

  | MenhirState148 : (('s, _menhir_box_input) _menhir_cell1_FUNCTION _menhir_cell0_IDENT, _menhir_box_input) _menhir_state
    (** State 148.
        Stack shape : FUNCTION IDENT.
        Start symbol: input. *)

  | MenhirState150 : ((('s, _menhir_box_input) _menhir_cell1_FUNCTION _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_loption_separated_nonempty_list_COMMA_argument_definition__, _menhir_box_input) _menhir_state
    (** State 150.
        Stack shape : FUNCTION IDENT loption(separated_nonempty_list(COMMA,argument_definition)).
        Start symbol: input. *)

  | MenhirState153 : (('s, _menhir_box_input) _menhir_cell1_FROM _menhir_cell0_STRING, _menhir_box_input) _menhir_state
    (** State 153.
        Stack shape : FROM STRING.
        Start symbol: input. *)

  | MenhirState154 : (('s, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_state
    (** State 154.
        Stack shape : IDENT.
        Start symbol: input. *)

  | MenhirState156 : ((('s, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_cell1_option_preceded_AS_IDENT__, _menhir_box_input) _menhir_state
    (** State 156.
        Stack shape : IDENT option(preceded(AS,IDENT)).
        Start symbol: input. *)

  | MenhirState162 : (('s, _menhir_box_input) _menhir_cell1_FOR _menhir_cell0_option_LPAREN_, _menhir_box_input) _menhir_state
    (** State 162.
        Stack shape : FOR option(LPAREN).
        Start symbol: input. *)

  | MenhirState164 : (('s, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_state
    (** State 164.
        Stack shape : IDENT.
        Start symbol: input. *)

  | MenhirState169 : ((('s, _menhir_box_input) _menhir_cell1_FOR _menhir_cell0_option_LPAREN_, _menhir_box_input) _menhir_cell1_separated_nonempty_list_COMMA_IDENT_ _menhir_cell0_option_RPAREN_, _menhir_box_input) _menhir_state
    (** State 169.
        Stack shape : FOR option(LPAREN) separated_nonempty_list(COMMA,IDENT) option(RPAREN).
        Start symbol: input. *)

  | MenhirState170 : (((('s, _menhir_box_input) _menhir_cell1_FOR _menhir_cell0_option_LPAREN_, _menhir_box_input) _menhir_cell1_separated_nonempty_list_COMMA_IDENT_ _menhir_cell0_option_RPAREN_, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 170.
        Stack shape : FOR option(LPAREN) separated_nonempty_list(COMMA,IDENT) option(RPAREN) expr.
        Start symbol: input. *)

  | MenhirState172 : (('s, _menhir_box_input) _menhir_cell1_FILTER _menhir_cell0_IDENT, _menhir_box_input) _menhir_state
    (** State 172.
        Stack shape : FILTER IDENT.
        Start symbol: input. *)

  | MenhirState176 : (('s, _menhir_box_input) _menhir_cell1_CALL, _menhir_box_input) _menhir_state
    (** State 176.
        Stack shape : CALL.
        Start symbol: input. *)

  | MenhirState181 : (('s, _menhir_box_input) _menhir_cell1_CALL _menhir_cell0_opt_args _menhir_cell0_IDENT, _menhir_box_input) _menhir_state
    (** State 181.
        Stack shape : CALL opt_args IDENT.
        Start symbol: input. *)

  | MenhirState183 : ((('s, _menhir_box_input) _menhir_cell1_CALL _menhir_cell0_opt_args _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_loption_separated_nonempty_list_COMMA_argument_application__, _menhir_box_input) _menhir_state
    (** State 183.
        Stack shape : CALL opt_args IDENT loption(separated_nonempty_list(COMMA,argument_application)).
        Start symbol: input. *)

  | MenhirState185 : (('s, _menhir_box_input) _menhir_cell1_BLOCK _menhir_cell0_IDENT, _menhir_box_input) _menhir_state
    (** State 185.
        Stack shape : BLOCK IDENT.
        Start symbol: input. *)

  | MenhirState186 : (('s, _menhir_box_input) _menhir_cell1_AUTOESCAPE, _menhir_box_input) _menhir_state
    (** State 186.
        Stack shape : AUTOESCAPE.
        Start symbol: input. *)

  | MenhirState187 : ((('s, _menhir_box_input) _menhir_cell1_AUTOESCAPE, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 187.
        Stack shape : AUTOESCAPE expr.
        Start symbol: input. *)

  | MenhirState188 : (('s, _menhir_box_input) _menhir_cell1_stmt, _menhir_box_input) _menhir_state
    (** State 188.
        Stack shape : stmt.
        Start symbol: input. *)

  | MenhirState202 : (((('s, _menhir_box_input) _menhir_cell1_IF, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_, _menhir_box_input) _menhir_state
    (** State 202.
        Stack shape : IF expr list(stmt).
        Start symbol: input. *)

  | MenhirState203 : (((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_, _menhir_box_input) _menhir_cell1_ELSEIF, _menhir_box_input) _menhir_state
    (** State 203.
        Stack shape : expr list(stmt) ELSEIF.
        Start symbol: input. *)

  | MenhirState204 : ((((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_, _menhir_box_input) _menhir_cell1_ELSEIF, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 204.
        Stack shape : expr list(stmt) ELSEIF expr.
        Start symbol: input. *)

  | MenhirState205 : (((((('s, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_, _menhir_box_input) _menhir_cell1_ELSEIF, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_, _menhir_box_input) _menhir_state
    (** State 205.
        Stack shape : expr list(stmt) ELSEIF expr list(stmt).
        Start symbol: input. *)

  | MenhirState208 : ((((('s, _menhir_box_input) _menhir_cell1_IF, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_, _menhir_box_input) _menhir_cell1_list_preceded_ELSEIF_pair_expr_list_stmt____, _menhir_box_input) _menhir_state
    (** State 208.
        Stack shape : IF expr list(stmt) list(preceded(ELSEIF,pair(expr,list(stmt)))).
        Start symbol: input. *)

  | MenhirState216 : ((('s, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_LBRACKET, _menhir_box_input) _menhir_state
    (** State 216.
        Stack shape : SET IDENT LBRACKET.
        Start symbol: input. *)

  | MenhirState217 : (((('s, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_LBRACKET, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 217.
        Stack shape : SET IDENT LBRACKET expr.
        Start symbol: input. *)

  | MenhirState218 : ((((('s, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_LBRACKET, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_RBRACKET, _menhir_box_input) _menhir_state
    (** State 218.
        Stack shape : SET IDENT LBRACKET expr RBRACKET.
        Start symbol: input. *)

  | MenhirState225 : (((((('s, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_LBRACKET, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_RBRACKET, _menhir_box_input) _menhir_cell1_option_set_operator_, _menhir_box_input) _menhir_state
    (** State 225.
        Stack shape : SET IDENT LBRACKET expr RBRACKET option(set_operator).
        Start symbol: input. *)

  | MenhirState226 : ((((((('s, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_LBRACKET, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_RBRACKET, _menhir_box_input) _menhir_cell1_option_set_operator_, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 226.
        Stack shape : SET IDENT LBRACKET expr RBRACKET option(set_operator) expr.
        Start symbol: input. *)

  | MenhirState228 : ((('s, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_DOT _menhir_cell0_IDENT, _menhir_box_input) _menhir_state
    (** State 228.
        Stack shape : SET IDENT DOT IDENT.
        Start symbol: input. *)

  | MenhirState230 : (((('s, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_DOT _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_option_set_operator_, _menhir_box_input) _menhir_state
    (** State 230.
        Stack shape : SET IDENT DOT IDENT option(set_operator).
        Start symbol: input. *)

  | MenhirState231 : ((((('s, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_DOT _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_option_set_operator_, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 231.
        Stack shape : SET IDENT DOT IDENT option(set_operator) expr.
        Start symbol: input. *)

  | MenhirState233 : (('s _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_COMMA _menhir_cell0_IDENT, _menhir_box_input) _menhir_state
    (** State 233.
        Stack shape : IDENT COMMA IDENT.
        Start symbol: input. *)

  | MenhirState237 : ((('s, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_list_preceded_COMMA_ident__, _menhir_box_input) _menhir_state
    (** State 237.
        Stack shape : SET IDENT list(preceded(COMMA,ident)).
        Start symbol: input. *)

  | MenhirState239 : (((('s, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_list_preceded_COMMA_ident__, _menhir_box_input) _menhir_cell1_option_set_operator_, _menhir_box_input) _menhir_state
    (** State 239.
        Stack shape : SET IDENT list(preceded(COMMA,ident)) option(set_operator).
        Start symbol: input. *)

  | MenhirState240 : ((((('s, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_list_preceded_COMMA_ident__, _menhir_box_input) _menhir_cell1_option_set_operator_, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_state
    (** State 240.
        Stack shape : SET IDENT list(preceded(COMMA,ident)) option(set_operator) expr.
        Start symbol: input. *)

  | MenhirState241 : (((('s, _menhir_box_input) _menhir_cell1_CASE, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_, _menhir_box_input) _menhir_state
    (** State 241.
        Stack shape : CASE expr list(stmt).
        Start symbol: input. *)

  | MenhirState244 : ((((('s, _menhir_box_input) _menhir_cell1_SWITCH, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_option_TEXT_, _menhir_box_input) _menhir_cell1_list_preceded_CASE_pair_expr_list_stmt____, _menhir_box_input) _menhir_state
    (** State 244.
        Stack shape : SWITCH expr option(TEXT) list(preceded(CASE,pair(expr,list(stmt)))).
        Start symbol: input. *)


and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Jg_types.expression)

and ('s, 'r) _menhir_cell1_list_preceded_CASE_pair_expr_list_stmt____ = 
  | MenhirCell1_list_preceded_CASE_pair_expr_list_stmt____ of 's * ('s, 'r) _menhir_state * ((Jg_types.expression * Jg_types.ast) list)

and ('s, 'r) _menhir_cell1_list_preceded_COMMA_ident__ = 
  | MenhirCell1_list_preceded_COMMA_ident__ of 's * ('s, 'r) _menhir_state * (Jg_types.expression list)

and ('s, 'r) _menhir_cell1_list_preceded_ELSEIF_pair_expr_list_stmt____ = 
  | MenhirCell1_list_preceded_ELSEIF_pair_expr_list_stmt____ of 's * ('s, 'r) _menhir_state * ((Jg_types.expression * Jg_types.ast) list)

and ('s, 'r) _menhir_cell1_list_stmt_ = 
  | MenhirCell1_list_stmt_ of 's * ('s, 'r) _menhir_state * (Jg_types.ast)

and ('s, 'r) _menhir_cell1_loption_separated_nonempty_list_COMMA_argument_application__ = 
  | MenhirCell1_loption_separated_nonempty_list_COMMA_argument_application__ of 's * ('s, 'r) _menhir_state * ((string option * Jg_types.expression) list)

and ('s, 'r) _menhir_cell1_loption_separated_nonempty_list_COMMA_argument_definition__ = 
  | MenhirCell1_loption_separated_nonempty_list_COMMA_argument_definition__ of 's * ('s, 'r) _menhir_state * (Jg_types.arguments)

and ('s, 'r) _menhir_cell1_loption_separated_nonempty_list_COMMA_separated_pair_IDENT_EQ_expr___ = 
  | MenhirCell1_loption_separated_nonempty_list_COMMA_separated_pair_IDENT_EQ_expr___ of 's * ('s, 'r) _menhir_state * ((string * Jg_types.expression) list)

and 's _menhir_cell0_opt_args = 
  | MenhirCell0_opt_args of 's * (Jg_types.arguments)

and 's _menhir_cell0_option_LPAREN_ = 
  | MenhirCell0_option_LPAREN_ of 's * (unit option)

and 's _menhir_cell0_option_RPAREN_ = 
  | MenhirCell0_option_RPAREN_ of 's * (unit option)

and ('s, 'r) _menhir_cell1_option_TEXT_ = 
  | MenhirCell1_option_TEXT_ of 's * ('s, 'r) _menhir_state * (string option)

and ('s, 'r) _menhir_cell1_option_preceded_AS_IDENT__ = 
  | MenhirCell1_option_preceded_AS_IDENT__ of 's * ('s, 'r) _menhir_state * (string option)

and 's _menhir_cell0_option_preceded_EQ_expr__ = 
  | MenhirCell0_option_preceded_EQ_expr__ of 's * (Jg_types.expression option)

and ('s, 'r) _menhir_cell1_option_set_operator_ = 
  | MenhirCell1_option_set_operator_ of 's * ('s, 'r) _menhir_state * (token option)

and ('s, 'r) _menhir_cell1_separated_nonempty_list_COMMA_IDENT_ = 
  | MenhirCell1_separated_nonempty_list_COMMA_IDENT_ of 's * ('s, 'r) _menhir_state * (string list)

and ('s, 'r) _menhir_cell1_stmt = 
  | MenhirCell1_stmt of 's * ('s, 'r) _menhir_state * (Jg_types.statement)

and ('s, 'r) _menhir_cell1_AND = 
  | MenhirCell1_AND of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_AUTOESCAPE = 
  | MenhirCell1_AUTOESCAPE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_BLOCK = 
  | MenhirCell1_BLOCK of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_CALL = 
  | MenhirCell1_CALL of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_CASE = 
  | MenhirCell1_CASE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_COLON = 
  | MenhirCell1_COLON of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_COMMA = 
  | MenhirCell1_COMMA of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_DEFAULT = 
  | MenhirCell1_DEFAULT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_DIV = 
  | MenhirCell1_DIV of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_DOT = 
  | MenhirCell1_DOT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_ELSEIF = 
  | MenhirCell1_ELSEIF of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_EQ_EQ = 
  | MenhirCell1_EQ_EQ of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_FATARROW = 
  | MenhirCell1_FATARROW of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_FILTER = 
  | MenhirCell1_FILTER of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_FOR = 
  | MenhirCell1_FOR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_FROM = 
  | MenhirCell1_FROM of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_FUNCTION = 
  | MenhirCell1_FUNCTION of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_GT = 
  | MenhirCell1_GT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_GT_EQ = 
  | MenhirCell1_GT_EQ of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IDENT = 
  | MenhirCell1_IDENT of 's * ('s, 'r) _menhir_state * (
# 60 "src/jg_parser.mly"
       (string)
# 873 "src/jg_parser.ml"
)

and 's _menhir_cell0_IDENT = 
  | MenhirCell0_IDENT of 's * (
# 60 "src/jg_parser.mly"
       (string)
# 880 "src/jg_parser.ml"
)

and ('s, 'r) _menhir_cell1_IF = 
  | MenhirCell1_IF of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IMPORT = 
  | MenhirCell1_IMPORT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IN = 
  | MenhirCell1_IN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_INCLUDE = 
  | MenhirCell1_INCLUDE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IS = 
  | MenhirCell1_IS of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LBRACE = 
  | MenhirCell1_LBRACE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LBRACKET = 
  | MenhirCell1_LBRACKET of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LPAREN = 
  | MenhirCell1_LPAREN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LT = 
  | MenhirCell1_LT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LT_EQ = 
  | MenhirCell1_LT_EQ of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_MACRO = 
  | MenhirCell1_MACRO of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_MINUS = 
  | MenhirCell1_MINUS of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_MOD = 
  | MenhirCell1_MOD of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_NEQ = 
  | MenhirCell1_NEQ of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_NOT = 
  | MenhirCell1_NOT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_OPEN_EXPRESSION = 
  | MenhirCell1_OPEN_EXPRESSION of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_OR = 
  | MenhirCell1_OR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PLUS = 
  | MenhirCell1_PLUS of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_POWER = 
  | MenhirCell1_POWER of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_QUESTION = 
  | MenhirCell1_QUESTION of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RAWINCLUDE = 
  | MenhirCell1_RAWINCLUDE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RBRACKET = 
  | MenhirCell1_RBRACKET of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_SET = 
  | MenhirCell1_SET of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_STRING = 
  | MenhirCell1_STRING of 's * ('s, 'r) _menhir_state * (
# 58 "src/jg_parser.mly"
       (string)
# 956 "src/jg_parser.ml"
)

and 's _menhir_cell0_STRING = 
  | MenhirCell0_STRING of 's * (
# 58 "src/jg_parser.mly"
       (string)
# 963 "src/jg_parser.ml"
)

and ('s, 'r) _menhir_cell1_SWITCH = 
  | MenhirCell1_SWITCH of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TIMES = 
  | MenhirCell1_TIMES of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_VLINE = 
  | MenhirCell1_VLINE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_WITH = 
  | MenhirCell1_WITH of 's * ('s, 'r) _menhir_state

and _menhir_box_input = 
  | MenhirBox_input of (Jg_types.ast) [@@unboxed]

let _menhir_action_001 =
  fun _1 ->
    let _1 = 
# 234 "src/jg_parser.mly"
                     ( IdentExpr _1 )
# 986 "src/jg_parser.ml"
     in
    (
# 239 "src/jg_parser.mly"
        ( pel "ident"; _1 )
# 991 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_002 =
  fun _1 ->
    (
# 240 "src/jg_parser.mly"
      ( pel "int"; LiteralExpr (Tint _1) )
# 999 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_003 =
  fun _1 ->
    (
# 241 "src/jg_parser.mly"
        ( pel "float"; LiteralExpr (Tfloat _1) )
# 1007 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_004 =
  fun () ->
    (
# 242 "src/jg_parser.mly"
       ( pel "true"; LiteralExpr (Tbool true) )
# 1015 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_005 =
  fun () ->
    (
# 243 "src/jg_parser.mly"
        ( pel "false"; LiteralExpr (Tbool false) )
# 1023 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_006 =
  fun _1 ->
    (
# 244 "src/jg_parser.mly"
         ( pel "string"; LiteralExpr (Tstr _1) )
# 1031 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_007 =
  fun () ->
    (
# 245 "src/jg_parser.mly"
       ( pel "null"; LiteralExpr Tnull )
# 1039 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_008 =
  fun _1 _3 ->
    (
# 246 "src/jg_parser.mly"
                 ( pel "dot_lookup"; DotExpr(_1, _3) )
# 1047 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_009 =
  fun _1 _3 ->
    (
# 247 "src/jg_parser.mly"
                              ( pel "bracket_lookup"; BracketExpr(_1, _3) )
# 1055 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_010 =
  fun _2 ->
    (
# 248 "src/jg_parser.mly"
           ( pel "not expr"; NotOpExpr(_2) )
# 1063 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_011 =
  fun _2 ->
    (
# 249 "src/jg_parser.mly"
                          ( pel "negative"; NegativeOpExpr(_2) )
# 1071 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_012 =
  fun xs ->
    let _2 = 
# 241 "<standard.mly>"
    ( xs )
# 1079 "src/jg_parser.ml"
     in
    (
# 250 "src/jg_parser.mly"
                                                ( pel "list expr"; ListExpr(_2) )
# 1084 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_013 =
  fun xs ->
    let o = 
# 241 "<standard.mly>"
    ( xs )
# 1092 "src/jg_parser.ml"
     in
    (
# 252 "src/jg_parser.mly"
  ( pel "obj expr"; ObjExpr o )
# 1097 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_014 =
  fun _1 _3 ->
    (
# 253 "src/jg_parser.mly"
                 ( pel "plus"; PlusOpExpr(_1, _3) )
# 1105 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_015 =
  fun _1 _3 ->
    (
# 254 "src/jg_parser.mly"
                  ( pel "minus"; MinusOpExpr(_1, _3) )
# 1113 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_016 =
  fun _1 _3 ->
    (
# 255 "src/jg_parser.mly"
                ( pel "div"; DivOpExpr(_1, _3) )
# 1121 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_017 =
  fun _1 _3 ->
    (
# 256 "src/jg_parser.mly"
                ( pel "mod"; ModOpExpr(_1, _3) )
# 1129 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_018 =
  fun _1 _3 ->
    (
# 257 "src/jg_parser.mly"
                  ( pel "times"; TimesOpExpr(_1, _3) )
# 1137 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_019 =
  fun _1 _3 ->
    (
# 258 "src/jg_parser.mly"
                  ( pel "power"; PowerOpExpr(_1, _3) )
# 1145 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_020 =
  fun _1 _3 ->
    (
# 259 "src/jg_parser.mly"
                ( pel "and"; AndOpExpr(_1, _3) )
# 1153 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_021 =
  fun _1 _3 ->
    (
# 260 "src/jg_parser.mly"
               ( pel "or"; OrOpExpr(_1, _3) )
# 1161 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_022 =
  fun _1 _3 ->
    (
# 261 "src/jg_parser.mly"
                  ( pel "eqeq"; EqEqOpExpr(_1, _3) )
# 1169 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_023 =
  fun _1 _3 ->
    (
# 262 "src/jg_parser.mly"
                ( pel "noteq"; NotEqOpExpr(_1, _3) )
# 1177 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_024 =
  fun _1 _3 ->
    (
# 263 "src/jg_parser.mly"
               ( pel "lt"; LtOpExpr(_1, _3) )
# 1185 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_025 =
  fun _1 _3 ->
    (
# 264 "src/jg_parser.mly"
               ( pel "gt"; GtOpExpr(_1, _3) )
# 1193 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_026 =
  fun _1 _3 ->
    (
# 265 "src/jg_parser.mly"
                  ( pel "lteq"; LtEqOpExpr(_1, _3) )
# 1201 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_027 =
  fun _1 _3 ->
    (
# 266 "src/jg_parser.mly"
                  ( pel "gteq"; GtEqOpExpr(_1, _3) )
# 1209 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_028 =
  fun _1 _3 ->
    (
# 267 "src/jg_parser.mly"
               ( pel "inop"; InOpExpr(_1, _3) )
# 1217 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_029 =
  fun _1 _3 ->
    (
# 268 "src/jg_parser.mly"
                  ( pel "expr|expr -> ApplyExpr"; ApplyExpr(_3, [None, _1]) )
# 1225 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_030 =
  fun _1 _1_inlined1 _4 ->
    let _3 =
      let _1 = _1_inlined1 in
      
# 234 "src/jg_parser.mly"
                     ( IdentExpr _1 )
# 1235 "src/jg_parser.ml"
      
    in
    (
# 269 "src/jg_parser.mly"
                     (
  (* when expr1 is fun and expr2 is args without LPAREN and RPAREN. *)
  (* for example, 'a is divisableby 2' *)
  pel "test(apply)";
  TestOpExpr(_1, ApplyExpr(_3, [None, _4]))
)
# 1246 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_031 =
  fun _1 _1_inlined1 ->
    let _3 =
      let _1 = _1_inlined1 in
      
# 234 "src/jg_parser.mly"
                     ( IdentExpr _1 )
# 1256 "src/jg_parser.ml"
      
    in
    (
# 275 "src/jg_parser.mly"
                ( pel "test"; TestOpExpr(_1,_3) )
# 1262 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_032 =
  fun xs ->
    let _3 = 
# 241 "<standard.mly>"
    ( xs )
# 1270 "src/jg_parser.ml"
     in
    (
# 276 "src/jg_parser.mly"
                                                                    ( pel "apply(expr_list)"; ApplyExpr(IdentExpr("default"), _3) )
# 1275 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_033 =
  fun _1 xs ->
    let _3 = 
# 241 "<standard.mly>"
    ( xs )
# 1283 "src/jg_parser.ml"
     in
    (
# 277 "src/jg_parser.mly"
                                                                 ( pel "apply(expr_list)"; ApplyExpr(_1, _3) )
# 1288 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_034 =
  fun xs ->
    let _2 = 
# 241 "<standard.mly>"
    ( xs )
# 1296 "src/jg_parser.ml"
     in
    (
# 279 "src/jg_parser.mly"
  ( pel "set expr"; match _2 with [ e ] -> e | _ -> SetExpr _2 )
# 1301 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_035 =
  fun _1 _3 ->
    (
# 281 "src/jg_parser.mly"
  ( pel "fat arrow";
    let args = match _1 with
      | IdentExpr i -> [ i ]
      | SetExpr set -> List.map (function IdentExpr i -> i | _ -> assert false) set
      | _ -> assert false
    in
    FunctionExpression(args, _3)
)
# 1316 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_036 =
  fun _1 _3 _5 ->
    (
# 289 "src/jg_parser.mly"
                                ( TernaryOpExpr (_1, _3, _5) )
# 1324 "src/jg_parser.ml"
     : (Jg_types.expression))

let _menhir_action_037 =
  fun _1 ->
    (
# 113 "src/jg_parser.mly"
                 ( _1 )
# 1332 "src/jg_parser.ml"
     : (Jg_types.ast))

let _menhir_action_038 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 1340 "src/jg_parser.ml"
     : ((Jg_types.expression * Jg_types.ast) list))

let _menhir_action_039 =
  fun x xs y ->
    let x =
      let x = 
# 172 "<standard.mly>"
    ( (x, y) )
# 1349 "src/jg_parser.ml"
       in
      
# 188 "<standard.mly>"
    ( x )
# 1354 "src/jg_parser.ml"
      
    in
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 1360 "src/jg_parser.ml"
     : ((Jg_types.expression * Jg_types.ast) list))

let _menhir_action_040 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 1368 "src/jg_parser.ml"
     : (Jg_types.expression list))

let _menhir_action_041 =
  fun _1_inlined1 xs ->
    let x =
      let x =
        let _1 = _1_inlined1 in
        
# 234 "src/jg_parser.mly"
                     ( IdentExpr _1 )
# 1379 "src/jg_parser.ml"
        
      in
      
# 188 "<standard.mly>"
    ( x )
# 1385 "src/jg_parser.ml"
      
    in
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 1391 "src/jg_parser.ml"
     : (Jg_types.expression list))

let _menhir_action_042 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 1399 "src/jg_parser.ml"
     : ((Jg_types.expression * Jg_types.ast) list))

let _menhir_action_043 =
  fun x xs y ->
    let x =
      let x = 
# 172 "<standard.mly>"
    ( (x, y) )
# 1408 "src/jg_parser.ml"
       in
      
# 188 "<standard.mly>"
    ( x )
# 1413 "src/jg_parser.ml"
      
    in
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 1419 "src/jg_parser.ml"
     : ((Jg_types.expression * Jg_types.ast) list))

let _menhir_action_044 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 1427 "src/jg_parser.ml"
     : (Jg_types.ast))

let _menhir_action_045 =
  fun x xs ->
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 1435 "src/jg_parser.ml"
     : (Jg_types.ast))

let _menhir_action_046 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 1443 "src/jg_parser.ml"
     : ((string * string option) list))

let _menhir_action_047 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 1451 "src/jg_parser.ml"
     : ((string * string option) list))

let _menhir_action_048 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 1459 "src/jg_parser.ml"
     : ((string option * Jg_types.expression) list))

let _menhir_action_049 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 1467 "src/jg_parser.ml"
     : ((string option * Jg_types.expression) list))

let _menhir_action_050 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 1475 "src/jg_parser.ml"
     : (Jg_types.arguments))

let _menhir_action_051 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 1483 "src/jg_parser.ml"
     : (Jg_types.arguments))

let _menhir_action_052 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 1491 "src/jg_parser.ml"
     : (Jg_types.expression list))

let _menhir_action_053 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 1499 "src/jg_parser.ml"
     : (Jg_types.expression list))

let _menhir_action_054 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 1507 "src/jg_parser.ml"
     : ((string * Jg_types.expression) list))

let _menhir_action_055 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 1515 "src/jg_parser.ml"
     : ((string * Jg_types.expression) list))

let _menhir_action_056 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 1523 "src/jg_parser.ml"
     : ((string * Jg_types.expression) list))

let _menhir_action_057 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 1531 "src/jg_parser.ml"
     : ((string * Jg_types.expression) list))

let _menhir_action_058 =
  fun () ->
    (
# 293 "src/jg_parser.mly"
            ( pel "opt_args empty"; [] )
# 1539 "src/jg_parser.ml"
     : (Jg_types.arguments))

let _menhir_action_059 =
  fun xs ->
    let _2 = 
# 241 "<standard.mly>"
    ( xs )
# 1547 "src/jg_parser.ml"
     in
    (
# 294 "src/jg_parser.mly"
                                                           ( _2 )
# 1552 "src/jg_parser.ml"
     : (Jg_types.arguments))

let _menhir_action_060 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1560 "src/jg_parser.ml"
     : (string option))

let _menhir_action_061 =
  fun x ->
    (
# 114 "<standard.mly>"
    ( Some x )
# 1568 "src/jg_parser.ml"
     : (string option))

let _menhir_action_062 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1576 "src/jg_parser.ml"
     : (unit option))

let _menhir_action_063 =
  fun x ->
    (
# 114 "<standard.mly>"
    ( Some x )
# 1584 "src/jg_parser.ml"
     : (unit option))

let _menhir_action_064 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1592 "src/jg_parser.ml"
     : (unit option))

let _menhir_action_065 =
  fun x ->
    (
# 114 "<standard.mly>"
    ( Some x )
# 1600 "src/jg_parser.ml"
     : (unit option))

let _menhir_action_066 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1608 "src/jg_parser.ml"
     : (string option))

let _menhir_action_067 =
  fun x ->
    (
# 114 "<standard.mly>"
    ( Some x )
# 1616 "src/jg_parser.ml"
     : (string option))

let _menhir_action_068 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1624 "src/jg_parser.ml"
     : (bool option))

let _menhir_action_069 =
  fun () ->
    let x = 
# 230 "src/jg_parser.mly"
               ( true )
# 1632 "src/jg_parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1637 "src/jg_parser.ml"
     : (bool option))

let _menhir_action_070 =
  fun () ->
    let x = 
# 231 "src/jg_parser.mly"
                  ( false )
# 1645 "src/jg_parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1650 "src/jg_parser.ml"
     : (bool option))

let _menhir_action_071 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1658 "src/jg_parser.ml"
     : (string option))

let _menhir_action_072 =
  fun x ->
    let x = 
# 188 "<standard.mly>"
    ( x )
# 1666 "src/jg_parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1671 "src/jg_parser.ml"
     : (string option))

let _menhir_action_073 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1679 "src/jg_parser.ml"
     : (Jg_types.ast option))

let _menhir_action_074 =
  fun x ->
    let x = 
# 188 "<standard.mly>"
    ( x )
# 1687 "src/jg_parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1692 "src/jg_parser.ml"
     : (Jg_types.ast option))

let _menhir_action_075 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1700 "src/jg_parser.ml"
     : (Jg_types.ast option))

let _menhir_action_076 =
  fun x ->
    let x = 
# 188 "<standard.mly>"
    ( x )
# 1708 "src/jg_parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1713 "src/jg_parser.ml"
     : (Jg_types.ast option))

let _menhir_action_077 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1721 "src/jg_parser.ml"
     : (Jg_types.expression option))

let _menhir_action_078 =
  fun x ->
    let x = 
# 188 "<standard.mly>"
    ( x )
# 1729 "src/jg_parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1734 "src/jg_parser.ml"
     : (Jg_types.expression option))

let _menhir_action_079 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1742 "src/jg_parser.ml"
     : (token option))

let _menhir_action_080 =
  fun () ->
    let x = 
# 121 "src/jg_parser.mly"
                           ( PLUS )
# 1750 "src/jg_parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1755 "src/jg_parser.ml"
     : (token option))

let _menhir_action_081 =
  fun () ->
    let x = 
# 121 "src/jg_parser.mly"
                                            ( MINUS )
# 1763 "src/jg_parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1768 "src/jg_parser.ml"
     : (token option))

let _menhir_action_082 =
  fun () ->
    let x = 
# 121 "src/jg_parser.mly"
                                                            ( DIV )
# 1776 "src/jg_parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1781 "src/jg_parser.ml"
     : (token option))

let _menhir_action_083 =
  fun () ->
    let x = 
# 121 "src/jg_parser.mly"
                                                                            ( TIMES )
# 1789 "src/jg_parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1794 "src/jg_parser.ml"
     : (token option))

let _menhir_action_084 =
  fun () ->
    let x = 
# 121 "src/jg_parser.mly"
                                                                                            ( MOD )
# 1802 "src/jg_parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1807 "src/jg_parser.ml"
     : (token option))

let _menhir_action_085 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 1815 "src/jg_parser.ml"
     : (string list))

let _menhir_action_086 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 1823 "src/jg_parser.ml"
     : (string list))

let _menhir_action_087 =
  fun _1 _2 ->
    let x = 
# 119 "src/jg_parser.mly"
                                          ( (_1, _2) )
# 1831 "src/jg_parser.ml"
     in
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 1836 "src/jg_parser.ml"
     : ((string * string option) list))

let _menhir_action_088 =
  fun _1 _2_inlined1 xs ->
    let x =
      let _2 = _2_inlined1 in
      
# 119 "src/jg_parser.mly"
                                          ( (_1, _2) )
# 1846 "src/jg_parser.ml"
      
    in
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 1852 "src/jg_parser.ml"
     : ((string * string option) list))

let _menhir_action_089 =
  fun _2 ->
    let x =
      let _1 = 
# 123 "<standard.mly>"
    ( None )
# 1861 "src/jg_parser.ml"
       in
      
# 117 "src/jg_parser.mly"
                                                                  ( (_1, _2) )
# 1866 "src/jg_parser.ml"
      
    in
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 1872 "src/jg_parser.ml"
     : ((string option * Jg_types.expression) list))

let _menhir_action_090 =
  fun _2 x ->
    let x =
      let _1 =
        let x = 
# 196 "<standard.mly>"
    ( x )
# 1882 "src/jg_parser.ml"
         in
        
# 126 "<standard.mly>"
    ( Some x )
# 1887 "src/jg_parser.ml"
        
      in
      
# 117 "src/jg_parser.mly"
                                                                  ( (_1, _2) )
# 1893 "src/jg_parser.ml"
      
    in
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 1899 "src/jg_parser.ml"
     : ((string option * Jg_types.expression) list))

let _menhir_action_091 =
  fun _2_inlined1 xs ->
    let x =
      let _2 = _2_inlined1 in
      let _1 = 
# 123 "<standard.mly>"
    ( None )
# 1909 "src/jg_parser.ml"
       in
      
# 117 "src/jg_parser.mly"
                                                                  ( (_1, _2) )
# 1914 "src/jg_parser.ml"
      
    in
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 1920 "src/jg_parser.ml"
     : ((string option * Jg_types.expression) list))

let _menhir_action_092 =
  fun _2_inlined2 x xs ->
    let x =
      let _2 = _2_inlined2 in
      let _1 =
        let x = 
# 196 "<standard.mly>"
    ( x )
# 1931 "src/jg_parser.ml"
         in
        
# 126 "<standard.mly>"
    ( Some x )
# 1936 "src/jg_parser.ml"
        
      in
      
# 117 "src/jg_parser.mly"
                                                                  ( (_1, _2) )
# 1942 "src/jg_parser.ml"
      
    in
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 1948 "src/jg_parser.ml"
     : ((string option * Jg_types.expression) list))

let _menhir_action_093 =
  fun _1 _2 ->
    let x = 
# 115 "src/jg_parser.mly"
                                                       ( (_1, _2) )
# 1956 "src/jg_parser.ml"
     in
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 1961 "src/jg_parser.ml"
     : (Jg_types.arguments))

let _menhir_action_094 =
  fun _1 _2_inlined1 xs ->
    let x =
      let _2 = _2_inlined1 in
      
# 115 "src/jg_parser.mly"
                                                       ( (_1, _2) )
# 1971 "src/jg_parser.ml"
      
    in
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 1977 "src/jg_parser.ml"
     : (Jg_types.arguments))

let _menhir_action_095 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 1985 "src/jg_parser.ml"
     : (Jg_types.expression list))

let _menhir_action_096 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 1993 "src/jg_parser.ml"
     : (Jg_types.expression list))

let _menhir_action_097 =
  fun x y ->
    let x = 
# 180 "<standard.mly>"
    ( (x, y) )
# 2001 "src/jg_parser.ml"
     in
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 2006 "src/jg_parser.ml"
     : ((string * Jg_types.expression) list))

let _menhir_action_098 =
  fun x xs y ->
    let x = 
# 180 "<standard.mly>"
    ( (x, y) )
# 2014 "src/jg_parser.ml"
     in
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 2019 "src/jg_parser.ml"
     : ((string * Jg_types.expression) list))

let _menhir_action_099 =
  fun _1 y ->
    let x =
      let x = 
# 236 "src/jg_parser.mly"
                      (  _1 )
# 2028 "src/jg_parser.ml"
       in
      
# 180 "<standard.mly>"
    ( (x, y) )
# 2033 "src/jg_parser.ml"
      
    in
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 2039 "src/jg_parser.ml"
     : ((string * Jg_types.expression) list))

let _menhir_action_100 =
  fun _1 y ->
    let x =
      let x = 
# 236 "src/jg_parser.mly"
                                       ( _1 )
# 2048 "src/jg_parser.ml"
       in
      
# 180 "<standard.mly>"
    ( (x, y) )
# 2053 "src/jg_parser.ml"
      
    in
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 2059 "src/jg_parser.ml"
     : ((string * Jg_types.expression) list))

let _menhir_action_101 =
  fun _1 xs y ->
    let x =
      let x = 
# 236 "src/jg_parser.mly"
                      (  _1 )
# 2068 "src/jg_parser.ml"
       in
      
# 180 "<standard.mly>"
    ( (x, y) )
# 2073 "src/jg_parser.ml"
      
    in
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 2079 "src/jg_parser.ml"
     : ((string * Jg_types.expression) list))

let _menhir_action_102 =
  fun _1 xs y ->
    let x =
      let x = 
# 236 "src/jg_parser.mly"
                                       ( _1 )
# 2088 "src/jg_parser.ml"
       in
      
# 180 "<standard.mly>"
    ( (x, y) )
# 2093 "src/jg_parser.ml"
      
    in
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 2099 "src/jg_parser.ml"
     : ((string * Jg_types.expression) list))

let _menhir_action_103 =
  fun _2 ->
    (
# 125 "src/jg_parser.mly"
                                        ( pel "expand expr"; ExpandStatement(_2) )
# 2107 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_104 =
  fun _1_inlined1 _4 _5 _7 ->
    let _2 =
      let _1 = _1_inlined1 in
      
# 234 "src/jg_parser.mly"
                     ( IdentExpr _1 )
# 2117 "src/jg_parser.ml"
      
    in
    (
# 127 "src/jg_parser.mly"
  ( pel "set";
    let k = DotExpr (_2, _4) in
    match _5 with
    | None -> SetStatement (k, _7)
    | Some PLUS -> SetStatement (k, PlusOpExpr(k, _7))
    | Some MINUS -> SetStatement (k, MinusOpExpr(k, _7))
    | Some TIMES -> SetStatement (k, TimesOpExpr(k, _7))
    | Some DIV -> SetStatement (k, DivOpExpr(k, _7))
    | Some MOD -> SetStatement (k, ModOpExpr(k, _7))
    | Some _ -> assert false
  )
# 2133 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_105 =
  fun _1_inlined1 _4 _6 _8 ->
    let _2 =
      let _1 = _1_inlined1 in
      
# 234 "src/jg_parser.mly"
                     ( IdentExpr _1 )
# 2143 "src/jg_parser.ml"
      
    in
    (
# 139 "src/jg_parser.mly"
  ( pel "set";
    let k = BracketExpr (_2, _4) in
    match _6 with
    | None -> SetStatement (k, _8)
    | Some PLUS -> SetStatement (k, PlusOpExpr(k, _8))
    | Some MINUS -> SetStatement (k, MinusOpExpr(k, _8))
    | Some TIMES -> SetStatement (k, TimesOpExpr(k, _8))
    | Some DIV -> SetStatement (k, DivOpExpr(k, _8))
    | Some MOD -> SetStatement (k, ModOpExpr(k, _8))
    | Some _ -> assert false
  )
# 2159 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_106 =
  fun _1_inlined1 _3 _4 _6 ->
    let _2 =
      let _1 = _1_inlined1 in
      
# 234 "src/jg_parser.mly"
                     ( IdentExpr _1 )
# 2169 "src/jg_parser.ml"
      
    in
    (
# 151 "src/jg_parser.mly"
  (
    pel "set";
    match _2 :: _3, _6 with
    | [ IdentExpr n ], ApplyExpr (IdentExpr "namespace", init) ->
       assert (_4 = None) ;
       let extract_assign = function
         | (Some n, v) -> (n, v)
         | _ -> assert false in
       NamespaceStatement (n, List.map extract_assign init)
    | [ id ], expr ->
       begin
         let k = SetExpr [ id ] in
         match _4 with
         | None -> SetStatement (k, expr)
         | Some PLUS -> SetStatement (k, PlusOpExpr(id, expr))
         | Some MINUS -> SetStatement (k, MinusOpExpr(id, expr))
         | Some TIMES -> SetStatement (k, TimesOpExpr(id, expr))
         | Some DIV -> SetStatement (k, DivOpExpr(id, expr))
         | Some MOD -> SetStatement (k, ModOpExpr(id, expr))
         | Some _ -> assert false
       end
    | idents, exprs ->
       assert (_4 = None) ;
       pel "set sts";
       SetStatement (SetExpr idents, exprs)
  )
# 2200 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_107 =
  fun _2 _3 ->
    (
# 178 "src/jg_parser.mly"
  ( pel "set_block";
    SetBlockStatement(_2, _3)
  )
# 2210 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_108 =
  fun _2 ->
    (
# 181 "src/jg_parser.mly"
                 ( pel "extends sts"; ExtendsStatement(_2) )
# 2218 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_109 =
  fun _2 _3 ->
    (
# 182 "src/jg_parser.mly"
                             ( pel "block sts2"; BlockStatement(_2, _3) )
# 2226 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_110 =
  fun _2 _3 ->
    (
# 183 "src/jg_parser.mly"
                               ( pel "filter sts"; FilterStatement(_2, _3) )
# 2234 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_111 =
  fun _2 _3 ->
    (
# 184 "src/jg_parser.mly"
                        ( pel "include sts"; IncludeStatement(_2, _3 <> Some false) )
# 2242 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_112 =
  fun _2 ->
    (
# 185 "src/jg_parser.mly"
                  ( pel "raw include sts"; RawIncludeStatement(_2) )
# 2250 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_113 =
  fun _2 _3 ->
    (
# 186 "src/jg_parser.mly"
                                     ( pel "import sts"; ImportStatement(_2, _3) )
# 2258 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_114 =
  fun _2 xs ->
    let _4 = 
# 241 "<standard.mly>"
    ( xs )
# 2266 "src/jg_parser.ml"
     in
    (
# 187 "src/jg_parser.mly"
                                                  ( pel "from import sts"; FromImportStatement(_2, _4) )
# 2271 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_115 =
  fun _2 _6 _8 xs ->
    let _4 = 
# 241 "<standard.mly>"
    ( xs )
# 2279 "src/jg_parser.ml"
     in
    (
# 189 "src/jg_parser.mly"
  ( pel "macro sts"; (match _8 with Some n -> assert (_2 = n) | _ -> ()) ; MacroStatement(_2, _4, _6) )
# 2284 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_116 =
  fun _2 _6 xs ->
    let _4 = 
# 241 "<standard.mly>"
    ( xs )
# 2292 "src/jg_parser.ml"
     in
    (
# 191 "src/jg_parser.mly"
  ( pel "function sts"; FunctionStatement(_2, _4, _6) )
# 2297 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_117 =
  fun _2 _3 _7 xs ->
    let _5 = 
# 241 "<standard.mly>"
    ( xs )
# 2305 "src/jg_parser.ml"
     in
    (
# 193 "src/jg_parser.mly"
  ( pel "call sts"; CallStatement(_3, _2, _5, _7) )
# 2310 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_118 =
  fun e ei x y ->
    let i = 
# 172 "<standard.mly>"
    ( (x, y) )
# 2318 "src/jg_parser.ml"
     in
    (
# 199 "src/jg_parser.mly"
  (
  pel "if sts";
  IfStatement (List.fold_right
                 (fun (a, b) acc -> (Some a, b) :: acc) (i :: ei)
                 (match e with None -> [] | Some stmts -> [ (None, stmts) ]))
  )
# 2328 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_119 =
  fun cases default e ws ->
    (
# 211 "src/jg_parser.mly"
  (
    (match ws with Some s -> assert (String.trim s = "") | None -> ()) ;
    let rec extract = function
      | OrOpExpr (e1, e2) -> extract e1 @ extract e2
      | e -> [e] in
    SwitchStatement ( e
                    , List.fold_right
                        (fun (a, b) acc -> (extract a, b) :: acc) (cases)
                        (match default with None -> [] | Some stmts -> [ ([], stmts) ]))
  )
# 2345 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_120 =
  fun _3 _6 _7 ->
    (
# 222 "src/jg_parser.mly"
  ( pel "for sts"; ForStatement(_3, _6, _7) )
# 2353 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_121 =
  fun _3 xs ->
    let _2 = 
# 241 "<standard.mly>"
    ( xs )
# 2361 "src/jg_parser.ml"
     in
    (
# 224 "src/jg_parser.mly"
  ( pel "with sts1"; WithStatement(_2, _3) )
# 2366 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_122 =
  fun _2 _3 ->
    (
# 225 "src/jg_parser.mly"
                                      ( pel "autoescape"; AutoEscapeStatement(_2, _3) )
# 2374 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_action_123 =
  fun _1 ->
    (
# 226 "src/jg_parser.mly"
       ( pel "text sts"; TextStatement(_1) )
# 2382 "src/jg_parser.ml"
     : (Jg_types.statement))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | AND ->
        "AND"
    | AS ->
        "AS"
    | AUTOESCAPE ->
        "AUTOESCAPE"
    | BLOCK ->
        "BLOCK"
    | CALL ->
        "CALL"
    | CASE ->
        "CASE"
    | CLOSE_EXPRESSION ->
        "CLOSE_EXPRESSION"
    | COLON ->
        "COLON"
    | COMMA ->
        "COMMA"
    | CONTEXT ->
        "CONTEXT"
    | DEFAULT ->
        "DEFAULT"
    | DIV ->
        "DIV"
    | DOT ->
        "DOT"
    | ELSE ->
        "ELSE"
    | ELSEIF ->
        "ELSEIF"
    | ENDAUTOESCAPE ->
        "ENDAUTOESCAPE"
    | ENDBLOCK ->
        "ENDBLOCK"
    | ENDCALL ->
        "ENDCALL"
    | ENDFILTER ->
        "ENDFILTER"
    | ENDFOR ->
        "ENDFOR"
    | ENDFUNCTION ->
        "ENDFUNCTION"
    | ENDIF ->
        "ENDIF"
    | ENDMACRO ->
        "ENDMACRO"
    | ENDSET ->
        "ENDSET"
    | ENDSWITCH ->
        "ENDSWITCH"
    | ENDWITH ->
        "ENDWITH"
    | EOF ->
        "EOF"
    | EQ ->
        "EQ"
    | EQ_EQ ->
        "EQ_EQ"
    | EXTENDS ->
        "EXTENDS"
    | FALSE ->
        "FALSE"
    | FATARROW ->
        "FATARROW"
    | FILTER ->
        "FILTER"
    | FLOAT _ ->
        "FLOAT"
    | FOR ->
        "FOR"
    | FROM ->
        "FROM"
    | FUNCTION ->
        "FUNCTION"
    | GT ->
        "GT"
    | GT_EQ ->
        "GT_EQ"
    | IDENT _ ->
        "IDENT"
    | IF ->
        "IF"
    | IMPORT ->
        "IMPORT"
    | IN ->
        "IN"
    | INCLUDE ->
        "INCLUDE"
    | INT _ ->
        "INT"
    | IS ->
        "IS"
    | LBRACE ->
        "LBRACE"
    | LBRACKET ->
        "LBRACKET"
    | LPAREN ->
        "LPAREN"
    | LT ->
        "LT"
    | LT_EQ ->
        "LT_EQ"
    | MACRO ->
        "MACRO"
    | MINUS ->
        "MINUS"
    | MOD ->
        "MOD"
    | NEQ ->
        "NEQ"
    | NOT ->
        "NOT"
    | NULL ->
        "NULL"
    | OPEN_EXPRESSION ->
        "OPEN_EXPRESSION"
    | OR ->
        "OR"
    | PLUS ->
        "PLUS"
    | POWER ->
        "POWER"
    | QUESTION ->
        "QUESTION"
    | RAWINCLUDE ->
        "RAWINCLUDE"
    | RBRACE ->
        "RBRACE"
    | RBRACKET ->
        "RBRACKET"
    | RPAREN ->
        "RPAREN"
    | SET ->
        "SET"
    | STRING _ ->
        "STRING"
    | SWITCH ->
        "SWITCH"
    | TEXT _ ->
        "TEXT"
    | TIMES ->
        "TIMES"
    | TRUE ->
        "TRUE"
    | VLINE ->
        "VLINE"
    | WITH ->
        "WITH"
    | WITHOUT ->
        "WITHOUT"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_250 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _v _tok ->
      match (_tok : MenhirBasics.token) with
      | EOF ->
          let _1 = _v in
          let _v = _menhir_action_037 _1 in
          MenhirBox_input _v
      | _ ->
          _eRR ()
  
  let rec _menhir_run_001 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_WITH (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState001 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | AUTOESCAPE | BLOCK | CALL | ENDWITH | EXTENDS | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | SET | SWITCH | TEXT _ | WITH ->
          let _v = _menhir_action_054 () in
          _menhir_goto_loption_separated_nonempty_list_COMMA_separated_pair_IDENT_EQ_expr___ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_002 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState003 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FLOAT _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | DEFAULT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_004 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_004 () in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState239 ->
          _menhir_run_240 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState230 ->
          _menhir_run_231 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState225 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState216 ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState203 ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState186 ->
          _menhir_run_187 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState169 ->
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState144 ->
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState132 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState124 ->
          _menhir_run_125 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState117 ->
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState115 ->
          _menhir_run_116 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState111 ->
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState107 ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState003 ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState007 ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState008 ->
          _menhir_run_099 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState009 ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState095 ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState010 ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState083 ->
          _menhir_run_084 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState013 ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState072 ->
          _menhir_run_073 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState070 ->
          _menhir_run_071 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState068 ->
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState066 ->
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState064 ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState062 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState059 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState057 ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState055 ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState053 ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState051 ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState049 ->
          _menhir_run_050 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState047 ->
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState045 ->
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState041 ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState039 ->
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState037 ->
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState034 ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState032 ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState181 ->
          _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState019 ->
          _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState076 ->
          _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState074 ->
          _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState027 ->
          _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState025 ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState023 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState021 ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_240 : type  ttv_stack. ((((ttv_stack, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_list_preceded_COMMA_ident__, _menhir_box_input) _menhir_cell1_option_set_operator_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState240
      | AUTOESCAPE | BLOCK | CALL | CASE | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | SET | SWITCH | TEXT _ | WITH ->
          let MenhirCell1_option_set_operator_ (_menhir_stack, _, _4) = _menhir_stack in
          let MenhirCell1_list_preceded_COMMA_ident__ (_menhir_stack, _, _3) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, _1_inlined1) = _menhir_stack in
          let MenhirCell1_SET (_menhir_stack, _menhir_s) = _menhir_stack in
          let _6 = _v in
          let _v = _menhir_action_106 _1_inlined1 _3 _4 _6 in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_023 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_VLINE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState023 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_005 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _1 = _v in
      let _v = _menhir_action_006 _1 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_006 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_007 () in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_007 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_NOT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState007 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_008 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MINUS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState008 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_009 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAREN (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState009
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState009
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState009
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState009
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState009
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState009
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState009
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState009
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState009
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState009
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState009
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState009
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState009
      | RPAREN ->
          let _v = _menhir_action_052 () in
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_010 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState010
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState010
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState010
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState010
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState010
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState010
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState010
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState010
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState010
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState010
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState010
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState010
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState010
      | RBRACKET ->
          let _v = _menhir_action_052 () in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_011 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState011 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING _v ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | RBRACE ->
          let _v = _menhir_action_056 () in
          _menhir_goto_loption_separated_nonempty_list_COMMA_separated_pair_objkey_COLON_expr___ _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _eRR ()
  
  and _menhir_run_012 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_STRING (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState013 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FLOAT _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | DEFAULT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_014 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _1 = _v in
      let _v = _menhir_action_002 _1 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_015 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _1 = _v in
      let _v = _menhir_action_001 _1 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_016 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _1 = _v in
      let _v = _menhir_action_003 _1 in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_017 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_005 () in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_018 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_DEFAULT (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState019
          | STRING _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState019
          | NULL ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState019
          | NOT ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState019
          | MINUS ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState019
          | LPAREN ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState019
          | LBRACKET ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState019
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState019
          | INT _v ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState019
          | IDENT _v ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState019
          | FLOAT _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState019
          | FALSE ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState019
          | DEFAULT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState019
          | RPAREN ->
              let _v = _menhir_action_048 () in
              _menhir_run_078 _menhir_stack _menhir_lexbuf _menhir_lexer _v
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_020 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState021 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FLOAT _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | DEFAULT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | AND | COMMA | DIV | DOT | EQ_EQ | FATARROW | GT | GT_EQ | IN | IS | LBRACKET | LPAREN | LT | LT_EQ | MINUS | MOD | NEQ | OR | PLUS | POWER | QUESTION | RPAREN | TIMES | VLINE ->
          let _1 = _v in
          let _v = _menhir_action_001 _1 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_078 : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_DEFAULT -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_DEFAULT (_menhir_stack, _menhir_s) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_032 xs in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_082 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState083 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FLOAT _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | DEFAULT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_separated_pair_objkey_COLON_expr___ : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_LBRACE -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_LBRACE (_menhir_stack, _menhir_s) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_013 xs in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_092 : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_LBRACKET -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RBRACKET ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) = _menhir_stack in
          let xs = _v in
          let _v = _menhir_action_012 xs in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_097 : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_LPAREN -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LPAREN (_menhir_stack, _menhir_s) = _menhir_stack in
          let xs = _v in
          let _v = _menhir_action_034 xs in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_032 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_TIMES (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState032 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_037 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_QUESTION (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState037 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_025 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_POWER (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState025 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_039 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PLUS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState039 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_047 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_OR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState047 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_049 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_NEQ (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState049 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_041 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MOD (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState041 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_051 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MINUS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState051 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_053 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LT_EQ (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState053 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_055 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState055 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_027 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAREN (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState027
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState027
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState027
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState027
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState027
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState027
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState027
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState027
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState027
      | IDENT _v ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState027
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState027
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState027
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState027
      | RPAREN ->
          let _v = _menhir_action_048 () in
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _eRR ()
  
  and _menhir_run_029 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_LPAREN -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_LPAREN (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_033 _1 xs in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_034 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState034 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_061 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              let _menhir_stack = MenhirCell1_IS (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
          | STRING _v_0 ->
              let _menhir_stack = MenhirCell1_IS (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState062
          | NULL ->
              let _menhir_stack = MenhirCell1_IS (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
          | NOT ->
              let _menhir_stack = MenhirCell1_IS (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
          | MINUS ->
              let _menhir_stack = MenhirCell1_IS (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
          | LPAREN ->
              let _menhir_stack = MenhirCell1_IS (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
          | LBRACKET ->
              let _menhir_stack = MenhirCell1_IS (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
          | LBRACE ->
              let _menhir_stack = MenhirCell1_IS (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
          | INT _v_1 ->
              let _menhir_stack = MenhirCell1_IS (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState062
          | IDENT _v_2 ->
              let _menhir_stack = MenhirCell1_IS (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState062
          | FLOAT _v_3 ->
              let _menhir_stack = MenhirCell1_IS (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState062
          | FALSE ->
              let _menhir_stack = MenhirCell1_IS (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
          | DEFAULT ->
              let _menhir_stack = MenhirCell1_IS (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState062
          | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DIV | DOT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | GT | GT_EQ | IF | IMPORT | IN | INCLUDE | IS | LT | LT_EQ | MACRO | MOD | NEQ | OPEN_EXPRESSION | OR | PLUS | POWER | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | TIMES | VLINE | WITH | WITHOUT ->
              let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
              let _1_inlined1 = _v in
              let _v = _menhir_action_031 _1 _1_inlined1 in
              _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_064 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IN (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState064 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_057 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_GT_EQ (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState057 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_059 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_GT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState059 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_068 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FATARROW (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState068 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_066 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_EQ_EQ (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState066 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_043 : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_expr -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_008 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_045 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_DIV (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState045 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_070 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_AND (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState070 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_stmt : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | WITH ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | TEXT _v_0 ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState188
      | SWITCH ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | SET ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | RAWINCLUDE ->
          _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | OPEN_EXPRESSION ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | MACRO ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | INCLUDE ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | IMPORT ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | IF ->
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | FUNCTION ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | FROM ->
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | FOR ->
          _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | FILTER ->
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | EXTENDS ->
          _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | CALL ->
          _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | BLOCK ->
          _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | AUTOESCAPE ->
          _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState188
      | CASE | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF ->
          let _v_1 = _menhir_action_044 () in
          _menhir_run_189 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_106 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _1 = _v in
      let _v = _menhir_action_123 _1 in
      _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_107 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SWITCH (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState107 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_113 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SET (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WITH ->
              _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | TEXT _v_0 ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState114
          | SWITCH ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | SET ->
              _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | RAWINCLUDE ->
              _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | OPEN_EXPRESSION ->
              _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | MACRO ->
              _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | LBRACKET ->
              let _menhir_stack = MenhirCell1_LBRACKET (_menhir_stack, MenhirState114) in
              let _menhir_s = MenhirState216 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TRUE ->
                  _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STRING _v ->
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | NULL ->
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | NOT ->
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | MINUS ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LPAREN ->
                  _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACKET ->
                  _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACE ->
                  _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | INT _v ->
                  _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | IDENT _v ->
                  _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | FLOAT _v ->
                  _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | FALSE ->
                  _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | DEFAULT ->
                  _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | INCLUDE ->
              _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | IMPORT ->
              _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | IF ->
              _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | FUNCTION ->
              _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | FROM ->
              _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | FOR ->
              _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | FILTER ->
              _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | EXTENDS ->
              _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | DOT ->
              let _menhir_stack = MenhirCell1_DOT (_menhir_stack, MenhirState114) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v_5 ->
                  let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v_5) in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | TIMES ->
                      _menhir_run_219 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState228
                  | PLUS ->
                      _menhir_run_220 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState228
                  | MOD ->
                      _menhir_run_221 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState228
                  | MINUS ->
                      _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState228
                  | DIV ->
                      _menhir_run_223 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState228
                  | EQ ->
                      let _v_6 = _menhir_action_079 () in
                      _menhir_run_229 _menhir_stack _menhir_lexbuf _menhir_lexer _v_6 MenhirState228 _tok
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | COMMA ->
              _menhir_run_232 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | CALL ->
              _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | BLOCK ->
              _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | AUTOESCAPE ->
              _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState114
          | DIV | EQ | MINUS | MOD | PLUS | TIMES ->
              let _v_7 = _menhir_action_040 () in
              _menhir_run_237 _menhir_stack _menhir_lexbuf _menhir_lexer _v_7 MenhirState114 _tok
          | ENDSET ->
              let _v_8 = _menhir_action_044 () in
              _menhir_run_235 _menhir_stack _menhir_lexbuf _menhir_lexer _v_8 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_115 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_RAWINCLUDE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState115 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_117 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_OPEN_EXPRESSION (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState117 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_120 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MACRO (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAREN ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v_0 ->
                  _menhir_run_123 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState122
              | RPAREN ->
                  let _v_1 = _menhir_action_050 () in
                  _menhir_run_130 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState122
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_123 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState124 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FLOAT _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | DEFAULT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | COMMA | RPAREN ->
          let _v = _menhir_action_077 () in
          _menhir_goto_option_preceded_EQ_expr__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option_preceded_EQ_expr__ : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell0_option_preceded_EQ_expr__ (_menhir_stack, _v) in
          let _menhir_s = MenhirState127 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_123 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | RPAREN ->
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _2 = _v in
          let _v = _menhir_action_093 _1 _2 in
          _menhir_goto_separated_nonempty_list_COMMA_argument_definition_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_argument_definition_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState176 ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState148 ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState122 ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState127 ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_129 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let x = _v in
      let _v = _menhir_action_051 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_argument_definition__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_argument_definition__ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState176 ->
          _menhir_run_177 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState148 ->
          _menhir_run_149 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState122 ->
          _menhir_run_130 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_177 : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_CALL -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let xs = _v in
      let _v = _menhir_action_059 xs in
      _menhir_goto_opt_args _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_goto_opt_args : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_CALL -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_opt_args (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAREN ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TRUE ->
                  _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState181
              | STRING _v_1 ->
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState181
              | NULL ->
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState181
              | NOT ->
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState181
              | MINUS ->
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState181
              | LPAREN ->
                  _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState181
              | LBRACKET ->
                  _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState181
              | LBRACE ->
                  _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState181
              | INT _v_2 ->
                  _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState181
              | IDENT _v_3 ->
                  _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState181
              | FLOAT _v_4 ->
                  _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState181
              | FALSE ->
                  _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState181
              | DEFAULT ->
                  _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState181
              | RPAREN ->
                  let _v_5 = _menhir_action_048 () in
                  _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 MenhirState181
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_182 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_CALL _menhir_cell0_opt_args _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_argument_application__ (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WITH ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | TEXT _v_0 ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState183
      | SWITCH ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | SET ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | RAWINCLUDE ->
          _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | OPEN_EXPRESSION ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | MACRO ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | INCLUDE ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | IMPORT ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | IF ->
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | FUNCTION ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | FROM ->
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | FOR ->
          _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | FILTER ->
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | EXTENDS ->
          _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | CALL ->
          _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | BLOCK ->
          _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | AUTOESCAPE ->
          _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState183
      | ENDCALL ->
          let _v_1 = _menhir_action_044 () in
          _menhir_run_194 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_132 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_INCLUDE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState132 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_139 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IMPORT (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING _v ->
          let _menhir_stack = MenhirCell0_STRING (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | AS ->
              _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState140
          | AUTOESCAPE | BLOCK | CALL | CASE | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | SET | SWITCH | TEXT _ | WITH ->
              let _v_0 = _menhir_action_071 () in
              _menhir_run_143 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_141 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let x = _v in
          let _v = _menhir_action_072 x in
          _menhir_goto_option_preceded_AS_IDENT__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option_preceded_AS_IDENT__ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState154 ->
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState140 ->
          _menhir_run_143 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_155 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_option_preceded_AS_IDENT__ (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState156 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_154 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | AUTOESCAPE | BLOCK | CALL | CASE | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | SET | SWITCH | TEXT _ | WITH ->
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _2 = _v in
          let _v = _menhir_action_087 _1 _2 in
          _menhir_goto_separated_nonempty_list_COMMA_alias_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_154 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | AS ->
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState154
      | AUTOESCAPE | BLOCK | CALL | CASE | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | SET | SWITCH | TEXT _ | WITH ->
          let _v_0 = _menhir_action_071 () in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState154 _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_alias_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState153 ->
          _menhir_run_158 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState156 ->
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_158 : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_FROM _menhir_cell0_STRING -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let x = _v in
      let _v = _menhir_action_047 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_alias__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_alias__ : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_FROM _menhir_cell0_STRING -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_STRING (_menhir_stack, _2) = _menhir_stack in
      let MenhirCell1_FROM (_menhir_stack, _menhir_s) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_114 _2 xs in
      _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_157 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_cell1_option_preceded_AS_IDENT__ -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_option_preceded_AS_IDENT__ (_menhir_stack, _, _2_inlined1) = _menhir_stack in
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_088 _1 _2_inlined1 xs in
      _menhir_goto_separated_nonempty_list_COMMA_alias_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_143 : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_IMPORT _menhir_cell0_STRING -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_STRING (_menhir_stack, _2) = _menhir_stack in
      let MenhirCell1_IMPORT (_menhir_stack, _menhir_s) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_113 _2 _3 in
      _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_144 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState144 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_146 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FUNCTION (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAREN ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v_0 ->
                  _menhir_run_123 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState148
              | RPAREN ->
                  let _v_1 = _menhir_action_050 () in
                  _menhir_run_149 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState148
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_149 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_FUNCTION _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_argument_definition__ (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WITH ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | TEXT _v_0 ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState150
      | SWITCH ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | SET ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | RAWINCLUDE ->
          _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | OPEN_EXPRESSION ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | MACRO ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | INCLUDE ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | IMPORT ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | IF ->
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | FUNCTION ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | FROM ->
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | FOR ->
          _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | FILTER ->
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | EXTENDS ->
          _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | CALL ->
          _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | BLOCK ->
          _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | AUTOESCAPE ->
          _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState150
      | ENDFUNCTION ->
          let _v_1 = _menhir_action_044 () in
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_151 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FROM (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING _v ->
          let _menhir_stack = MenhirCell0_STRING (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IMPORT ->
              let _menhir_s = MenhirState153 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v ->
                  _menhir_run_154 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | AUTOESCAPE | BLOCK | CALL | CASE | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | SET | SWITCH | TEXT _ | WITH ->
                  let _v = _menhir_action_046 () in
                  _menhir_goto_loption_separated_nonempty_list_COMMA_alias__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_160 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FOR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let x = () in
          let _v = _menhir_action_063 x in
          _menhir_goto_option_LPAREN_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | IDENT _ ->
          let _v = _menhir_action_062 () in
          _menhir_goto_option_LPAREN_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option_LPAREN_ : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_FOR -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_option_LPAREN_ (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | IDENT _v_0 ->
          _menhir_run_163 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState162
      | _ ->
          _eRR ()
  
  and _menhir_run_163 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState164 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_163 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | IN | RPAREN ->
          let x = _v in
          let _v = _menhir_action_085 x in
          _menhir_goto_separated_nonempty_list_COMMA_IDENT_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_IDENT_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState162 ->
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState164 ->
          _menhir_run_165 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_166 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_FOR _menhir_cell0_option_LPAREN_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_separated_nonempty_list_COMMA_IDENT_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let x = () in
          let _v = _menhir_action_065 x in
          _menhir_goto_option_RPAREN_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | IN ->
          let _v = _menhir_action_064 () in
          _menhir_goto_option_RPAREN_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_goto_option_RPAREN_ : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_FOR _menhir_cell0_option_LPAREN_, _menhir_box_input) _menhir_cell1_separated_nonempty_list_COMMA_IDENT_ -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_option_RPAREN_ (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | IN ->
          let _menhir_s = MenhirState169 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FLOAT _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | DEFAULT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_165 : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_086 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_IDENT_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_171 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FILTER (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WITH ->
              _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | TEXT _v_0 ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState172
          | SWITCH ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | SET ->
              _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | RAWINCLUDE ->
              _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | OPEN_EXPRESSION ->
              _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | MACRO ->
              _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | INCLUDE ->
              _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | IMPORT ->
              _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | IF ->
              _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | FUNCTION ->
              _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | FROM ->
              _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | FOR ->
              _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | FILTER ->
              _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | EXTENDS ->
              _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | CALL ->
              _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | BLOCK ->
              _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | AUTOESCAPE ->
              _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState172
          | ENDFILTER ->
              let _v_1 = _menhir_action_044 () in
              _menhir_run_196 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_173 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _2 = _v in
          let _v = _menhir_action_108 _2 in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_175 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_CALL (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_123 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState176
          | RPAREN ->
              let _v = _menhir_action_050 () in
              _menhir_run_177 _menhir_stack _menhir_lexbuf _menhir_lexer _v
          | _ ->
              _eRR ())
      | IDENT _ ->
          let _v = _menhir_action_058 () in
          _menhir_goto_opt_args _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_184 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_BLOCK (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WITH ->
              _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | TEXT _v_0 ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState185
          | SWITCH ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | SET ->
              _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | RAWINCLUDE ->
              _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | OPEN_EXPRESSION ->
              _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | MACRO ->
              _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | INCLUDE ->
              _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | IMPORT ->
              _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | IF ->
              _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | FUNCTION ->
              _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | FROM ->
              _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | FOR ->
              _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | FILTER ->
              _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | EXTENDS ->
              _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | CALL ->
              _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | BLOCK ->
              _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | AUTOESCAPE ->
              _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState185
          | ENDBLOCK ->
              let _v_1 = _menhir_action_044 () in
              _menhir_run_192 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_186 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_AUTOESCAPE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState186 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_192 : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_BLOCK _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | ENDBLOCK ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_IDENT (_menhir_stack, _2) = _menhir_stack in
          let MenhirCell1_BLOCK (_menhir_stack, _menhir_s) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_109 _2 _3 in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_196 : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_FILTER _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | ENDFILTER ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_IDENT (_menhir_stack, _2) = _menhir_stack in
          let MenhirCell1_FILTER (_menhir_stack, _menhir_s) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_110 _2 _3 in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_200 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_FUNCTION _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_loption_separated_nonempty_list_COMMA_argument_definition__ -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | ENDFUNCTION ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_loption_separated_nonempty_list_COMMA_argument_definition__ (_menhir_stack, _, xs) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, _2) = _menhir_stack in
          let MenhirCell1_FUNCTION (_menhir_stack, _menhir_s) = _menhir_stack in
          let _6 = _v in
          let _v = _menhir_action_116 _2 _6 xs in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_194 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_CALL _menhir_cell0_opt_args _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_loption_separated_nonempty_list_COMMA_argument_application__ -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | ENDCALL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_loption_separated_nonempty_list_COMMA_argument_application__ (_menhir_stack, _, xs) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, _3) = _menhir_stack in
          let MenhirCell0_opt_args (_menhir_stack, _2) = _menhir_stack in
          let MenhirCell1_CALL (_menhir_stack, _menhir_s) = _menhir_stack in
          let _7 = _v in
          let _v = _menhir_action_117 _2 _3 _7 xs in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_130 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_MACRO _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_argument_definition__ (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WITH ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | TEXT _v_0 ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState131
      | SWITCH ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | SET ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | RAWINCLUDE ->
          _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | OPEN_EXPRESSION ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | MACRO ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | INCLUDE ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | IMPORT ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | IF ->
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | FUNCTION ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | FROM ->
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | FOR ->
          _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | FILTER ->
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | EXTENDS ->
          _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | CALL ->
          _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | BLOCK ->
          _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | AUTOESCAPE ->
          _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | ENDMACRO ->
          let _v_1 = _menhir_action_044 () in
          _menhir_run_212 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState131 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_212 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_MACRO _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_loption_separated_nonempty_list_COMMA_argument_definition__ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_list_stmt_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ENDMACRO ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let x = _v_0 in
              let _v = _menhir_action_061 x in
              _menhir_goto_option_IDENT_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | AUTOESCAPE | BLOCK | CALL | CASE | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | SET | SWITCH | TEXT _ | WITH ->
              let _v = _menhir_action_060 () in
              _menhir_goto_option_IDENT_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_option_IDENT_ : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_MACRO _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_loption_separated_nonempty_list_COMMA_argument_definition__, _menhir_box_input) _menhir_cell1_list_stmt_ -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_list_stmt_ (_menhir_stack, _, _6) = _menhir_stack in
      let MenhirCell1_loption_separated_nonempty_list_COMMA_argument_definition__ (_menhir_stack, _, xs) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, _2) = _menhir_stack in
      let MenhirCell1_MACRO (_menhir_stack, _menhir_s) = _menhir_stack in
      let _8 = _v in
      let _v = _menhir_action_115 _2 _6 _8 xs in
      _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_128 : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_IDENT _menhir_cell0_option_preceded_EQ_expr__ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell0_option_preceded_EQ_expr__ (_menhir_stack, _2_inlined1) = _menhir_stack in
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_094 _1 _2_inlined1 xs in
      _menhir_goto_separated_nonempty_list_COMMA_argument_definition_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_219 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_083 () in
      _menhir_goto_option_set_operator_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_option_set_operator_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState237 ->
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState228 ->
          _menhir_run_229 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState218 ->
          _menhir_run_224 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_238 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_list_preceded_COMMA_ident__ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option_set_operator_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState239 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FLOAT _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | DEFAULT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_229 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_DOT _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option_set_operator_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState230 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FLOAT _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | DEFAULT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_224 : type  ttv_stack. (((((ttv_stack, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_LBRACKET, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_RBRACKET as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option_set_operator_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState225 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FLOAT _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | DEFAULT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_220 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_080 () in
      _menhir_goto_option_set_operator_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_221 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_084 () in
      _menhir_goto_option_set_operator_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_222 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_081 () in
      _menhir_goto_option_set_operator_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_223 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_082 () in
      _menhir_goto_option_set_operator_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_232 : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_COMMA (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COMMA ->
              _menhir_run_232 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
          | DIV | EQ | MINUS | MOD | PLUS | TIMES ->
              let _v_0 = _menhir_action_040 () in
              _menhir_run_234 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_234 : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_COMMA _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_IDENT (_menhir_stack, _1_inlined1) = _menhir_stack in
      let MenhirCell1_COMMA (_menhir_stack, _menhir_s) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_041 _1_inlined1 xs in
      _menhir_goto_list_preceded_COMMA_ident__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_preceded_COMMA_ident__ : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState114 ->
          _menhir_run_237 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState233 ->
          _menhir_run_234 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_237 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_list_preceded_COMMA_ident__ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TIMES ->
          _menhir_run_219 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | PLUS ->
          _menhir_run_220 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | MOD ->
          _menhir_run_221 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | MINUS ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | DIV ->
          _menhir_run_223 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | EQ ->
          let _v_0 = _menhir_action_079 () in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState237 _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_235 : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | ENDSET ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_IDENT (_menhir_stack, _2) = _menhir_stack in
          let MenhirCell1_SET (_menhir_stack, _menhir_s) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_107 _2 _3 in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_189 : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_stmt -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_stmt (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_045 x xs in
      _menhir_goto_list_stmt_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_stmt_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState000 ->
          _menhir_run_250 _menhir_stack _v _tok
      | MenhirState105 ->
          _menhir_run_248 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState244 ->
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState112 ->
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState114 ->
          _menhir_run_235 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState131 ->
          _menhir_run_212 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState208 ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState204 ->
          _menhir_run_205 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState145 ->
          _menhir_run_202 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState150 ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState170 ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState172 ->
          _menhir_run_196 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState183 ->
          _menhir_run_194 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState185 ->
          _menhir_run_192 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState187 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState188 ->
          _menhir_run_189 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_248 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_WITH, _menhir_box_input) _menhir_cell1_loption_separated_nonempty_list_COMMA_separated_pair_IDENT_EQ_expr___ -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | ENDWITH ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_loption_separated_nonempty_list_COMMA_separated_pair_IDENT_EQ_expr___ (_menhir_stack, _, xs) = _menhir_stack in
          let MenhirCell1_WITH (_menhir_stack, _menhir_s) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_121 _3 xs in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_245 : type  ttv_stack. ((((ttv_stack, _menhir_box_input) _menhir_cell1_SWITCH, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_option_TEXT_, _menhir_box_input) _menhir_cell1_list_preceded_CASE_pair_expr_list_stmt____ -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let x = _v in
      let _v = _menhir_action_074 x in
      _menhir_goto_option_preceded_DEFAULT_list_stmt___ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_goto_option_preceded_DEFAULT_list_stmt___ : type  ttv_stack. ((((ttv_stack, _menhir_box_input) _menhir_cell1_SWITCH, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_option_TEXT_, _menhir_box_input) _menhir_cell1_list_preceded_CASE_pair_expr_list_stmt____ -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | ENDSWITCH ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_list_preceded_CASE_pair_expr_list_stmt____ (_menhir_stack, _, cases) = _menhir_stack in
          let MenhirCell1_option_TEXT_ (_menhir_stack, _, ws) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _, e) = _menhir_stack in
          let MenhirCell1_SWITCH (_menhir_stack, _menhir_s) = _menhir_stack in
          let default = _v in
          let _v = _menhir_action_119 cases default e ws in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_241 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_CASE, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_list_stmt_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | CASE ->
          _menhir_run_111 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState241
      | DEFAULT | ENDSWITCH ->
          let _v_0 = _menhir_action_038 () in
          _menhir_run_242 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_111 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_CASE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState111 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_242 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_CASE, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_ -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_list_stmt_ (_menhir_stack, _, y) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, x) = _menhir_stack in
      let MenhirCell1_CASE (_menhir_stack, _menhir_s) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_039 x xs y in
      _menhir_goto_list_preceded_CASE_pair_expr_list_stmt____ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_preceded_CASE_pair_expr_list_stmt____ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState110 ->
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState241 ->
          _menhir_run_242 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_243 : type  ttv_stack. ((((ttv_stack, _menhir_box_input) _menhir_cell1_SWITCH, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_option_TEXT_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_list_preceded_CASE_pair_expr_list_stmt____ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | DEFAULT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WITH ->
              _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | TEXT _v_0 ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState244
          | SWITCH ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | SET ->
              _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | RAWINCLUDE ->
              _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | OPEN_EXPRESSION ->
              _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | MACRO ->
              _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | INCLUDE ->
              _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | IMPORT ->
              _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | IF ->
              _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | FUNCTION ->
              _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | FROM ->
              _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | FOR ->
              _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | FILTER ->
              _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | EXTENDS ->
              _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | CALL ->
              _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | BLOCK ->
              _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | AUTOESCAPE ->
              _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
          | ENDSWITCH ->
              let _v_1 = _menhir_action_044 () in
              _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 _tok
          | _ ->
              _eRR ())
      | ENDSWITCH ->
          let _v = _menhir_action_073 () in
          _menhir_goto_option_preceded_DEFAULT_list_stmt___ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_209 : type  ttv_stack. ((((ttv_stack, _menhir_box_input) _menhir_cell1_IF, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_, _menhir_box_input) _menhir_cell1_list_preceded_ELSEIF_pair_expr_list_stmt____ -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let x = _v in
      let _v = _menhir_action_076 x in
      _menhir_goto_option_preceded_ELSE_list_stmt___ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_goto_option_preceded_ELSE_list_stmt___ : type  ttv_stack. ((((ttv_stack, _menhir_box_input) _menhir_cell1_IF, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_, _menhir_box_input) _menhir_cell1_list_preceded_ELSEIF_pair_expr_list_stmt____ -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | ENDIF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_list_preceded_ELSEIF_pair_expr_list_stmt____ (_menhir_stack, _, ei) = _menhir_stack in
          let MenhirCell1_list_stmt_ (_menhir_stack, _, y) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _, x) = _menhir_stack in
          let MenhirCell1_IF (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_118 e ei x y in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_205 : type  ttv_stack. (((((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_, _menhir_box_input) _menhir_cell1_ELSEIF, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_list_stmt_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ELSEIF ->
          _menhir_run_203 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState205
      | ELSE | ENDIF ->
          let _v_0 = _menhir_action_042 () in
          _menhir_run_206 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_203 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_ as 'stack) -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_ELSEIF (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState203 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | NULL ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IDENT _v ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FLOAT _v ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | DEFAULT ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_206 : type  ttv_stack. (((((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_, _menhir_box_input) _menhir_cell1_ELSEIF, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_ -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_list_stmt_ (_menhir_stack, _, y) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, x) = _menhir_stack in
      let MenhirCell1_ELSEIF (_menhir_stack, _menhir_s) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_043 x xs y in
      _menhir_goto_list_preceded_ELSEIF_pair_expr_list_stmt____ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_preceded_ELSEIF_pair_expr_list_stmt____ : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState202 ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState205 ->
          _menhir_run_206 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_207 : type  ttv_stack. ((((ttv_stack, _menhir_box_input) _menhir_cell1_IF, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_list_preceded_ELSEIF_pair_expr_list_stmt____ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ELSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WITH ->
              _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | TEXT _v_0 ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState208
          | SWITCH ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | SET ->
              _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | RAWINCLUDE ->
              _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | OPEN_EXPRESSION ->
              _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | MACRO ->
              _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | INCLUDE ->
              _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | IMPORT ->
              _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | IF ->
              _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | FUNCTION ->
              _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | FROM ->
              _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | FOR ->
              _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | FILTER ->
              _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | EXTENDS ->
              _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | CALL ->
              _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | BLOCK ->
              _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | AUTOESCAPE ->
              _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
          | ENDIF ->
              let _v_1 = _menhir_action_044 () in
              _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 _tok
          | _ ->
              _eRR ())
      | ENDIF ->
          let _v = _menhir_action_075 () in
          _menhir_goto_option_preceded_ELSE_list_stmt___ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_202 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_IF, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_list_stmt_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ELSEIF ->
          _menhir_run_203 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState202
      | ELSE | ENDIF ->
          let _v_0 = _menhir_action_042 () in
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState202 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_198 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_FOR _menhir_cell0_option_LPAREN_, _menhir_box_input) _menhir_cell1_separated_nonempty_list_COMMA_IDENT_ _menhir_cell0_option_RPAREN_, _menhir_box_input) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | ENDFOR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _, _6) = _menhir_stack in
          let MenhirCell0_option_RPAREN_ (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_separated_nonempty_list_COMMA_IDENT_ (_menhir_stack, _, _3) = _menhir_stack in
          let MenhirCell0_option_LPAREN_ (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_FOR (_menhir_stack, _menhir_s) = _menhir_stack in
          let _7 = _v in
          let _v = _menhir_action_120 _3 _6 _7 in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_190 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_AUTOESCAPE, _menhir_box_input) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | ENDAUTOESCAPE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _, _2) = _menhir_stack in
          let MenhirCell1_AUTOESCAPE (_menhir_stack, _menhir_s) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_122 _2 _3 in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_231 : type  ttv_stack. ((((ttv_stack, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_DOT _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_option_set_operator_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState231
      | AUTOESCAPE | BLOCK | CALL | CASE | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | SET | SWITCH | TEXT _ | WITH ->
          let MenhirCell1_option_set_operator_ (_menhir_stack, _, _5) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, _4) = _menhir_stack in
          let MenhirCell1_DOT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, _1_inlined1) = _menhir_stack in
          let MenhirCell1_SET (_menhir_stack, _menhir_s) = _menhir_stack in
          let _7 = _v in
          let _v = _menhir_action_104 _1_inlined1 _4 _5 _7 in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_226 : type  ttv_stack. ((((((ttv_stack, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_LBRACKET, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_RBRACKET, _menhir_box_input) _menhir_cell1_option_set_operator_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | AUTOESCAPE | BLOCK | CALL | CASE | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | SET | SWITCH | TEXT _ | WITH ->
          let MenhirCell1_option_set_operator_ (_menhir_stack, _, _6) = _menhir_stack in
          let MenhirCell1_RBRACKET (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _, _4) = _menhir_stack in
          let MenhirCell1_LBRACKET (_menhir_stack, _) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, _1_inlined1) = _menhir_stack in
          let MenhirCell1_SET (_menhir_stack, _menhir_s) = _menhir_stack in
          let _8 = _v in
          let _v = _menhir_action_105 _1_inlined1 _4 _6 _8 in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_217 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_SET _menhir_cell0_IDENT, _menhir_box_input) _menhir_cell1_LBRACKET as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | TIMES ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | RBRACKET ->
          let _menhir_stack = MenhirCell1_RBRACKET (_menhir_stack, MenhirState217) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TIMES ->
              _menhir_run_219 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState218
          | PLUS ->
              _menhir_run_220 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState218
          | MOD ->
              _menhir_run_221 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState218
          | MINUS ->
              _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState218
          | DIV ->
              _menhir_run_223 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState218
          | EQ ->
              let _v_0 = _menhir_action_079 () in
              _menhir_run_224 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState218 _tok
          | _ ->
              _eRR ())
      | QUESTION ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | POWER ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | PLUS ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | OR ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | NEQ ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | MOD ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | MINUS ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | LT_EQ ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | LT ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | LPAREN ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | LBRACKET ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | IS ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | IN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | GT_EQ ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | GT ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | FATARROW ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | EQ_EQ ->
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | DOT ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | AND ->
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | _ ->
          _eRR ()
  
  and _menhir_run_204 : type  ttv_stack. ((((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_list_stmt_, _menhir_box_input) _menhir_cell1_ELSEIF as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | WITH ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | VLINE ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | TIMES ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | TEXT _v_0 ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState204
      | SWITCH ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | SET ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | RAWINCLUDE ->
          _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | QUESTION ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | POWER ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | PLUS ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | OR ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | OPEN_EXPRESSION ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | NEQ ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | MOD ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | MINUS ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | MACRO ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | LT_EQ ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | LT ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | LPAREN ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | LBRACKET ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | IS ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | INCLUDE ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | IN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | IMPORT ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | IF ->
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | GT_EQ ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | GT ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | FUNCTION ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | FROM ->
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | FOR ->
          _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | FILTER ->
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | FATARROW ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | EXTENDS ->
          _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | EQ_EQ ->
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | DOT ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | CALL ->
          _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | BLOCK ->
          _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | AUTOESCAPE ->
          _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | AND ->
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | ELSE | ELSEIF | ENDIF ->
          let _v_1 = _menhir_action_044 () in
          _menhir_run_205 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState204 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_187 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_AUTOESCAPE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | WITH ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | VLINE ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | TIMES ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | TEXT _v_0 ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState187
      | SWITCH ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | SET ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | RAWINCLUDE ->
          _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | QUESTION ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | POWER ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | PLUS ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | OR ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | OPEN_EXPRESSION ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | NEQ ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | MOD ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | MINUS ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | MACRO ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | LT_EQ ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | LT ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | LPAREN ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | LBRACKET ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | IS ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | INCLUDE ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | IN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | IMPORT ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | IF ->
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | GT_EQ ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | GT ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | FUNCTION ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | FROM ->
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | FOR ->
          _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | FILTER ->
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | FATARROW ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | EXTENDS ->
          _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | EQ_EQ ->
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | DOT ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | CALL ->
          _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | BLOCK ->
          _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | AUTOESCAPE ->
          _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | AND ->
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState187
      | ENDAUTOESCAPE ->
          let _v_1 = _menhir_action_044 () in
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_170 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_FOR _menhir_cell0_option_LPAREN_, _menhir_box_input) _menhir_cell1_separated_nonempty_list_COMMA_IDENT_ _menhir_cell0_option_RPAREN_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | WITH ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | VLINE ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | TIMES ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | TEXT _v_0 ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState170
      | SWITCH ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | SET ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | RAWINCLUDE ->
          _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | QUESTION ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | POWER ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | PLUS ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | OR ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | OPEN_EXPRESSION ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | NEQ ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | MOD ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | MINUS ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | MACRO ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | LT_EQ ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | LT ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | LPAREN ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | LBRACKET ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | IS ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | INCLUDE ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | IN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | IMPORT ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | IF ->
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | GT_EQ ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | GT ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | FUNCTION ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | FROM ->
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | FOR ->
          _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | FILTER ->
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | FATARROW ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | EXTENDS ->
          _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | EQ_EQ ->
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | DOT ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | CALL ->
          _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | BLOCK ->
          _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | AUTOESCAPE ->
          _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | AND ->
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState170
      | ENDFOR ->
          let _v_1 = _menhir_action_044 () in
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_145 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | WITH ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | VLINE ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | TIMES ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | TEXT _v_0 ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState145
      | SWITCH ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | SET ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | RAWINCLUDE ->
          _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | QUESTION ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | POWER ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | PLUS ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | OR ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | OPEN_EXPRESSION ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | NEQ ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | MOD ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | MINUS ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | MACRO ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | LT_EQ ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | LT ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | LPAREN ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | LBRACKET ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | IS ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | INCLUDE ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | IN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | IMPORT ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | IF ->
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | GT_EQ ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | GT ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | FUNCTION ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | FROM ->
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | FOR ->
          _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | FILTER ->
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | FATARROW ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | EXTENDS ->
          _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | EQ_EQ ->
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | DOT ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | CALL ->
          _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | BLOCK ->
          _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | AUTOESCAPE ->
          _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | AND ->
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | ELSE | ELSEIF | ENDIF ->
          let _v_1 = _menhir_action_044 () in
          _menhir_run_202 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState145 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_133 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_INCLUDE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | WITHOUT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | CONTEXT ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_070 () in
              _menhir_goto_option_context_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | WITH ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | CONTEXT ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_069 () in
              _menhir_goto_option_context_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | VLINE ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | TIMES ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | QUESTION ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | POWER ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | PLUS ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | OR ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | NEQ ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | MOD ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | MINUS ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | LT_EQ ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | LT ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | LPAREN ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | LBRACKET ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | IS ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | IN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | GT_EQ ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | GT ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | FATARROW ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | EQ_EQ ->
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | DOT ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | AND ->
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
      | AUTOESCAPE | BLOCK | CALL | CASE | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | SET | SWITCH | TEXT _ ->
          let _v = _menhir_action_068 () in
          _menhir_goto_option_context_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option_context_ : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_INCLUDE, _menhir_box_input) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _, _2) = _menhir_stack in
      let MenhirCell1_INCLUDE (_menhir_stack, _menhir_s) = _menhir_stack in
      let _3 = _v in
      let _v = _menhir_action_111 _2 _3 in
      _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_125 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
      | COMMA | RPAREN ->
          let x = _v in
          let _v = _menhir_action_078 x in
          _menhir_goto_option_preceded_EQ_expr__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_118 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_OPEN_EXPRESSION as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | CLOSE_EXPRESSION ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_OPEN_EXPRESSION (_menhir_stack, _menhir_s) = _menhir_stack in
          let _2 = _v in
          let _v = _menhir_action_103 _2 in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState118
      | _ ->
          _eRR ()
  
  and _menhir_run_116 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_RAWINCLUDE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState116
      | AUTOESCAPE | BLOCK | CALL | CASE | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | SET | SWITCH | TEXT _ | WITH ->
          let MenhirCell1_RAWINCLUDE (_menhir_stack, _menhir_s) = _menhir_stack in
          let _2 = _v in
          let _v = _menhir_action_112 _2 in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_112 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_CASE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | WITH ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | VLINE ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | TIMES ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | TEXT _v_0 ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState112
      | SWITCH ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | SET ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | RAWINCLUDE ->
          _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | QUESTION ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | POWER ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | PLUS ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | OR ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | OPEN_EXPRESSION ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | NEQ ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | MOD ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | MINUS ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | MACRO ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | LT_EQ ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | LT ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | LPAREN ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | LBRACKET ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | IS ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | INCLUDE ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | IN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | IMPORT ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | IF ->
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | GT_EQ ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | GT ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | FUNCTION ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | FROM ->
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | FOR ->
          _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | FILTER ->
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | FATARROW ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | EXTENDS ->
          _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | EQ_EQ ->
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | DOT ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | CALL ->
          _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | BLOCK ->
          _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | AUTOESCAPE ->
          _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | AND ->
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState112
      | CASE | DEFAULT | ENDSWITCH ->
          let _v_1 = _menhir_action_044 () in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState112 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_108 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_SWITCH as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | TIMES ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | TEXT _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (_menhir_s, x) = (MenhirState108, _v_0) in
          let _v = _menhir_action_067 x in
          _menhir_goto_option_TEXT_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | QUESTION ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | POWER ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | PLUS ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | OR ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | NEQ ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | MOD ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | MINUS ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | LT_EQ ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | LT ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | LPAREN ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | LBRACKET ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | IS ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | IN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | GT_EQ ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | GT ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | FATARROW ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | EQ_EQ ->
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | DOT ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | AND ->
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState108
      | CASE | DEFAULT | ENDSWITCH ->
          let _menhir_s = MenhirState108 in
          let _v = _menhir_action_066 () in
          _menhir_goto_option_TEXT_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option_TEXT_ : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_SWITCH, _menhir_box_input) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option_TEXT_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | CASE ->
          _menhir_run_111 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState110
      | DEFAULT | ENDSWITCH ->
          let _v_0 = _menhir_action_038 () in
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState110 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_101 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_COMMA (_menhir_stack, MenhirState101) in
          let _menhir_s = MenhirState102 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | AUTOESCAPE | BLOCK | CALL | ENDWITH | EXTENDS | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | SET | SWITCH | TEXT _ | WITH ->
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, x) = _menhir_stack in
          let y = _v in
          let _v = _menhir_action_097 x y in
          _menhir_goto_separated_nonempty_list_COMMA_separated_pair_IDENT_EQ_expr__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_separated_pair_IDENT_EQ_expr__ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState001 ->
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState102 ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_104 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_WITH as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let x = _v in
      let _v = _menhir_action_055 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_separated_pair_IDENT_EQ_expr___ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_separated_pair_IDENT_EQ_expr___ : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_WITH as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_separated_pair_IDENT_EQ_expr___ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | WITH ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | TEXT _v_0 ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState105
      | SWITCH ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | SET ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | RAWINCLUDE ->
          _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | OPEN_EXPRESSION ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | MACRO ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | INCLUDE ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | IMPORT ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | IF ->
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | FUNCTION ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | FROM ->
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | FOR ->
          _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | FILTER ->
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | EXTENDS ->
          _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | CALL ->
          _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | BLOCK ->
          _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | AUTOESCAPE ->
          _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | ENDWITH ->
          let _v_1 = _menhir_action_044 () in
          _menhir_run_248 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_103 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COMMA -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_COMMA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, y) = _menhir_stack in
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_098 x xs y in
      _menhir_goto_separated_nonempty_list_COMMA_separated_pair_IDENT_EQ_expr__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_100 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_NOT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState100
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | DIV | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | GT | GT_EQ | IF | IMPORT | IN | INCLUDE | IS | LT | LT_EQ | MACRO | MINUS | MOD | NEQ | OPEN_EXPRESSION | OR | PLUS | POWER | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | TIMES | VLINE | WITH | WITHOUT ->
          let MenhirCell1_NOT (_menhir_stack, _menhir_s) = _menhir_stack in
          let _2 = _v in
          let _v = _menhir_action_010 _2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_099 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_MINUS as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState099
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState099
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | DIV | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | GT | GT_EQ | IF | IMPORT | IN | INCLUDE | IS | LT | LT_EQ | MACRO | MINUS | MOD | NEQ | OPEN_EXPRESSION | OR | PLUS | POWER | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | TIMES | VLINE | WITH | WITHOUT ->
          let MenhirCell1_MINUS (_menhir_stack, _menhir_s) = _menhir_stack in
          let _2 = _v in
          let _v = _menhir_action_011 _2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_094 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_COMMA (_menhir_stack, MenhirState094) in
          let _menhir_s = MenhirState095 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FLOAT _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | DEFAULT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState094
      | RBRACKET | RPAREN ->
          let x = _v in
          let _v = _menhir_action_095 x in
          _menhir_goto_separated_nonempty_list_COMMA_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_expr_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState095 ->
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState009 ->
          _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState010 ->
          _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_096 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COMMA -> _ -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_COMMA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_096 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_091 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let x = _v in
      let _v = _menhir_action_053 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_expr__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_expr__ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState009 ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState010 ->
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_084 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_COMMA (_menhir_stack, MenhirState084) in
          let _menhir_s = MenhirState085 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState084
      | RBRACE ->
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let y = _v in
          let _v = _menhir_action_099 _1 y in
          _menhir_goto_separated_nonempty_list_COMMA_separated_pair_objkey_COLON_expr__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_separated_pair_objkey_COLON_expr__ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState011 ->
          _menhir_run_088 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState081 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState085 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_088 : type  ttv_stack. (ttv_stack, _menhir_box_input) _menhir_cell1_LBRACE -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_057 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_separated_pair_objkey_COLON_expr___ _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  and _menhir_run_087 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_STRING, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COMMA -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_COMMA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, y) = _menhir_stack in
      let MenhirCell1_STRING (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_102 _1 xs y in
      _menhir_goto_separated_nonempty_list_COMMA_separated_pair_objkey_COLON_expr__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_086 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COMMA -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_COMMA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, y) = _menhir_stack in
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_101 _1 xs y in
      _menhir_goto_separated_nonempty_list_COMMA_separated_pair_objkey_COLON_expr__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_080 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_STRING as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_COMMA (_menhir_stack, MenhirState080) in
          let _menhir_s = MenhirState081 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING _v ->
              _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState080
      | RBRACE ->
          let MenhirCell1_STRING (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let y = _v in
          let _v = _menhir_action_100 _1 y in
          _menhir_goto_separated_nonempty_list_COMMA_separated_pair_objkey_COLON_expr__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_073 : type  ttv_stack. (((((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_QUESTION, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COLON as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | WITH | WITHOUT ->
          let MenhirCell1_COLON (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _, _3) = _menhir_stack in
          let MenhirCell1_QUESTION (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _5 = _v in
          let _v = _menhir_action_036 _1 _3 _5 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_071 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_AND as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState071
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | OR | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | WITH | WITHOUT ->
          let MenhirCell1_AND (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_020 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_069 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_FATARROW as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState069
      | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | WITH | WITHOUT ->
          let MenhirCell1_FATARROW (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_035 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_067 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_EQ_EQ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState067
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState067
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState067
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState067
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState067
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState067
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState067
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState067
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState067
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState067
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState067
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState067
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState067
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | IN | INCLUDE | IS | MACRO | NEQ | OPEN_EXPRESSION | OR | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | WITH | WITHOUT ->
          let MenhirCell1_EQ_EQ (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_022 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_065 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_IN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState065
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | OR | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | WITH | WITHOUT ->
          let MenhirCell1_IN (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_028 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_063 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_IS _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState063
      | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | WITH | WITHOUT ->
          let MenhirCell0_IDENT (_menhir_stack, _1_inlined1) = _menhir_stack in
          let MenhirCell1_IS (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _4 = _v in
          let _v = _menhir_action_030 _1 _1_inlined1 _4 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_060 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_GT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState060
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState060
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState060
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState060
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState060
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState060
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState060
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState060
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState060
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | GT | GT_EQ | IF | IMPORT | IN | INCLUDE | IS | LT | LT_EQ | MACRO | NEQ | OPEN_EXPRESSION | OR | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | WITH | WITHOUT ->
          let MenhirCell1_GT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_025 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_058 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_GT_EQ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | GT | GT_EQ | IF | IMPORT | IN | INCLUDE | IS | LT | LT_EQ | MACRO | NEQ | OPEN_EXPRESSION | OR | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | WITH | WITHOUT ->
          let MenhirCell1_GT_EQ (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_027 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_056 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_LT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState056
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState056
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState056
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState056
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState056
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState056
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState056
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState056
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState056
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | GT | GT_EQ | IF | IMPORT | IN | INCLUDE | IS | LT | LT_EQ | MACRO | NEQ | OPEN_EXPRESSION | OR | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | WITH | WITHOUT ->
          let MenhirCell1_LT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_024 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_054 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_LT_EQ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState054
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState054
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState054
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState054
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState054
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState054
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState054
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState054
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState054
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | GT | GT_EQ | IF | IMPORT | IN | INCLUDE | IS | LT | LT_EQ | MACRO | NEQ | OPEN_EXPRESSION | OR | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | WITH | WITHOUT ->
          let MenhirCell1_LT_EQ (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_026 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_052 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_MINUS as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState052
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState052
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState052
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState052
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState052
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState052
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState052
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | GT | GT_EQ | IF | IMPORT | IN | INCLUDE | IS | LT | LT_EQ | MACRO | MINUS | NEQ | OPEN_EXPRESSION | OR | PLUS | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | WITH | WITHOUT ->
          let MenhirCell1_MINUS (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_015 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_050 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_NEQ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState050
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState050
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState050
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState050
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState050
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState050
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState050
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState050
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState050
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState050
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState050
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState050
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState050
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | IN | INCLUDE | IS | MACRO | NEQ | OPEN_EXPRESSION | OR | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | WITH | WITHOUT ->
          let MenhirCell1_NEQ (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_023 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_048 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_OR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState048
      | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | IF | IMPORT | INCLUDE | MACRO | OPEN_EXPRESSION | OR | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | WITH | WITHOUT ->
          let MenhirCell1_OR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_021 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_046 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_DIV as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState046
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | DIV | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | GT | GT_EQ | IF | IMPORT | IN | INCLUDE | IS | LT | LT_EQ | MACRO | MINUS | MOD | NEQ | OPEN_EXPRESSION | OR | PLUS | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | TIMES | WITH | WITHOUT ->
          let MenhirCell1_DIV (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_016 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_042 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_MOD as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState042
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState042
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState042
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState042
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | DIV | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | GT | GT_EQ | IF | IMPORT | IN | INCLUDE | IS | LT | LT_EQ | MACRO | MINUS | MOD | NEQ | OPEN_EXPRESSION | OR | PLUS | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | TIMES | WITH | WITHOUT ->
          let MenhirCell1_MOD (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_017 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_040 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_PLUS as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState040
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState040
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState040
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState040
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState040
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState040
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState040
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | GT | GT_EQ | IF | IMPORT | IN | INCLUDE | IS | LT | LT_EQ | MACRO | MINUS | NEQ | OPEN_EXPRESSION | OR | PLUS | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | WITH | WITHOUT ->
          let MenhirCell1_PLUS (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_014 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_038 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_QUESTION as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | TIMES ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | QUESTION ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | POWER ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | PLUS ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | OR ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | NEQ ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | MOD ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | MINUS ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | LT_EQ ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | LT ->
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | LPAREN ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | LBRACKET ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | IS ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | IN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | GT_EQ ->
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | GT ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | FATARROW ->
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | EQ_EQ ->
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | DOT ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | COLON ->
          let _menhir_stack = MenhirCell1_COLON (_menhir_stack, MenhirState038) in
          let _menhir_s = MenhirState072 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FLOAT _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | DEFAULT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | AND ->
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState038
      | _ ->
          _eRR ()
  
  and _menhir_run_035 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_LBRACKET as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | RBRACKET ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LBRACKET (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_009 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState035
      | _ ->
          _eRR ()
  
  and _menhir_run_033 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_TIMES as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState033
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState033
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState033
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState033
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | DIV | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | GT | GT_EQ | IF | IMPORT | IN | INCLUDE | IS | LT | LT_EQ | MACRO | MINUS | MOD | NEQ | OPEN_EXPRESSION | OR | PLUS | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | TIMES | WITH | WITHOUT ->
          let MenhirCell1_TIMES (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_018 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_031 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_COMMA (_menhir_stack, MenhirState031) in
          let _menhir_s = MenhirState074 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FLOAT _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | DEFAULT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState031
      | RPAREN ->
          let _2 = _v in
          let _v = _menhir_action_089 _2 in
          _menhir_goto_separated_nonempty_list_COMMA_argument_application_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_argument_application_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState076 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState074 ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState181 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState019 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState027 ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_077 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_IDENT, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COMMA -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_COMMA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, _2_inlined2) = _menhir_stack in
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_092 _2_inlined2 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_argument_application_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_075 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_COMMA -> _ -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_COMMA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _menhir_s, _2_inlined1) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_091 _2_inlined1 xs in
      _menhir_goto_separated_nonempty_list_COMMA_argument_application_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_028 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let x = _v in
      let _v = _menhir_action_049 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_argument_application__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_argument_application__ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_input) _menhir_state -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState181 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState019 ->
          _menhir_run_078 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState027 ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_026 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_POWER as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState026
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState026
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState026
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | DIV | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | GT | GT_EQ | IF | IMPORT | IN | INCLUDE | IS | LT | LT_EQ | MACRO | MINUS | MOD | NEQ | OPEN_EXPRESSION | OR | PLUS | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | TIMES | VLINE | WITH | WITHOUT ->
          let MenhirCell1_POWER (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_019 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_024 : type  ttv_stack. (((ttv_stack, _menhir_box_input) _menhir_cell1_expr, _menhir_box_input) _menhir_cell1_VLINE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState024
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState024
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState024
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | AUTOESCAPE | BLOCK | CALL | CASE | CLOSE_EXPRESSION | COLON | COMMA | DEFAULT | DIV | ELSE | ELSEIF | ENDAUTOESCAPE | ENDBLOCK | ENDCALL | ENDFILTER | ENDFOR | ENDFUNCTION | ENDIF | ENDMACRO | ENDSET | ENDSWITCH | ENDWITH | EOF | EQ_EQ | EXTENDS | FATARROW | FILTER | FOR | FROM | FUNCTION | GT | GT_EQ | IF | IMPORT | IN | INCLUDE | IS | LT | LT_EQ | MACRO | MINUS | MOD | NEQ | OPEN_EXPRESSION | OR | PLUS | QUESTION | RAWINCLUDE | RBRACE | RBRACKET | RPAREN | SET | SWITCH | TEXT _ | TIMES | VLINE | WITH | WITHOUT ->
          let MenhirCell1_VLINE (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          let _3 = _v in
          let _v = _menhir_action_029 _1 _3 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_022 : type  ttv_stack. ((ttv_stack, _menhir_box_input) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_input) _menhir_state -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VLINE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | TIMES ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | QUESTION ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | POWER ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | MOD ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | LT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | LPAREN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | IS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | IN ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | GT_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_057 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | FATARROW ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_068 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | EQ_EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_COMMA (_menhir_stack, MenhirState022) in
          let _menhir_s = MenhirState076 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | NULL ->
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FLOAT _v ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | DEFAULT ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState022
      | RPAREN ->
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, x) = _menhir_stack in
          let _2 = _v in
          let _v = _menhir_action_090 _2 x in
          _menhir_goto_separated_nonempty_list_COMMA_argument_application_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  let _menhir_run_000 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_input =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WITH ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | TEXT _v ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState000
      | SWITCH ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | SET ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | RAWINCLUDE ->
          _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | OPEN_EXPRESSION ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | MACRO ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | INCLUDE ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | IMPORT ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | IF ->
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | FUNCTION ->
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | FROM ->
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | FOR ->
          _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | FILTER ->
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | EXTENDS ->
          _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | CALL ->
          _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | BLOCK ->
          _menhir_run_184 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | AUTOESCAPE ->
          _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | EOF ->
          let _v = _menhir_action_044 () in
          _menhir_run_250 _menhir_stack _v _tok
      | _ ->
          _eRR ()
  
end

let input =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_input v = _menhir_run_000 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
