FROM ocaml/opam:debian-11-ocaml-5.1
# Make sure we're using opam-2.1:
RUN sudo ln -sf /usr/bin/opam-2.1 /usr/bin/opam
# Ensure opam-repository is up-to-date:
RUN cd opam-repository && git pull -q origin 0ac3fc79fd11ee365dd46119d43e9763cf57da52 && opam update
# Install utop for interactive use:
RUN opam install utop fmt
# Install Eio's dependencies (adding just the opam files first to help with caching):
RUN mkdir eio
WORKDIR eio
COPY *.opam ./
RUN opam pin --with-version=dev . -yn
RUN opam install --deps-only eio_main eio_linux eio
# Build Eio:
COPY . ./
RUN opam install eio_main
