## Release v0.16.0

- Several new expression forms are supported to derive the individual
values defined by `ppx_bin_prot`.
  * `[%bin_shape: t]`
  * `[%bin_digest: t]`
  * `[%bin_size: t]`
  * `[%bin_write: t]`
  * `[%bin_read: t]`
  * `[%bin_writer: t]`
  * `[%bin_reader: t]`
  * `[%bin_type_class: t]`

## Old pre-v0.15 changelogs (very likely stale and incomplete)

## v0.11

Depend on ppxlib instead of (now deprecated) ppx\_core, ppx\_driver and
ppx\_type\_conv.

## 113.43.00

- use the new context-free API

## 113.24.01

- Fix the META. ppx\_bin\_prot was not previously treated as a
  ppx\_deriving plugin, which was causing problems

## 113.24.00

- Minor changes, nothing worth mentionning.
