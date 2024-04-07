  $ ocamlc_where="$(ocamlc -where)"
  $ export BUILD_PATH_PREFIX_MAP="/OCAMLC_WHERE=$ocamlc_where:$BUILD_PATH_PREFIX_MAP"

  $ dune build foo.cma --profile release
  $ dune ocaml merlin dump-config $PWD
  Foo: _build/default/foo
  ((STDLIB /OCAMLC_WHERE)
   (EXCLUDE_QUERY_DIR)
   (B
    $TESTCASE_ROOT/_build/default/.foo.objs/byte)
   (S
    $TESTCASE_ROOT)
   (FLG (-w -40 -g)))

  $ rm -f .merlin
  $ dune build foo.cma --profile release
  $ dune ocaml merlin dump-config $PWD
  Foo: _build/default/foo
  ((STDLIB /OCAMLC_WHERE)
   (EXCLUDE_QUERY_DIR)
   (B
    $TESTCASE_ROOT/_build/default/.foo.objs/byte)
   (S
    $TESTCASE_ROOT)
   (FLG (-w -40 -g)))

  $ echo toto > .merlin
  $ dune build foo.cma --profile release
  $ dune ocaml merlin dump-config $PWD
  Foo: _build/default/foo
  ((STDLIB /OCAMLC_WHERE)
   (EXCLUDE_QUERY_DIR)
   (B
    $TESTCASE_ROOT/_build/default/.foo.objs/byte)
   (S
    $TESTCASE_ROOT)
   (FLG (-w -40 -g)))
