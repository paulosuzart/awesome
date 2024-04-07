#define INTLIT
#define FLOATLIT
#define STRINGLIT
#define TUPLE
#define VARIANT

#include "type.ml"

#include "write.ml"

module Pretty = struct
  #include "prettyprint.ml"
end

#include "monomorphic.ml"

#include "write2.ml"

#include "read.ml"

module Util = struct
  #include "util.ml"
end

#undef INTLIT
#undef FLOATLIT
#undef STRINGLIT
#undef TUPLE
#undef VARIANT
