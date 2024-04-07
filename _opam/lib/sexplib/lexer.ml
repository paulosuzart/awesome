# 1 "src/lexer.mll"
 
  (** Lexer: Lexer Specification for S-expressions *)

  open Printf
  open Lexing

  let char_for_backslash = function
    | 'n' -> '\010'
    | 'r' -> '\013'
    | 'b' -> '\008'
    | 't' -> '\009'
    | c -> c

  let lf = '\010'

  let dec_code c1 c2 c3 =
    100 * (Char.code c1 - 48) + 10 * (Char.code c2 - 48) + (Char.code c3 - 48)

  let hex_code c1 c2 =
    let d1 = Char.code c1 in
    let val1 =
      if d1 >= 97 then d1 - 87
      else if d1 >= 65 then d1 - 55
      else d1 - 48 in
    let d2 = Char.code c2 in
    let val2 =
      if d2 >= 97 then d2 - 87
      else if d2 >= 65 then d2 - 55
      else d2 - 48 in
    val1 * 16 + val2

  let found_newline lexbuf diff =
    let lex_curr_p = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      {
        lex_curr_p with
        pos_lnum = lex_curr_p.pos_lnum + 1;
        pos_bol = lex_curr_p.pos_cnum - diff;
      }

  (* same length computation as in [Lexing.lexeme] *)
  let lexeme_len { lex_start_pos; lex_curr_pos; _ } = lex_curr_pos - lex_start_pos

  let main_failure lexbuf msg =
    let { pos_lnum; pos_bol; pos_cnum; pos_fname = _ } = lexeme_start_p lexbuf in
    let msg =
      sprintf
        "Sexplib.Lexer.main: %s at line %d char %d"
        msg pos_lnum (pos_cnum - pos_bol)
    in
    failwith msg

  module type T = sig
    module Quoted_string_buffer : sig
      type t
      val create : int -> t
      val add_char : t -> char -> unit
      val add_subbytes : t -> bytes -> int -> int -> unit
      val add_lexeme : t -> lexbuf -> unit
      val clear : t -> unit
      val of_buffer : Buffer.t -> t
    end
    module Token : sig
      type t
      val lparen : t
      val rparen : t
      val eof : t
      val simple_string : string -> t
      val hash_semi : t
      val quoted_string : Lexing.position -> Quoted_string_buffer.t -> t
      type s = Quoted_string_buffer.t -> Lexing.lexbuf -> t
      val comment : string -> main:s -> s
      val block_comment : Lexing.position -> main:s -> s
    end
  end

  module Make (X : T) : sig
    val main : ?buf:Buffer.t -> Lexing.lexbuf -> X.Token.t
  end = struct (* BEGIN FUNCTOR BODY CONTAINING GENERATED CODE *)
    open X

# 84 "src/lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base =
   "\000\000\244\255\010\000\043\000\053\000\250\255\251\255\252\255\
    \001\000\006\000\006\000\255\255\086\000\248\255\249\255\096\000\
    \129\000\139\000\172\000\182\000\220\000\230\000\007\001\247\255\
    \017\001\050\001\060\001\093\001\103\001\136\001\146\001\181\001\
    \191\001\224\001\234\001\011\002\037\000\246\255\080\000\248\255\
    \023\002\255\255\249\255\057\002\033\002\252\255\007\000\016\000\
    \017\000\112\002\251\255\144\002\250\255\081\000\250\255\253\255\
    \122\000\255\255\166\000\130\001\252\255\251\255\173\001\251\001\
    ";
  Lexing.lex_backtrk =
   "\255\255\255\255\010\000\010\000\010\000\255\255\255\255\255\255\
    \002\000\001\000\255\255\255\255\010\000\255\255\255\255\009\000\
    \010\000\009\000\009\000\009\000\009\000\009\000\010\000\255\255\
    \009\000\010\000\009\000\009\000\009\000\009\000\009\000\010\000\
    \010\000\009\000\009\000\009\000\255\255\255\255\008\000\255\255\
    \255\255\255\255\255\255\006\000\006\000\255\255\006\000\001\000\
    \002\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \001\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    ";
  Lexing.lex_default =
   "\002\000\000\000\002\000\002\000\002\000\000\000\000\000\000\000\
    \008\000\255\255\255\255\000\000\002\000\000\000\000\000\020\000\
    \002\000\018\000\018\000\018\000\020\000\020\000\002\000\000\000\
    \029\000\002\000\027\000\027\000\027\000\029\000\029\000\002\000\
    \002\000\034\000\034\000\034\000\038\000\000\000\038\000\000\000\
    \042\000\000\000\000\000\255\255\255\255\000\000\255\255\255\255\
    \255\255\255\255\000\000\255\255\000\000\056\000\000\000\000\000\
    \056\000\000\000\056\000\056\000\000\000\000\000\056\000\056\000\
    ";
  Lexing.lex_trans =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\009\000\011\000\255\255\009\000\010\000\255\255\009\000\
    \011\000\048\000\009\000\255\255\255\255\000\000\255\255\255\255\
    \000\000\047\000\048\000\000\000\000\000\000\000\000\000\000\000\
    \009\000\000\000\005\000\004\000\000\000\000\000\009\000\000\000\
    \007\000\006\000\255\255\000\000\255\255\032\000\000\000\039\000\
    \047\000\048\000\255\255\255\255\255\255\255\255\000\000\255\255\
    \255\255\000\000\000\000\008\000\000\000\000\000\255\255\255\255\
    \000\000\255\255\255\255\000\000\000\000\255\255\000\000\041\000\
    \000\000\000\000\000\000\255\255\000\000\255\255\023\000\000\000\
    \000\000\000\000\000\000\255\255\255\255\255\255\000\000\255\255\
    \012\000\000\000\255\255\057\000\000\000\255\255\255\255\255\255\
    \255\255\000\000\255\255\255\255\000\000\000\000\255\255\000\000\
    \000\000\255\255\255\255\000\000\255\255\255\255\000\000\000\000\
    \014\000\000\000\255\255\055\000\059\000\000\000\255\255\000\000\
    \255\255\016\000\000\000\000\000\003\000\000\000\255\255\255\255\
    \255\255\040\000\255\255\019\000\255\255\000\000\031\000\000\000\
    \255\255\255\255\255\255\255\255\000\000\255\255\255\255\000\000\
    \000\000\255\255\000\000\000\000\255\255\255\255\000\000\255\255\
    \255\255\000\000\000\000\255\255\255\255\063\000\000\000\000\000\
    \000\000\255\255\000\000\255\255\016\000\000\000\000\000\022\000\
    \000\000\255\255\255\255\255\255\255\255\255\255\019\000\000\000\
    \057\000\013\000\000\000\255\255\255\255\255\255\255\255\000\000\
    \255\255\255\255\000\000\000\000\255\255\000\000\000\000\255\255\
    \255\255\000\000\255\255\255\255\000\000\000\000\255\255\000\000\
    \055\000\061\000\000\000\000\000\255\255\058\000\255\255\019\000\
    \000\000\000\000\015\000\000\000\255\255\255\255\255\255\000\000\
    \255\255\019\000\000\000\000\000\015\000\000\000\255\255\255\255\
    \000\000\000\000\000\000\000\000\000\000\255\255\255\255\255\255\
    \255\255\255\255\000\000\000\000\000\000\000\000\000\000\255\255\
    \255\255\255\255\255\255\255\255\000\000\000\000\062\000\000\000\
    \000\000\000\000\000\000\000\000\255\255\017\000\255\255\021\000\
    \001\000\255\255\000\000\000\000\255\255\255\255\255\255\017\000\
    \255\255\021\000\255\255\000\000\000\000\000\000\255\255\255\255\
    \255\255\255\255\000\000\255\255\255\255\000\000\000\000\255\255\
    \000\000\000\000\255\255\255\255\000\000\255\255\255\255\000\000\
    \000\000\255\255\058\000\000\000\000\000\037\000\000\000\255\255\
    \017\000\255\255\024\000\255\255\000\000\000\000\000\000\255\255\
    \255\255\255\255\017\000\255\255\024\000\255\255\000\000\000\000\
    \000\000\255\255\255\255\255\255\255\255\000\000\255\255\255\255\
    \000\000\000\000\255\255\000\000\000\000\255\255\255\255\000\000\
    \255\255\255\255\000\000\000\000\255\255\000\000\000\000\000\000\
    \255\255\054\000\255\255\000\000\255\255\026\000\255\255\000\000\
    \015\000\000\000\255\255\255\255\255\255\000\000\255\255\026\000\
    \255\255\000\000\017\000\000\000\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\000\000\000\000\255\255\000\000\000\000\
    \255\255\255\255\000\000\255\255\255\255\000\000\000\000\255\255\
    \000\000\000\000\255\255\000\000\000\000\255\255\000\000\255\255\
    \026\000\255\255\000\000\025\000\000\000\255\255\255\255\255\255\
    \000\000\255\255\026\000\255\255\057\000\028\000\000\000\255\255\
    \255\255\255\255\255\255\000\000\255\255\255\255\000\000\000\000\
    \255\255\000\000\000\000\255\255\255\255\000\000\255\255\255\255\
    \000\000\000\000\255\255\000\000\055\000\059\000\255\255\000\000\
    \255\255\000\000\255\255\024\000\255\255\000\000\025\000\000\000\
    \255\255\255\255\255\255\000\000\255\255\026\000\255\255\255\255\
    \028\000\000\000\255\255\255\255\000\000\000\000\255\255\255\255\
    \000\000\255\255\255\255\255\255\000\000\000\000\000\000\000\000\
    \255\255\255\255\000\000\255\255\255\255\255\255\000\000\255\255\
    \255\255\000\000\000\000\000\000\000\000\255\255\000\000\255\255\
    \035\000\028\000\000\000\000\000\255\255\255\255\255\255\255\255\
    \000\000\255\255\032\000\028\000\000\000\000\000\255\255\255\255\
    \255\255\255\255\255\255\000\000\255\255\255\255\000\000\000\000\
    \255\255\000\000\000\000\255\255\255\255\000\000\255\255\255\255\
    \000\000\000\000\255\255\000\000\000\000\000\000\060\000\000\000\
    \255\255\000\000\255\255\035\000\030\000\255\255\000\000\255\255\
    \255\255\255\255\255\255\000\000\255\255\035\000\030\000\000\000\
    \000\000\255\255\255\255\255\255\255\255\255\255\000\000\255\255\
    \255\255\000\000\000\000\255\255\000\000\255\255\063\000\000\000\
    \000\000\047\000\000\000\000\000\046\000\255\255\000\000\000\000\
    \000\000\062\000\000\000\255\255\000\000\255\255\035\000\000\000\
    \000\000\031\000\255\255\255\255\255\255\000\000\000\000\045\000\
    \000\000\045\000\000\000\033\000\255\255\000\000\045\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\255\255\044\000\
    \044\000\044\000\044\000\044\000\044\000\044\000\044\000\044\000\
    \044\000\049\000\049\000\049\000\049\000\049\000\049\000\049\000\
    \049\000\049\000\049\000\000\000\033\000\255\255\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\033\000\255\255\
    \000\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\045\000\000\000\000\000\000\000\255\255\
    \000\000\045\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \000\000\000\000\255\255\000\000\000\000\045\000\000\000\033\000\
    \255\255\045\000\000\000\045\000\000\000\000\000\000\000\043\000\
    \000\000\000\000\255\255\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \050\000\050\000\050\000\050\000\050\000\050\000\050\000\050\000\
    \050\000\050\000\000\000\000\000\000\000\255\255\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\255\255\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\255\255\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\052\000\052\000\052\000\052\000\052\000\052\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\255\255\000\000\000\000\000\000\000\000\000\000\
    \000\000\052\000\052\000\052\000\052\000\052\000\052\000\000\000\
    \000\000\000\000\000\000\255\255\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\255\255\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\255\255\
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
    \000\000";
  Lexing.lex_check =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\008\000\000\000\000\000\008\000\009\000\
    \010\000\046\000\009\000\002\000\002\000\255\255\002\000\002\000\
    \255\255\047\000\048\000\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\000\000\000\000\255\255\255\255\009\000\255\255\
    \000\000\000\000\002\000\255\255\002\000\002\000\255\255\036\000\
    \047\000\048\000\002\000\002\000\003\000\003\000\255\255\003\000\
    \003\000\255\255\255\255\000\000\255\255\255\255\004\000\004\000\
    \255\255\004\000\004\000\255\255\255\255\002\000\255\255\036\000\
    \255\255\255\255\255\255\003\000\255\255\003\000\003\000\255\255\
    \255\255\255\255\255\255\003\000\003\000\004\000\255\255\004\000\
    \004\000\255\255\038\000\053\000\255\255\004\000\004\000\012\000\
    \012\000\255\255\012\000\012\000\255\255\255\255\003\000\255\255\
    \255\255\015\000\015\000\255\255\015\000\015\000\255\255\255\255\
    \004\000\255\255\038\000\053\000\053\000\255\255\012\000\255\255\
    \012\000\012\000\255\255\255\255\000\000\255\255\012\000\012\000\
    \015\000\036\000\015\000\015\000\056\000\255\255\002\000\255\255\
    \015\000\015\000\016\000\016\000\255\255\016\000\016\000\255\255\
    \255\255\012\000\255\255\255\255\017\000\017\000\255\255\017\000\
    \017\000\255\255\255\255\015\000\056\000\056\000\255\255\255\255\
    \255\255\016\000\255\255\016\000\016\000\255\255\255\255\003\000\
    \255\255\016\000\016\000\017\000\038\000\017\000\017\000\255\255\
    \058\000\004\000\255\255\017\000\017\000\018\000\018\000\255\255\
    \018\000\018\000\255\255\255\255\016\000\255\255\255\255\019\000\
    \019\000\255\255\019\000\019\000\255\255\255\255\017\000\255\255\
    \058\000\058\000\255\255\255\255\018\000\053\000\018\000\018\000\
    \255\255\255\255\012\000\255\255\018\000\018\000\019\000\255\255\
    \019\000\019\000\255\255\255\255\015\000\255\255\019\000\019\000\
    \255\255\255\255\255\255\255\255\255\255\020\000\020\000\018\000\
    \020\000\020\000\255\255\255\255\255\255\255\255\255\255\021\000\
    \021\000\019\000\021\000\021\000\255\255\255\255\056\000\255\255\
    \255\255\255\255\255\255\255\255\020\000\016\000\020\000\020\000\
    \000\000\008\000\255\255\255\255\020\000\020\000\021\000\017\000\
    \021\000\021\000\002\000\255\255\255\255\255\255\021\000\021\000\
    \022\000\022\000\255\255\022\000\022\000\255\255\255\255\020\000\
    \255\255\255\255\024\000\024\000\255\255\024\000\024\000\255\255\
    \255\255\021\000\058\000\255\255\255\255\036\000\255\255\022\000\
    \018\000\022\000\022\000\003\000\255\255\255\255\255\255\022\000\
    \022\000\024\000\019\000\024\000\024\000\004\000\255\255\255\255\
    \255\255\024\000\024\000\025\000\025\000\255\255\025\000\025\000\
    \255\255\255\255\022\000\255\255\255\255\026\000\026\000\255\255\
    \026\000\026\000\255\255\255\255\024\000\255\255\255\255\255\255\
    \038\000\053\000\025\000\255\255\025\000\025\000\012\000\255\255\
    \020\000\255\255\025\000\025\000\026\000\255\255\026\000\026\000\
    \015\000\255\255\021\000\255\255\026\000\026\000\027\000\027\000\
    \255\255\027\000\027\000\255\255\255\255\025\000\255\255\255\255\
    \028\000\028\000\255\255\028\000\028\000\255\255\255\255\026\000\
    \255\255\255\255\056\000\255\255\255\255\027\000\255\255\027\000\
    \027\000\016\000\255\255\022\000\255\255\027\000\027\000\028\000\
    \255\255\028\000\028\000\017\000\059\000\024\000\255\255\028\000\
    \028\000\029\000\029\000\255\255\029\000\029\000\255\255\255\255\
    \027\000\255\255\255\255\030\000\030\000\255\255\030\000\030\000\
    \255\255\255\255\028\000\255\255\059\000\059\000\058\000\255\255\
    \029\000\255\255\029\000\029\000\018\000\255\255\025\000\255\255\
    \029\000\029\000\030\000\255\255\030\000\030\000\019\000\062\000\
    \026\000\255\255\030\000\030\000\255\255\255\255\031\000\031\000\
    \255\255\031\000\031\000\029\000\255\255\255\255\255\255\255\255\
    \032\000\032\000\255\255\032\000\032\000\030\000\255\255\062\000\
    \062\000\255\255\255\255\255\255\255\255\031\000\255\255\031\000\
    \031\000\027\000\255\255\255\255\020\000\031\000\031\000\032\000\
    \255\255\032\000\032\000\028\000\255\255\255\255\021\000\032\000\
    \032\000\033\000\033\000\255\255\033\000\033\000\255\255\255\255\
    \031\000\255\255\255\255\034\000\034\000\255\255\034\000\034\000\
    \255\255\255\255\032\000\255\255\255\255\255\255\059\000\255\255\
    \033\000\255\255\033\000\033\000\029\000\063\000\255\255\022\000\
    \033\000\033\000\034\000\255\255\034\000\034\000\030\000\255\255\
    \255\255\024\000\034\000\034\000\035\000\035\000\255\255\035\000\
    \035\000\255\255\255\255\033\000\255\255\063\000\063\000\255\255\
    \255\255\040\000\255\255\255\255\040\000\034\000\255\255\255\255\
    \255\255\062\000\255\255\035\000\255\255\035\000\035\000\255\255\
    \255\255\031\000\025\000\035\000\035\000\255\255\255\255\040\000\
    \255\255\040\000\255\255\032\000\026\000\255\255\040\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\035\000\040\000\
    \040\000\040\000\040\000\040\000\040\000\040\000\040\000\040\000\
    \040\000\044\000\044\000\044\000\044\000\044\000\044\000\044\000\
    \044\000\044\000\044\000\255\255\033\000\027\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\034\000\028\000\
    \255\255\043\000\043\000\043\000\043\000\043\000\043\000\043\000\
    \043\000\043\000\043\000\040\000\255\255\255\255\255\255\063\000\
    \255\255\040\000\043\000\043\000\043\000\043\000\043\000\043\000\
    \255\255\255\255\059\000\255\255\255\255\040\000\255\255\035\000\
    \029\000\040\000\255\255\040\000\255\255\255\255\255\255\040\000\
    \255\255\255\255\030\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\043\000\043\000\043\000\043\000\043\000\043\000\
    \049\000\049\000\049\000\049\000\049\000\049\000\049\000\049\000\
    \049\000\049\000\255\255\255\255\255\255\062\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\031\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\032\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\051\000\051\000\051\000\051\000\051\000\051\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \033\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\034\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\051\000\051\000\051\000\051\000\051\000\051\000\255\255\
    \255\255\255\255\255\255\063\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\035\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\040\000\
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
    \255\255";
  Lexing.lex_base_code =
   "";
  Lexing.lex_backtrk_code =
   "";
  Lexing.lex_default_code =
   "";
  Lexing.lex_trans_code =
   "";
  Lexing.lex_check_code =
   "";
  Lexing.lex_code =
   "";
}

let rec main buf lexbuf =
   __ocaml_lex_main_rec buf lexbuf 0
and __ocaml_lex_main_rec buf lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 95 "src/lexer.mll"
                     ( found_newline lexbuf 0;
                       main buf lexbuf )
# 370 "src/lexer.ml"

  | 1 ->
# 97 "src/lexer.mll"
           ( main buf lexbuf )
# 375 "src/lexer.ml"

  | 2 ->
let
# 98 "src/lexer.mll"
                          text
# 381 "src/lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 98 "src/lexer.mll"
                               ( Token.comment text ~main buf lexbuf )
# 385 "src/lexer.ml"

  | 3 ->
# 99 "src/lexer.mll"
        ( Token.lparen )
# 390 "src/lexer.ml"

  | 4 ->
# 100 "src/lexer.mll"
        ( Token.rparen )
# 395 "src/lexer.ml"

  | 5 ->
# 102 "src/lexer.mll"
      (
        let pos = Lexing.lexeme_start_p lexbuf in
        Quoted_string_buffer.add_lexeme buf lexbuf;
        scan_string buf pos lexbuf;
        let tok = Token.quoted_string pos buf in
        Quoted_string_buffer.clear buf;
        tok
      )
# 407 "src/lexer.ml"

  | 6 ->
# 110 "src/lexer.mll"
         ( Token.hash_semi )
# 412 "src/lexer.ml"

  | 7 ->
# 112 "src/lexer.mll"
      (
        let pos = Lexing.lexeme_start_p lexbuf in
        Quoted_string_buffer.add_lexeme buf lexbuf;
        scan_block_comment buf [pos] lexbuf;
        let tok = Token.block_comment pos ~main buf lexbuf in
        Quoted_string_buffer.clear buf;
        tok
      )
# 424 "src/lexer.ml"

  | 8 ->
# 120 "src/lexer.mll"
         ( main_failure lexbuf "illegal end of comment" )
# 429 "src/lexer.ml"

  | 9 ->
# 126 "src/lexer.mll"
      ( main_failure lexbuf "comment tokens in unquoted atom" )
# 434 "src/lexer.ml"

  | 10 ->
let
# 127 "src/lexer.mll"
                                            str
# 440 "src/lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 127 "src/lexer.mll"
                                                ( Token.simple_string str )
# 444 "src/lexer.ml"

  | 11 ->
# 128 "src/lexer.mll"
        ( Token.eof )
# 449 "src/lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_main_rec buf lexbuf __ocaml_lex_state

and scan_string buf start lexbuf =
   __ocaml_lex_scan_string_rec buf start lexbuf 36
and __ocaml_lex_scan_string_rec buf start lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 131 "src/lexer.mll"
        ( Quoted_string_buffer.add_lexeme buf lexbuf; () )
# 461 "src/lexer.ml"

  | 1 ->
# 133 "src/lexer.mll"
      (
        let len = lexeme_len lexbuf - 2 in
        found_newline lexbuf len;
        Quoted_string_buffer.add_lexeme buf lexbuf;
        scan_string buf start lexbuf
      )
# 471 "src/lexer.ml"

  | 2 ->
# 140 "src/lexer.mll"
      (
        let len = lexeme_len lexbuf - 3 in
        found_newline lexbuf len;
        Quoted_string_buffer.add_lexeme buf lexbuf;
        scan_string buf start lexbuf
      )
# 481 "src/lexer.ml"

  | 3 ->
let
# 146 "src/lexer.mll"
                                                 c
# 487 "src/lexer.ml"
= Lexing.sub_lexeme_char lexbuf (lexbuf.Lexing.lex_start_pos + 1) in
# 147 "src/lexer.mll"
      (
        Quoted_string_buffer.add_char buf (char_for_backslash c);
        Quoted_string_buffer.add_lexeme buf lexbuf;
        scan_string buf start lexbuf
      )
# 495 "src/lexer.ml"

  | 4 ->
let
# 152 "src/lexer.mll"
                   c1
# 501 "src/lexer.ml"
= Lexing.sub_lexeme_char lexbuf (lexbuf.Lexing.lex_start_pos + 1)
and
# 152 "src/lexer.mll"
                                 c2
# 506 "src/lexer.ml"
= Lexing.sub_lexeme_char lexbuf (lexbuf.Lexing.lex_start_pos + 2)
and
# 152 "src/lexer.mll"
                                               c3
# 511 "src/lexer.ml"
= Lexing.sub_lexeme_char lexbuf (lexbuf.Lexing.lex_start_pos + 3) in
# 153 "src/lexer.mll"
      (
        let v = dec_code c1 c2 c3 in
        if v > 255 then (
          let { pos_lnum; pos_bol; pos_cnum; pos_fname = _ } = lexeme_end_p lexbuf in
          let msg =
            sprintf
              "Sexplib.Lexer.scan_string: \
               illegal escape at line %d char %d: `\\%c%c%c'"
              pos_lnum (pos_cnum - pos_bol - 3)
              c1 c2 c3 in
          failwith msg);
        Quoted_string_buffer.add_char buf (Char.chr v);
        Quoted_string_buffer.add_lexeme buf lexbuf;
        scan_string buf start lexbuf
      )
# 529 "src/lexer.ml"

  | 5 ->
let
# 168 "src/lexer.mll"
                          c1
# 535 "src/lexer.ml"
= Lexing.sub_lexeme_char lexbuf (lexbuf.Lexing.lex_start_pos + 2)
and
# 168 "src/lexer.mll"
                                           c2
# 540 "src/lexer.ml"
= Lexing.sub_lexeme_char lexbuf (lexbuf.Lexing.lex_start_pos + 3) in
# 169 "src/lexer.mll"
      (
        let v = hex_code c1 c2 in
        Quoted_string_buffer.add_char buf (Char.chr v);
        Quoted_string_buffer.add_lexeme buf lexbuf;
        scan_string buf start lexbuf
      )
# 549 "src/lexer.ml"

  | 6 ->
let
# 175 "src/lexer.mll"
               c
# 555 "src/lexer.ml"
= Lexing.sub_lexeme_char lexbuf (lexbuf.Lexing.lex_start_pos + 1) in
# 176 "src/lexer.mll"
      (
        Quoted_string_buffer.add_char buf '\\';
        Quoted_string_buffer.add_char buf c;
        Quoted_string_buffer.add_lexeme buf lexbuf;
        scan_string buf start lexbuf
      )
# 564 "src/lexer.ml"

  | 7 ->
# 183 "src/lexer.mll"
      (
        found_newline lexbuf 0;
        Quoted_string_buffer.add_char buf lf;
        Quoted_string_buffer.add_lexeme buf lexbuf;
        scan_string buf start lexbuf
      )
# 574 "src/lexer.ml"

  | 8 ->
# 190 "src/lexer.mll"
      (
        let ofs = lexbuf.lex_start_pos in
        let len = lexbuf.lex_curr_pos - ofs in
        Quoted_string_buffer.add_subbytes buf lexbuf.lex_buffer ofs len;
        Quoted_string_buffer.add_lexeme buf lexbuf;
        scan_string buf start lexbuf
      )
# 585 "src/lexer.ml"

  | 9 ->
# 198 "src/lexer.mll"
      (
        let msg =
          sprintf
            "Sexplib.Lexer.scan_string: unterminated string at line %d char %d"
            start.pos_lnum (start.pos_cnum - start.pos_bol)
        in
        failwith msg
      )
# 597 "src/lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_scan_string_rec buf start lexbuf __ocaml_lex_state

and scan_block_comment buf locs lexbuf =
   __ocaml_lex_scan_block_comment_rec buf locs lexbuf 53
and __ocaml_lex_scan_block_comment_rec buf locs lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 209 "src/lexer.mll"
      ( Quoted_string_buffer.add_lexeme buf lexbuf;
        found_newline lexbuf 0; scan_block_comment buf locs lexbuf )
# 610 "src/lexer.ml"

  | 1 ->
# 212 "src/lexer.mll"
      ( Quoted_string_buffer.add_lexeme buf lexbuf;
        scan_block_comment buf locs lexbuf )
# 616 "src/lexer.ml"

  | 2 ->
# 215 "src/lexer.mll"
      (
        Quoted_string_buffer.add_lexeme buf lexbuf;
        let cur = lexeme_end_p lexbuf in
        let start = { cur with pos_cnum = cur.pos_cnum - 1 } in
        scan_string buf start lexbuf;
        scan_block_comment buf locs lexbuf
      )
# 627 "src/lexer.ml"

  | 3 ->
# 223 "src/lexer.mll"
    (
      Quoted_string_buffer.add_lexeme buf lexbuf;
      let cur = lexeme_end_p lexbuf in
      let start = { cur with pos_cnum = cur.pos_cnum - 2 } in
      scan_block_comment buf (start :: locs) lexbuf
    )
# 637 "src/lexer.ml"

  | 4 ->
# 230 "src/lexer.mll"
      (
        Quoted_string_buffer.add_lexeme buf lexbuf;
        match locs with
        | [_] -> () (* the comment is finished *)
        | _ :: (_ :: _ as t) -> scan_block_comment buf t lexbuf
        | [] -> assert false  (* impossible *)
      )
# 648 "src/lexer.ml"

  | 5 ->
# 238 "src/lexer.mll"
      (
        match locs with
        | [] -> assert false
        | { pos_lnum; pos_bol; pos_cnum; pos_fname = _ } :: _ ->
            let msg =
              sprintf "Sexplib.Lexer.scan_block_comment: \
                unterminated block comment at line %d char %d"
                pos_lnum (pos_cnum - pos_bol)
            in
            failwith msg
      )
# 663 "src/lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_scan_block_comment_rec buf locs lexbuf __ocaml_lex_state

;;

# 250 "src/lexer.mll"
  (* RESUME FUNCTOR BODY CONTAINING GENERATED CODE *)

    let main ?buf =
      let buf =
        match buf with
        | None -> Quoted_string_buffer.create 64
        | Some buf ->
          Buffer.clear buf;
          Quoted_string_buffer.of_buffer buf
      in
      main buf

  end (* END FUNCTOR BODY CONTAINING GENERATED CODE *)

  module Vanilla =
    Make (struct
      module Quoted_string_buffer = struct
        include Buffer
        let add_lexeme _ _ = ()
        let of_buffer b = b
      end
      module Token = struct
        open Parser
        type t = token
        type s = Quoted_string_buffer.t -> Lexing.lexbuf -> t
        let eof = EOF
        let lparen = LPAREN
        let rparen = RPAREN
        let hash_semi = HASH_SEMI
        let simple_string x = STRING x
        let quoted_string _ buf = STRING (Buffer.contents buf)
        let block_comment _pos ~main buf lexbuf =
          main buf lexbuf
        let comment _text ~main buf lexbuf =
          main buf lexbuf (* skip and continue lexing *)
      end
    end)

  module With_layout =
    Make (struct
      module Quoted_string_buffer = struct
        type t = {
          contents : Buffer.t;
          lexeme : Buffer.t;
        }
        let create n = {contents = Buffer.create n; lexeme = Buffer.create n}
        let of_buffer contents = { contents; lexeme = Buffer.create 64 }
        let add_char t ch = Buffer.add_char t.contents ch
        let add_subbytes t str ofs len = Buffer.add_subbytes t.contents str ofs len
        let add_lexeme t lexbuf = Buffer.add_string t.lexeme (Lexing.lexeme lexbuf)
        let clear t = Buffer.clear t.lexeme; Buffer.clear t.contents
      end
      module Token = struct
        open Parser_with_layout
        type t = token
        type s = Quoted_string_buffer.t -> Lexing.lexbuf -> t
        let eof = EOF
        let lparen = LPAREN
        let rparen = RPAREN
        let hash_semi = HASH_SEMI
        let simple_string x = STRING (x, None)
        let quoted_string pos {Quoted_string_buffer.contents; lexeme} =
          STRING (Buffer.contents contents, Some (pos, Buffer.contents lexeme))
        let block_comment pos ~main:_ {Quoted_string_buffer.contents = _; lexeme} _lexbuf =
          COMMENT (Buffer.contents lexeme, Some pos)
        let comment text ~main:_ _buf _lexbuf =
          COMMENT (text, None)
      end
    end)

  let main = Vanilla.main
  let main_with_layout = With_layout.main


# 745 "src/lexer.ml"
