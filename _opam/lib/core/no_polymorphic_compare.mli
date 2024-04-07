(** Open this in modules where you don't want to accidentally use polymorphic comparison.
    Then, use [Poly.(<)], for example, where needed. *)

open! Import

type compare =
  [ `no_polymorphic_compare ]
  -> [ `no_polymorphic_compare ]
  -> [ `no_polymorphic_compare ]

val compare : compare
val ( < ) : compare
val ( <= ) : compare
val ( > ) : compare
val ( >= ) : compare
val ( = ) : compare
val ( <> ) : compare
val equal : compare
val min : compare
val max : compare
