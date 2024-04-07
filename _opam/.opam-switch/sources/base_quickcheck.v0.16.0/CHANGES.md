## Release v0.16.0

- Add new geometric distributions for integer types to `Generator`:
  * All functions take a minimum value and a probability `p` as parameters, producing a
    geometric distribution
  * Raise an error if `p <. 0. || 1. <. p`

- Add `string_like` function to `Generator`:
  * Produces strings similar to a given input with some number of edits
