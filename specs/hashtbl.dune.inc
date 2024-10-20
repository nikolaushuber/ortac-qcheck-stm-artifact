(rule
 (alias runtest)
 (deps
  (package ortac-qcheck-stm))
 (targets hashtbl_tests.ml)
 (action
  (setenv
   ORTAC_ONLY_PLUGIN
   qcheck-stm
   (with-stdout-to
    %{targets}
    (run
     ortac
     qcheck-stm
     %{dep:hashtbl.mli}
     %{dep:hashtbl_config.ml}
     --quiet)))))

(test
 (name hashtbl_tests)
 (modules hashtbl_tests)
 (libraries
  hashtbl
  qcheck-stm.stm
  qcheck-stm.sequential
  qcheck-multicoretests-util
  ortac-runtime-qcheck-stm)
 (action
  (run
   %{test}
   --verbose)))
