SHELL=sh
FETCH=curl -OL
OCAML=ocaml
OCAMLC=ocamlc
OCAMLOPT=ocamlopt
SRC_EXTS = cmdliner 

URL_cmdliner = http://erratique.ch/software/cmdliner/releases/cmdliner-0.9.8.tbz
MD5_cmdliner = fc67c937447cc223722f1419fa2189da

ARCHIVES = $(foreach lib,$(SRC_EXTS),$(notdir $(URL_$(lib))))
lib_of = $(foreach lib,$(SRC_EXTS),$(if $(findstring $(1),$(URL_$(lib))),$(lib),,))

# Portable md5check
MD5CHECK = $(OCAML) ../shell/md5check.ml

lib-ext: clone build copy
	@

build: clone
	[ $(OCAMLC) = no ] || $(MAKE) -f $(OCAMLMAKEFILE) subprojs SUBTARGET=bcl
	[ $(OCAMLOPT) = no ] || $(MAKE) -f $(OCAMLMAKEFILE) subprojs SUBTARGET=ncl

all: bcl ncl

clone: $(SRC_EXTS:=.stamp)
ifneq ($(filter 4.%,$(shell $(OCAMLC) -vnum)),)
	@
else
	@mv cmdliner/src/cmdliner.ml cmdliner/src/t
	@echo 'module String = struct include String' > cmdliner/src/cmdliner.ml
	@echo '  let uppercase = uppercase_ascii' >> cmdliner/src/cmdliner.ml
	@echo '  let lowercase = lowercase_ascii' >> cmdliner/src/cmdliner.ml
	@echo '  let capitalize = capitalize_ascii' >> cmdliner/src/cmdliner.ml
	@echo 'end' >> cmdliner/src/cmdliner.ml
	@cat cmdliner/src/t >> cmdliner/src/cmdliner.ml
endif

archives: $(SRC_EXTS:=.download)
	@

define cache_url
https://opam.ocaml.org/2.0~dev/cache/md5/$(shell echo $(MD5_$(1)) | cut -c -2)/$(MD5_$(1))
endef

define get_from_cache
{ $(FETCH) $(call cache_url,$(1)) && \
  mv $(MD5_$(1)) $(notdir $(URL_$(1))) && \
  $(MD5CHECK) $(notdir $(URL_$(1))) $(MD5_$(1)); }
endef

%.download:
	[ -e  $(notdir $(URL_$*)) ] || \
	$(FETCH) $(URL_$*) && $(MD5CHECK) $(notdir $(URL_$*)) $(MD5_$*) || \
	$(call get_from_cache,$*)

%.stamp: %.download
	mkdir -p tmp
	cd tmp && $(if $(patsubst %.tar.gz,,$(URL_$*)),bunzip2,gunzip) -c ../$(notdir $(URL_$*)) | tar xf -
	rm -rf $*
	@for ii in tmp/*; do if [ -d $${ii} ]; then mv $${ii} $*; fi; done; \
	rm -rf tmp
	@if [ -d patches/$* ]; then \
          cd $* && \
	  for p in ../patches/$*/*.patch; do \
	    patch -p1 < $$p; \
	  done; \
        fi
	@touch $@

clean:
	rm -rf lib
	$(MAKE) -f $(OCAMLMAKEFILE) subprojs SUBTARGET=cleanup

distclean:
	rm -rf cmdliner
	rm -f *.tar.gz *.tbz *.stamp
	rm -f *.cm* *.o *.a *.lib
	rm -rf lib

LIB_EXTS = cmdliner

inst_objs = cp $(1)/*.cm*i lib

copy: build
	mkdir -p lib
	cp *.cma lib || true
	cp *.cmxa lib || true
	cp *.a lib || true
	cp *.lib lib || true
	$(call inst_objs,cmdliner/src)

# --

addmli = $(foreach ml,$(2),$(wildcard $(addsuffix .mli,$(basename $(1)/$(ml)))) $(1)/$(ml))

SRC_cmdliner = cmdliner.ml

define PROJ_cmdliner
  SOURCES = $(call addmli,cmdliner/src,$(SRC_cmdliner))
  RESULT = cmdliner
  LIB_PACK_NAME =
endef
export PROJ_cmdliner

# --

ifndef SUBROJS
  export SUBPROJS = $(LIB_EXTS)
endif


%:
	$(MAKE) -f $(OCAMLMAKEFILE) subprojs SUBTARGET=$@

OCAMLMAKEFILE = ../OCamlMakefile
export OCAMLMAKEFILE
