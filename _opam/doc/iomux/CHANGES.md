## v0.3 (2023-03-10)

* Round timeouts up, not down in Poll.poll (spotted by @talex5)
* Properly guard negative indexes (spotted by @talex5)
* Use half the maximum fds for the leak test (@haesbaert)

## v0.2 (2023-02-27)

* Narrowed the type of Util.fd_of_unix (@reynir)
* Use older school uerror instead of caml_uerror (@reynir)
* Added c_standard to dune build flags (@reynir)
* Addded ppoll(2) discoverability and a mini compat layer (@haesbaert)
* Improved tests (@haesbaert)
* Re-added macos support (@haesbaert)

## v0.1 (2023-02-17)

* Initial release
