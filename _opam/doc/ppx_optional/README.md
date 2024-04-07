ppx_optional - match statements for zero-alloc options
======================================================

A ppx rewriter that rewrites simple match statements with an if then
else expression.

Syntax
------

`ppx_optional` rewrites the extension `match%optional` in expressions.
It requires that a module `Optional_syntax` is in scope, and that it
has `is_none` and `unsafe_value` values.

For instance:

```ocaml
match%optional e with
| None -> none_expression
| Some x -> some_expression
```

becomes:

```ocaml
if Optional_syntax.is_none e then begin
   none_expression
end else begin
   let x = Optional_syntax.unsafe_value e in
   some_expression
end
```

Another example with multiple values and inline getting `Optional_syntax` in scope:

```ocaml
match%optional.Price_float.Option a, b with
| None, None -> expression_a
| Some a, None -> expression_b
| None, Some b -> expression_c
| Some a, Some b -> expression_d
```

Usage
-----

This is normally used to safely access an optional value while
avoiding allocation for immediate values
(e.g. `Immediate.{Char,Bool,Int}.Option`, `Fixed.Option`,
`Price.Fixed.Option`, etc...).
