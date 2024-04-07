open! Import
open Stable_module_types

module Of_stable_format : sig
  module V1 (Stable_format : sig
      type t [@@deriving bin_io, sexp]
    end) (M : sig
            type t [@@deriving compare]

            val to_stable_format : t -> Stable_format.t
            val of_stable_format : Stable_format.t -> t
          end) : S0 with type t = M.t

  module V2 (Stable_format : sig
      type t [@@deriving bin_io, sexp]
    end) (M : sig
            type t [@@deriving compare]

            val to_stable_format : t -> Stable_format.t
            val of_stable_format : Stable_format.t -> t
            val caller_identity : Bin_shape.Uuid.t
          end) : S0 with type t = M.t
end

module Of_stable_format1 : sig
  module V1 (Stable_format : sig
      type 'a t [@@deriving bin_io, sexp]
    end) (M : sig
            type 'a t [@@deriving compare]

            val map : 'a t -> f:('a -> 'b) -> 'b t
            val to_stable_format : 'a t -> 'a Stable_format.t
            val of_stable_format : 'a Stable_format.t -> 'a t
          end) : S1 with type 'a t = 'a M.t

  module V2 (Stable_format : sig
      type 'a t [@@deriving bin_io, sexp]
    end) (M : sig
            type 'a t [@@deriving compare]

            val map : 'a t -> f:('a -> 'b) -> 'b t
            val to_stable_format : 'a t -> 'a Stable_format.t
            val of_stable_format : 'a Stable_format.t -> 'a t
            val caller_identity : Bin_shape.Uuid.t
          end) : S1 with type 'a t = 'a M.t
end

module Of_stable_format2 : sig
  module V1 (Stable_format : sig
      type ('a1, 'a2) t [@@deriving bin_io, sexp]
    end) (M : sig
            type ('a1, 'a2) t [@@deriving compare]

            val map : ('a1, 'a2) t -> f1:('a1 -> 'b1) -> f2:('a2 -> 'b2) -> ('b1, 'b2) t
            val to_stable_format : ('a1, 'a2) t -> ('a1, 'a2) Stable_format.t
            val of_stable_format : ('a1, 'a2) Stable_format.t -> ('a1, 'a2) t
          end) : S2 with type ('a1, 'a2) t = ('a1, 'a2) M.t

  module V2 (Stable_format : sig
      type ('a1, 'a2) t [@@deriving bin_io, sexp]
    end) (M : sig
            type ('a1, 'a2) t [@@deriving compare]

            val map : ('a1, 'a2) t -> f1:('a1 -> 'b1) -> f2:('a2 -> 'b2) -> ('b1, 'b2) t
            val to_stable_format : ('a1, 'a2) t -> ('a1, 'a2) Stable_format.t
            val of_stable_format : ('a1, 'a2) Stable_format.t -> ('a1, 'a2) t
            val caller_identity : Bin_shape.Uuid.t
          end) : S2 with type ('a1, 'a2) t = ('a1, 'a2) M.t
end

module Of_stable_format3 : sig
  module V1 (Stable_format : sig
      type ('a1, 'a2, 'a3) t [@@deriving bin_io, sexp]
    end) (M : sig
            type ('a1, 'a2, 'a3) t [@@deriving compare]

            val map
              :  ('a1, 'a2, 'a3) t
              -> f1:('a1 -> 'b1)
              -> f2:('a2 -> 'b2)
              -> f3:('a3 -> 'b3)
              -> ('b1, 'b2, 'b3) t

            val to_stable_format : ('a1, 'a2, 'a3) t -> ('a1, 'a2, 'a3) Stable_format.t
            val of_stable_format : ('a1, 'a2, 'a3) Stable_format.t -> ('a1, 'a2, 'a3) t
          end) : S3 with type ('a1, 'a2, 'a3) t = ('a1, 'a2, 'a3) M.t

  module V2 (Stable_format : sig
      type ('a1, 'a2, 'a3) t [@@deriving bin_io, sexp]
    end) (M : sig
            type ('a1, 'a2, 'a3) t [@@deriving compare]

            val map
              :  ('a1, 'a2, 'a3) t
              -> f1:('a1 -> 'b1)
              -> f2:('a2 -> 'b2)
              -> f3:('a3 -> 'b3)
              -> ('b1, 'b2, 'b3) t

            val to_stable_format : ('a1, 'a2, 'a3) t -> ('a1, 'a2, 'a3) Stable_format.t
            val of_stable_format : ('a1, 'a2, 'a3) Stable_format.t -> ('a1, 'a2, 'a3) t
            val caller_identity : Bin_shape.Uuid.t
          end) : S3 with type ('a1, 'a2, 'a3) t = ('a1, 'a2, 'a3) M.t
end

module With_stable_witness : sig
  module Of_stable_format : sig
    module V1 (Stable_format : sig
        type t [@@deriving bin_io, sexp, stable_witness]
      end) (M : sig
              type t [@@deriving compare]

              val to_stable_format : t -> Stable_format.t
              val of_stable_format : Stable_format.t -> t
            end) : With_stable_witness.S0 with type t = M.t

    module V2 (Stable_format : sig
        type t [@@deriving bin_io, sexp, stable_witness]
      end) (M : sig
              type t [@@deriving compare]

              val to_stable_format : t -> Stable_format.t
              val of_stable_format : Stable_format.t -> t
              val caller_identity : Bin_shape.Uuid.t
            end) : With_stable_witness.S0 with type t = M.t
  end

  module Of_stable_format1 : sig
    module V1 (Stable_format : sig
        type 'a t [@@deriving bin_io, sexp, stable_witness]
      end) (M : sig
              type 'a t [@@deriving compare]

              val map : 'a t -> f:('a -> 'b) -> 'b t
              val to_stable_format : 'a t -> 'a Stable_format.t
              val of_stable_format : 'a Stable_format.t -> 'a t
            end) : With_stable_witness.S1 with type 'a t = 'a M.t

    module V2 (Stable_format : sig
        type 'a t [@@deriving bin_io, sexp, stable_witness]
      end) (M : sig
              type 'a t [@@deriving compare]

              val map : 'a t -> f:('a -> 'b) -> 'b t
              val to_stable_format : 'a t -> 'a Stable_format.t
              val of_stable_format : 'a Stable_format.t -> 'a t
              val caller_identity : Bin_shape.Uuid.t
            end) : With_stable_witness.S1 with type 'a t = 'a M.t
  end

  module Of_stable_format2 : sig
    module V1 (Stable_format : sig
        type ('a1, 'a2) t [@@deriving bin_io, sexp, stable_witness]
      end) (M : sig
              type ('a1, 'a2) t [@@deriving compare]

              val map : ('a1, 'a2) t -> f1:('a1 -> 'b1) -> f2:('a2 -> 'b2) -> ('b1, 'b2) t
              val to_stable_format : ('a1, 'a2) t -> ('a1, 'a2) Stable_format.t
              val of_stable_format : ('a1, 'a2) Stable_format.t -> ('a1, 'a2) t
            end) : With_stable_witness.S2 with type ('a1, 'a2) t = ('a1, 'a2) M.t

    module V2 (Stable_format : sig
        type ('a1, 'a2) t [@@deriving bin_io, sexp, stable_witness]
      end) (M : sig
              type ('a1, 'a2) t [@@deriving compare]

              val map : ('a1, 'a2) t -> f1:('a1 -> 'b1) -> f2:('a2 -> 'b2) -> ('b1, 'b2) t
              val to_stable_format : ('a1, 'a2) t -> ('a1, 'a2) Stable_format.t
              val of_stable_format : ('a1, 'a2) Stable_format.t -> ('a1, 'a2) t
              val caller_identity : Bin_shape.Uuid.t
            end) : With_stable_witness.S2 with type ('a1, 'a2) t = ('a1, 'a2) M.t
  end

  module Of_stable_format3 : sig
    module V1 (Stable_format : sig
        type ('a1, 'a2, 'a3) t [@@deriving bin_io, sexp, stable_witness]
      end) (M : sig
              type ('a1, 'a2, 'a3) t [@@deriving compare]

              val map
                :  ('a1, 'a2, 'a3) t
                -> f1:('a1 -> 'b1)
                -> f2:('a2 -> 'b2)
                -> f3:('a3 -> 'b3)
                -> ('b1, 'b2, 'b3) t

              val to_stable_format : ('a1, 'a2, 'a3) t -> ('a1, 'a2, 'a3) Stable_format.t
              val of_stable_format : ('a1, 'a2, 'a3) Stable_format.t -> ('a1, 'a2, 'a3) t
            end) : With_stable_witness.S3 with type ('a1, 'a2, 'a3) t = ('a1, 'a2, 'a3) M.t

    module V2 (Stable_format : sig
        type ('a1, 'a2, 'a3) t [@@deriving bin_io, sexp, stable_witness]
      end) (M : sig
              type ('a1, 'a2, 'a3) t [@@deriving compare]

              val map
                :  ('a1, 'a2, 'a3) t
                -> f1:('a1 -> 'b1)
                -> f2:('a2 -> 'b2)
                -> f3:('a3 -> 'b3)
                -> ('b1, 'b2, 'b3) t

              val to_stable_format : ('a1, 'a2, 'a3) t -> ('a1, 'a2, 'a3) Stable_format.t
              val of_stable_format : ('a1, 'a2, 'a3) Stable_format.t -> ('a1, 'a2, 'a3) t
              val caller_identity : Bin_shape.Uuid.t
            end) : With_stable_witness.S3 with type ('a1, 'a2, 'a3) t = ('a1, 'a2, 'a3) M.t
  end
end
