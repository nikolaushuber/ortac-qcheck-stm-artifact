OPAM := $(shell opam --version 2>/dev/null)

.PHONY: default
default:
	@echo "Please select one of the provided targets (install, test, doc)"


.PHONY: install_opam
install_opam:
ifndef OPAM
	sudo sh opam_install.sh; \
	opam init -a -c 4.14.2
else
	@echo "opam already installed"
endif

.PHONY: install
install: install_opam
	opam exec -- opam switch create . --empty
	opam exec -- opam install ocaml.4.14.2 --yes
	opam exec -- opam install zarith.1.12 --depext-only --yes
	opam exec -- opam install dune.3.16.0 --yes
	opam exec -- dune build
	opam exec -- dune install

.PHONY: clean
clean:
	rm -rf _opam
	rm -rf _build

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
	-opam exec -- hashtbl_spec_tests --seed 104275608 -v

.PHONY: test_varray
test_varray:
	-opam exec -- varray_spec_tests --seed 225655242 -v

.PHONY: test_array
test_array:
	opam exec -- array_spec_tests -v

.PHONY: test_stack
test_stack:
	opam exec -- stack_spec_tests -v

.PHONY: test_queue
test_queue:
	opam exec -- queue_spec_tests -v

.PHONY: test
test: test_bitv test_varray test_hashtbl test_array test_stack test_queue

.PHONY: doc
doc:
	open ./doc/_html/ortac-qcheck-stm/index.html
