Frozen Repository
=================

**opam-depext is being integrated into opam. Please refer to this [opam
issue](https://github.com/ocaml/opam/issues/3790) if you want to request
changes.**


OPAM depext plugin
==================

Replacement for the currently used shell-scripts handling distribution-specific
installation of OPAM packages' external dependencies (as per the `depexts` field
in their definitions).

Currently supported depexts are:

| Depext                 | Online package list                                     |
|------------------------|---------------------------------------------------------|
| `alpine` `linux`       | https://pkgs.alpinelinux.org                            |
| `archlinux` `linux`    | https://www.archlinux.org/packages/                     |
| `centos` `linux`       | https://pkgs.org/                                       |
| `debian` `linux`       | https://www.debian.org/distrib/packages#search_packages |
| `dragonfly`            |                                                         |
| `fedora` `linux`       | https://apps.fedoraproject.org/packages/                |
| `freebsd`              | https://www.freebsd.org/ports/index.html                |
| `gentoo`               | https://packages.gentoo.org/                            |
| `homebrew` `osx`       | http://braumeister.org/                                 |
| `macports` `osx`       | https://www.macports.org/ports.php                      |
| `mageia` `linux`       | https://pkgs.org/                                       |
| `netbsd`               | http://pkgsrc.se/                                       |
| `openbsd`              | http://openports.se/                                    |
| `opensuse` `linux`     | https://pkgs.org/                                       |
| `oraclelinux` `linux`  |                                                         |
| `rhel` `linux`         |                                                         |
| `ubuntu` `linux`       | https://packages.ubuntu.com/                            |
| `win32` `cygwin`       |                                                         |
 
This version runs as an OPAM plugin; it may help pave the way to some
specification of the `depexts` field and give some basis for a real
plugin integrating with OPAM (see
https://github.com/ocaml/opam/blob/master/doc/design/depexts-plugins)

Questions: email <opam-devel@lists.ocaml.org>
