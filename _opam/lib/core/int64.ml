open! Import

include
  Identifiable.Extend
    (Base.Int64)
    (struct
      type t = int64 [@@deriving bin_io]
    end)

include Base.Int64
include Comparable.Validate_with_zero (Base.Int64)

type t = int64 [@@deriving typerep]

module Hex = struct
  include Hex

  type nonrec t = t [@@deriving typerep, bin_io]
end

let quickcheck_generator = Base_quickcheck.Generator.int64
let quickcheck_observer = Base_quickcheck.Observer.int64
let quickcheck_shrinker = Base_quickcheck.Shrinker.int64
let gen_incl = Base_quickcheck.Generator.int64_inclusive
let gen_uniform_incl = Base_quickcheck.Generator.int64_uniform_inclusive
let gen_log_incl = Base_quickcheck.Generator.int64_log_inclusive
let gen_log_uniform_incl = Base_quickcheck.Generator.int64_log_uniform_inclusive
