(rule
 (alias runtest)
 (deps
  (package ortac-qcheck-stm))
 (targets bitv_spec_tests.ml)
 (action
  (setenv
   ORTAC_ONLY_PLUGIN
   qcheck-stm
   (with-stdout-to
    %{targets}
    (run
     ortac
     qcheck-stm
     %{dep:bitv_spec.mli}
     %{dep:bitv_spec_config.ml}
     --quiet)))))

(test
 (name bitv_spec_tests)
 (modules bitv_spec_tests)
 (libraries
  bitv_spec
  qcheck-stm.stm
  qcheck-stm.sequential
  qcheck-multicoretests-util
  ortac-runtime-qcheck-stm)
 (action
  (setenv
   ORTAC_QCHECK_STM_TIMEOUT
   10
   (run
    %{test}
    --verbose))))
