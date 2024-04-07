include Base.Type_equal

module Id = struct
  include Id

  module Uid = struct
    module Upstream = Base.Type_equal.Id.Uid
    include Base.Type_equal.Id.Uid

    include
      Comparable.Extend
        (Upstream)
        (struct
          type t = Base.Type_equal.Id.Uid.t [@@deriving sexp]
        end)

    include Hashable.Make (Upstream)
  end
end
