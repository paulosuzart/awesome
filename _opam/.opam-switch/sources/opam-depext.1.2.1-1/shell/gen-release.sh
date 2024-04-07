#!/bin/sh -ex
# Generate a release of a particular tag of opam-depext with
# the vendor tarballs included.

v=$1
shift
tag=$1
shift

if [ "$tag" = "" ]; then
  echo Usage: $0 version tag
  exit 1
fi

git archive --format=tar --prefix=opam-depext-$v/ $tag > ../opam-depext-$v.tar 
cd ..
tar -xvf opam-depext-$v.tar
cd opam-depext-$v
make distrib
cd ..
tar -jcvf opam-depext-full-$v.tbz opam-depext-$v
rm -f opam-depext-$v.tar
