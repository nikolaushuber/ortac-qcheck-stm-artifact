(* This file is generated by ortac qcheck-stm,
   edit how you run the tool instead *)
[@@@ocaml.warning "-26-27-69-32-38"]
open Test_cleanup
module Ortac_runtime = Ortac_runtime_qcheck_stm
module SUT =
  (Ortac_runtime.SUT.Make)(struct type sut = t
                                  let init () = create () end)
module ModelElt =
  struct
    type nonrec elt = {
      m: Ortac_runtime.integer }
    let init =
      let () = () in
      {
        m =
          (try Ortac_runtime.Gospelstdlib.integer_of_int 0
           with
           | e ->
               raise
                 (Ortac_runtime.Partial_function
                    (e,
                      {
                        Ortac_runtime.start =
                          {
                            pos_fname = "test_cleanup.mli";
                            pos_lnum = 6;
                            pos_bol = 227;
                            pos_cnum = 245
                          };
                        Ortac_runtime.stop =
                          {
                            pos_fname = "test_cleanup.mli";
                            pos_lnum = 6;
                            pos_bol = 227;
                            pos_cnum = 246
                          }
                      })))
      }
  end
module Model = (Ortac_runtime.Model.Make)(ModelElt)
module Spec =
  struct
    open STM
    type _ ty +=  
      | Integer: Ortac_runtime.integer ty 
    let integer = (Integer, Ortac_runtime.string_of_integer)
    type _ ty +=  
      | SUT: SUT.elt ty 
    let sut = (SUT, (fun _ -> "<sut>"))
    type sut = SUT.t
    let init_sut = SUT.create 1
    type state = Model.t
    let init_state = Model.create 1 ()
    type cmd =
      | Create of unit 
      | Use 
    let show_cmd cmd__001_ =
      match cmd__001_ with
      | Create () ->
          Format.asprintf "%s %a" "create" (Util.Pp.pp_unit true) ()
      | Use -> Format.asprintf "%s <sut>" "use"
    let cleanup t = ignore t
    let arb_cmd _ =
      let open QCheck in
        make ~print:show_cmd
          (let open Gen in
             oneof [(pure (fun () -> Create ())) <*> unit; pure Use])
    let next_state cmd__002_ state__003_ =
      match cmd__002_ with
      | Create () ->
          let t_1__005_ =
            let open ModelElt in
              {
                m =
                  (try Ortac_runtime.Gospelstdlib.integer_of_int 0
                   with
                   | e ->
                       raise
                         (Ortac_runtime.Partial_function
                            (e,
                              {
                                Ortac_runtime.start =
                                  {
                                    pos_fname = "test_cleanup.mli";
                                    pos_lnum = 6;
                                    pos_bol = 227;
                                    pos_cnum = 245
                                  };
                                Ortac_runtime.stop =
                                  {
                                    pos_fname = "test_cleanup.mli";
                                    pos_lnum = 6;
                                    pos_bol = 227;
                                    pos_cnum = 246
                                  }
                              })))
              } in
          Model.push (Model.drop_n state__003_ 0) t_1__005_
      | Use ->
          let t_2__006_ = Model.get state__003_ 0 in
          let t_2__007_ =
            let open ModelElt in
              {
                m =
                  (try
                     Ortac_runtime.Gospelstdlib.(+)
                       (Ortac_runtime.Gospelstdlib.integer_of_int 1)
                       t_2__006_.m
                   with
                   | e ->
                       raise
                         (Ortac_runtime.Partial_function
                            (e,
                              {
                                Ortac_runtime.start =
                                  {
                                    pos_fname = "test_cleanup.mli";
                                    pos_lnum = 11;
                                    pos_bol = 377;
                                    pos_cnum = 397
                                  };
                                Ortac_runtime.stop =
                                  {
                                    pos_fname = "test_cleanup.mli";
                                    pos_lnum = 11;
                                    pos_bol = 377;
                                    pos_cnum = 398
                                  }
                              })))
              } in
          Model.push (Model.drop_n state__003_ 1) t_2__007_
    let precond cmd__013_ state__014_ =
      match cmd__013_ with
      | Create () -> true
      | Use -> let t_2__015_ = Model.get state__014_ 0 in true
    let postcond _ _ _ = true
    let run cmd__016_ sut__017_ =
      match cmd__016_ with
      | Create () ->
          Res
            (sut,
              (let res__018_ = create () in
               (SUT.push sut__017_ res__018_; res__018_)))
      | Use ->
          Res
            (unit,
              (let t_2__019_ = SUT.pop sut__017_ in
               let res__020_ = use t_2__019_ in
               (SUT.push sut__017_ t_2__019_; res__020_)))
  end
module STMTests = (Ortac_runtime.Make)(Spec)
let check_init_state () = ()
let ortac_show_cmd cmd__022_ state__023_ last__025_ res__024_ =
  let open Spec in
    let open STM in
      match (cmd__022_, res__024_) with
      | (Create (), Res ((SUT, _), t_1)) ->
          let lhs = if last__025_ then "r" else SUT.get_name state__023_ 0
          and shift = 1 in
          Format.asprintf "let %s = %s %a" lhs "create"
            (Util.Pp.pp_unit true) ()
      | (Use, Res ((Unit, _), _)) ->
          let lhs = if last__025_ then "r" else "_"
          and shift = 0 in
          Format.asprintf "let %s = %s %s" lhs "use"
            (SUT.get_name state__023_ (0 + shift))
      | _ -> assert false
let ortac_postcond cmd__008_ state__009_ res__010_ =
  let open Spec in
    let open STM in
      let new_state__011_ = lazy (next_state cmd__008_ state__009_) in
      match (cmd__008_, res__010_) with
      | (Create (), Res ((SUT, _), t_1)) -> None
      | (Use, Res ((Unit, _), _)) -> None
      | _ -> None
let _ =
  QCheck_base_runner.run_tests_main
    (let count = 1000 in
     [STMTests.agree_test ~count ~name:"Test_cleanup STM tests" 1
        check_init_state ortac_show_cmd ortac_postcond])
