.PHONY: install_opam
install_opam:
	echo "Install opam"

.PHONY: install
install: install_opam
	eval $(opam env)
	opam switch create . --empty
	opam pin add varray varray-0.2 --kind=path -n
	opam pin add bitv bitv-2.0 --kind=path -n
	opam pin add ortac-core ortac-0.4.0 --kind=path -n
	opam pin add ortac-qcheck-stm ortac-0.4.0 --kind=path -n
	opam pin add ortac-runtime ortac-0.4.0 --kind=path -n
	opam pin add ortac-runtime-qcheck-stm ortac-0.4.0 --kind=path -n
	dune build

.PHONY: clean
clean:
	rm -rf _opam
	rm -rf _build

.PHONY: test_bitv
test_bitv:
	@eval $(opam env)
	# fill error
	-ORTAC_QCHECK_STM_TIMEOUT=10 dune exec -- specs/bitv_spec_tests.exe --seed 471816848 -v
	# blit error
	-ORTAC_QCHECK_STM_TIMEOUT=10 dune exec -- specs/bitv_spec_tests.exe --seed 310367480 -v
	# sub error
	-ORTAC_QCHECK_STM_TIMEOUT=10 dune exec -- specs/bitv_spec_tests.exe --seed 14879557 -v
	# rotater error
	-dune exec -- specs/bitv_spec_tests.exe --seed 348758904 -v
	# rotatel error
	-dune exec -- specs/bitv_spec_tests.exe --seed 180807660 -v

.PHONY: test_hashtbl
test_hashtbl:
	@eval $(opam env)
	dune exec -- specs/hashtbl_tests.exe --seed 104275608 -v

.PHONY: test_varray
test_varray:
	@eval $(opam env)
	dune exec -- specs/varray_spec_tests.exe --seed 225655242 -v
