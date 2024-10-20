(rule
 (alias runtest)
 (deps
  (package ortac-qcheck-stm))
 (targets varray_spec_tests.ml)
 (action
  (setenv
   ORTAC_ONLY_PLUGIN
   qcheck-stm
   (with-stdout-to
    %{targets}
    (run
     ortac
     qcheck-stm
     %{dep:varray_spec.mli}
     %{dep:varray_spec_config.ml}
     --quiet)))))

(test
 (name varray_spec_tests)
 (modules varray_spec_tests)
 (libraries
  varray_spec
  qcheck-stm.stm
  qcheck-stm.sequential
  qcheck-multicoretests-util
  ortac-runtime-qcheck-stm)
 (action
  (run
   %{test}
   --verbose)))
