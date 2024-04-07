open Core

let%test_unit "polymorphic variant, variant, list, literal" =
  let module M = struct
    type normal_blop = Blop of int [@@deriving sexp_of]

    type variant_blop =
      [ `Message of string
      | `Blop of int
      ]
    [@@deriving sexp_of]
  end
  in
  [%test_result: Sexp.t]
    ~expect:
      (List
         [ M.sexp_of_variant_blop (`Message "string")
         ; M.sexp_of_variant_blop (`Blop 2)
         ; M.sexp_of_normal_blop (Blop 2)
         ])
    [%sexp [ `Message "string"; `Blop 2; Blop 2 ]]
;;

let%test_unit "record, if" =
  [%test_result: Sexp.t]
    ~expect:
      (List [ List [ Atom "message"; Atom "string" ]; List [ Atom "A.blop"; Atom "1" ] ])
    [%sexp { message = "string"; A.blop = (if true then 1 else `two) }]
;;

module A = struct
  type t = int [@@deriving sexp_of]
end

let a : A.t = 2

let%test_unit "tuple, explicit types" =
  [%test_result: Sexp.t]
    ~expect:(List [ Atom "2"; Atom "1" ])
    [%sexp (a : A.t), (lazy 1 : int Lazy.t)]
;;

let%test_unit "constructed list" =
  let int_list = [ 2; 3 ] in
  [%test_result: Sexp.t]
    ~expect:(List [ Atom "one"; Atom "2"; Atom "3" ])
    [%sexp `one :: (int_list : int list)]
;;

let%test_unit "strange case doesn't raise an exception" =
  [%test_result: Sexp.t] ~expect:(List [ Atom "A"; Atom "B" ]) [%sexp `A :: `B]
;;

let%test_unit "sexp.option everywhere except record fields" =
  [%test_result: Sexp.t]
    ~expect:
      (List
         [ Atom "A"; List [ Atom "B"; Atom "1" ]; List [ Atom "Some \"D\""; Atom "D" ] ])
    [%sexp
      `A
    , B (Some 1 : (int option[@sexp.option]))
    , C (None : (int option[@sexp.option]))
    , ~~(Some "D" : (string option[@sexp.option]))
    , ~~(None : (string option[@sexp.option]))]
;;

let%test_module "optional record field via sexp.option" =
  (module struct
    let none = None
    let some x = Some x

    let%test_unit "absent" =
      [%test_result: Sexp.t]
        ~expect:(List [ List [ Atom "a"; Atom "1" ]; List [ Atom "c"; Atom "3" ] ])
        [%sexp { a = 1; b = (none : (int option[@sexp.option])); c = 3 }]
    ;;

    let%test_unit "present" =
      [%test_result: Sexp.t]
        ~expect:
          (List
             [ List [ Atom "a"; Atom "1" ]
             ; List [ Atom "b"; Atom "2" ]
             ; List [ Atom "c"; Atom "3" ]
             ])
        [%sexp { a = 1; b = (some 2 : (int option[@sexp.option])); c = 3 }]
    ;;

    let%test_unit "all absent" =
      [%test_result: Sexp.t]
        ~expect:(List [])
        [%sexp
          { a = (none : (int option[@sexp.option]))
          ; b = (none : (int option[@sexp.option]))
          }]
    ;;

    let%test_unit "tail as variable name" =
      let tail = Some [ "bar"; "bat" ] in
      [%test_result: Sexp.t]
        ~expect:
          (List
             [ List [ Atom "head"; Atom "foo" ]
             ; List [ Atom "tail"; List [ Atom "bar"; Atom "bat" ] ]
             ])
        [%sexp { head = "foo"; tail : (string list option[@sexp.option]) }]
    ;;
  end)
;;

let%test_unit "omit_nil" =
  let[@cold] check sexp str =
    [%test_result: string] (Sexp.to_string_hum sexp) ~expect:str
  in
  check [%sexp { a = ([ 1 ] : (int list[@omit_nil])) }] "((a (1)))";
  check [%sexp { a = ([] : (int list[@omit_nil])) }] "()";
  check [%sexp A, B ([ 1 ] : (int list[@omit_nil]))] "(A (B (1)))";
  check [%sexp A, B ([] : (int list[@omit_nil]))] "(A)"
;;

let%test_module "expressions and their evaluation" =
  (module struct
    let%test_unit "at toplevel" =
      let x = 1 in
      [%test_result: Sexp.t] ~expect:(List [ Atom "x"; Atom "1" ]) [%sexp ~~(x : int)]
    ;;

    let%test_unit "anywhere" =
      let x = 1
      and y = 2 in
      [%test_result: Sexp.t]
        ~expect:
          (List
             [ Atom "message"
             ; List [ Atom "x"; Atom "1" ]
             ; List [ Atom "x + y"; Atom "3" ]
             ])
        [%sexp "message", ~~(x : int), ~~(x + y : int)]
    ;;
  end)
;;

let%test_unit "[%string]" =
  let b = "b" in
  [%test_result: Sexp.t] [%sexp [%string "a%{b}c"]] ~expect:[%sexp "abc"]
;;

let _no_warnings_from_merlin_check_about_overlapping_locations =
  let module Foo = struct
    type t = [ `A ]

    let sexp_of_t _ = Sexp.Atom "A"
  end
  in
  let foo = `A in
  let maybe_foo = Some `A in
  ( [%sexp { foo : Foo.t }]
  , [%sexp { foo : [< `A ] }]
  , [%sexp { foo : [< Foo.t ] }]
  , [%sexp { maybe_foo : Foo.t option }]
  , [%sexp { maybe_foo : [< `A ] option }]
  , [%sexp { maybe_foo : [< Foo.t ] option }] )
;;

let%test_unit "[%sexp] is not lazy" =
  let side_effect = ref false in
  let _ = [%sexp (side_effect := true : unit)] in
  [%test_result: bool] ~expect:true !side_effect
;;

let%test_unit "[%lazy_sexp] is lazy" =
  let side_effect = ref false in
  let delayed_sexp = [%lazy_sexp (side_effect := true : unit)] in
  [%test_result: bool] ~expect:false !side_effect;
  let _ = Lazy.force delayed_sexp in
  [%test_result: bool] ~expect:true !side_effect
;;

let%test_module "[%lazy_sexp] output" =
  (module struct
    let%test_unit "polymorphic variant, variant, list, literal" =
      let module M = struct
        type normal_blop = Blop of int [@@deriving sexp_of]

        type variant_blop =
          [ `Message of string
          | `Blop of int
          ]
        [@@deriving sexp_of]
      end
      in
      [%test_result: Sexp.t]
        ~expect:
          (List
             [ M.sexp_of_variant_blop (`Message "string")
             ; M.sexp_of_variant_blop (`Blop 2)
             ; M.sexp_of_normal_blop (Blop 2)
             ])
        [%sexp [ `Message "string"; `Blop 2; Blop 2 ]]
    ;;

    let%test_unit "record, if" =
      [%test_result: Sexp.t]
        ~expect:
          (List
             [ List [ Atom "message"; Atom "string" ]; List [ Atom "A.blop"; Atom "1" ] ])
        [%sexp { message = "string"; A.blop = (if true then 1 else `two) }]
    ;;

    let%test_unit "tuple, explicit types" =
      [%test_result: Sexp.t]
        ~expect:(List [ Atom "2"; Atom "1" ])
        [%sexp (a : A.t), (lazy 1 : int Lazy.t)]
    ;;

    let%test_unit "constructed list" =
      let int_list = [ 2; 3 ] in
      [%test_result: Sexp.t]
        ~expect:(List [ Atom "one"; Atom "2"; Atom "3" ])
        [%sexp `one :: (int_list : int list)]
    ;;

    let%test_unit "strange case doesn't raise an exception" =
      [%test_result: Sexp.t] ~expect:(List [ Atom "A"; Atom "B" ]) [%sexp `A :: `B]
    ;;

    let%test_unit "sexp.option everywhere except record fields" =
      [%test_result: Sexp.t]
        ~expect:
          (List
             [ Atom "A"
             ; List [ Atom "B"; Atom "1" ]
             ; List [ Atom "Some \"D\""; Atom "D" ]
             ])
        [%sexp
          `A
        , B (Some 1 : (int option[@sexp.option]))
        , C (None : (int option[@sexp.option]))
        , ~~(Some "D" : (string option[@sexp.option]))
        , ~~(None : (string option[@sexp.option]))]
    ;;
  end)
;;
