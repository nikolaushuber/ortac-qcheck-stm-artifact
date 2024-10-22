; This file is generated by ortac dune qcheck-stm
; It contains the rules for generating and running QCheck-STM tests for varray_circular_spec.mli

(rule
 (alias runtest)
 (mode promote)
 (package ortac-examples)
 (deps
  (package ortac-qcheck-stm))
 (targets varray_circular_spec_tests.ml)
 (action
  (setenv
   ORTAC_ONLY_PLUGIN
   qcheck-stm
   (with-stdout-to
    %{targets}
    (run
     ortac
     qcheck-stm
     %{dep:varray_circular_spec.mli}
     %{dep:varray_circular_spec_config.ml}
     --quiet)))))

(test
 (name varray_circular_spec_tests)
 (modules varray_circular_spec_tests)
 (libraries
  varray_circular_spec
  qcheck-stm.stm
  qcheck-stm.sequential
  qcheck-multicoretests-util
  ortac-runtime-qcheck-stm)
 (package ortac-examples)
 (action
  (run
   %{test}
   --verbose)))