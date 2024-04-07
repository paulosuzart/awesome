all: shell/build.sh
	cd src_ext && $(MAKE)
	sh -ex shell/build.sh

shell/build.sh: shell/build.ml
	ocaml $< byte > $@
	chmod a+x $@

clean:
	rm -f opam-depext shell/build.sh *.cmi *.cma *.cmo *.cmx
	cd src_ext && $(MAKE) clean

distclean:
	cd src_ext && $(MAKE) distclean

install:
	opam-installer --prefix=$(PREFIX)

distrib:
	cd src_ext && $(MAKE) archives
