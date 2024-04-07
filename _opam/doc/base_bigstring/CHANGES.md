## Release v0.16.0:

- Improved support for locals (stack allocation):
  * Add `[@local]` attribute to the `t` arguments of `length`, `unsafe_set_int8`,
    `unsafe_set_int16_le`, `unsafe_set_int16_be`, `unsafe_set_int32_le` and
    `unsafe_set_int32_be`.
  * Likewise for the `Int64.t` arguments of `set_int64_t_le`, `set_int64_t_be`,
    `unsafe_set_int64_t_le`, and `unsafe_set_int64_t_be`.
  * Add new `Local` module providing `get_int64_t_le`, `get_int64_t_be`,
    `unsafe_get_int64_t_le`, and `unsafe_get_int64_t_be` functions that return
    local `Int64.t` values.

- New functions:
  * `unsafe_get`: retrieves character at specified position, without bounds checks
  * `unsafe_set`: sets character at specified position, without bounds checks
  * `memmem`: searches for the position of a substring of `needle` in a substring of
    `haystack` with optional parameters for positions and lengths; returns an `int option`
  * `unsafe_memmem`: unsafe version of `memmem` function, without bounds checks
