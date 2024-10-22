OPAM := $(shell opam --version 2>/dev/null)

.PHONY: install_opam
install_opam:
ifndef OPAM
	sudo sh opam_install.sh; \
	opam init
else
	@echo "opam already installed"
endif

_opam: install_opam
	opam switch create . --empty
	opam pin add varray varray-0.2 --kind=path -n
	opam pin add bitv bitv-2.0 --kind=path -n
	opam pin add ortac-core ortac-0.4.0 --kind=path -n
	opam pin add ortac-qcheck-stm ortac-0.4.0 --kind=path -n
	opam pin add ortac-runtime ortac-0.4.0 --kind=path -n
	opam pin add ortac-runtime-qcheck-stm ortac-0.4.0 --kind=path -n

.PHONY: install
install: _opam
	opam install ./artifact --locked --yes --with-doc

.PHONY: clean
clean:
	rm -rf _opam
	rm -rf _build
	rm -rf artifact/_build
	rm -rf ortac-0.4.0/_build

.PHONY: test_bitv
test_bitv:
	# fill error
	-ORTAC_QCHECK_STM_TIMEOUT=10 opam exec -- bitv_spec_tests --seed 471816848 -v
	# blit error
	-ORTAC_QCHECK_STM_TIMEOUT=10 opam exec -- bitv_spec_tests --seed 310367480 -v
	# sub error
	-ORTAC_QCHECK_STM_TIMEOUT=10 opam exec -- bitv_spec_tests --seed 14879557 -v
	# rotater error
	-opam exec -- bitv_spec_tests --seed 348758904 -v
	# rotatel error
	-opam exec -- bitv_spec_tests --seed 180807660 -v

.PHONY: test_hashtbl
test_hashtbl:
	opam exec -- hashtbl_tests --seed 104275608 -v

.PHONY: test_varray
test_varray:
	opam exec -- varray_spec_tests --seed 225655242 -v

.PHONY: test
test: test_bitv test_varray test_hashtbl

.PHONY: doc
doc:
	open ./doc/_html/ortac-qcheck-stm/index.html
