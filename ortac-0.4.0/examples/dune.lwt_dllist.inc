; This file is generated by ortac dune qcheck-stm
; It contains the rules for generating and running QCheck-STM tests for lwt_dllist_spec.mli

(rule
 (alias runtest)
 (mode promote)
 (package ortac-examples)
 (deps
  (package ortac-qcheck-stm))
 (targets lwt_dllist_spec_tests.ml)
 (action
  (setenv
   ORTAC_ONLY_PLUGIN
   qcheck-stm
   (with-stdout-to
    %{targets}
    (run
     ortac
     qcheck-stm
     %{dep:lwt_dllist_spec.mli}
     %{dep:lwt_dllist_spec_config.ml}
     --quiet)))))

(test
 (name lwt_dllist_spec_tests)
 (modules lwt_dllist_spec_tests)
 (libraries
  lwt_dllist_spec
  qcheck-stm.stm
  qcheck-stm.sequential
  qcheck-multicoretests-util
  ortac-runtime-qcheck-stm)
 (package ortac-examples)
 (action
  (run
   %{test}
   --verbose)))