(* This file is generated by ortac qcheck-stm,
   edit how you run the tool instead *)
[@@@ocaml.warning "-26-27-69-32-38"]
open Hashtbl
module Ortac_runtime = Ortac_runtime_qcheck_stm
let rec remove_first x xs_1 =
  try
    match xs_1 with
    | (a_1, b_1)::xs ->
        if a_1 = x then xs else (a_1, b_1) :: (remove_first x xs)
    | [] -> []
  with
  | e ->
      raise
        (Ortac_runtime.Partial_function
           (e,
             {
               Ortac_runtime.start =
                 {
                   pos_fname = "hashtbl.mli";
                   pos_lnum = 49;
                   pos_bol = 2390;
                   pos_cnum = 2396
                 };
               Ortac_runtime.stop =
                 {
                   pos_fname = "hashtbl.mli";
                   pos_lnum = 51;
                   pos_bol = 2486;
                   pos_cnum = 2502
                 }
             }))
module SUT =
  (Ortac_runtime.SUT.Make)(struct
                             type sut = (char, int) t
                             let init () = create ~random:false 16
                           end)
module ModelElt =
  struct
    type nonrec elt = {
      contents: (char * int) list }
    let init =
      let random = false
      and size = 16 in
      {
        contents =
          (try []
           with
           | e ->
               raise
                 (Ortac_runtime.Partial_function
                    (e,
                      {
                        Ortac_runtime.start =
                          {
                            pos_fname = "hashtbl.mli";
                            pos_lnum = 7;
                            pos_bol = 318;
                            pos_cnum = 343
                          };
                        Ortac_runtime.stop =
                          {
                            pos_fname = "hashtbl.mli";
                            pos_lnum = 7;
                            pos_bol = 318;
                            pos_cnum = 345
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
      | Create of bool * int 
      | Clear 
      | Reset 
      | Copy 
      | Add of char * int 
      | Find of char 
      | Find_opt of char 
      | Find_all of char 
      | Mem of char 
      | Remove of char 
      | Replace of char * int 
      | Length 
    let show_cmd cmd__001_ =
      match cmd__001_ with
      | Create (random, size) ->
          Format.asprintf "%s %a %a" "create" (Util.Pp.pp_bool true) random
            (Util.Pp.pp_int true) size
      | Clear -> Format.asprintf "%s <sut>" "clear"
      | Reset -> Format.asprintf "%s <sut>" "reset"
      | Copy -> Format.asprintf "%s <sut>" "copy"
      | Add (a_2, b_2) ->
          Format.asprintf "%s <sut> %a %a" "add" (Util.Pp.pp_char true) a_2
            (Util.Pp.pp_int true) b_2
      | Find a_3 ->
          Format.asprintf "protect (fun () -> %s <sut> %a)" "find"
            (Util.Pp.pp_char true) a_3
      | Find_opt a_4 ->
          Format.asprintf "%s <sut> %a" "find_opt" (Util.Pp.pp_char true) a_4
      | Find_all a_5 ->
          Format.asprintf "%s <sut> %a" "find_all" (Util.Pp.pp_char true) a_5
      | Mem a_6 ->
          Format.asprintf "%s <sut> %a" "mem" (Util.Pp.pp_char true) a_6
      | Remove a_7 ->
          Format.asprintf "%s <sut> %a" "remove" (Util.Pp.pp_char true) a_7
      | Replace (a_8, b_3) ->
          Format.asprintf "%s <sut> %a %a" "replace" (Util.Pp.pp_char true)
            a_8 (Util.Pp.pp_int true) b_3
      | Length -> Format.asprintf "%s <sut>" "length"
    let cleanup _ = ()
    let arb_cmd _ =
      let open QCheck in
        make ~print:show_cmd
          (let open Gen in
             oneof
               [((pure (fun random -> fun size -> Create (random, size))) <*>
                   bool)
                  <*> small_signed_int;
               pure Clear;
               pure Reset;
               pure Copy;
               ((pure (fun a_2 -> fun b_2 -> Add (a_2, b_2))) <*> char) <*>
                 int;
               (pure (fun a_3 -> Find a_3)) <*> char;
               (pure (fun a_4 -> Find_opt a_4)) <*> char;
               (pure (fun a_5 -> Find_all a_5)) <*> char;
               (pure (fun a_6 -> Mem a_6)) <*> char;
               (pure (fun a_7 -> Remove a_7)) <*> char;
               ((pure (fun a_8 -> fun b_3 -> Replace (a_8, b_3))) <*> char)
                 <*> int;
               pure Length])
    let next_state cmd__002_ state__003_ =
      match cmd__002_ with
      | Create (random, size) ->
          let h__005_ =
            let open ModelElt in
              {
                contents =
                  (try []
                   with
                   | e ->
                       raise
                         (Ortac_runtime.Partial_function
                            (e,
                              {
                                Ortac_runtime.start =
                                  {
                                    pos_fname = "hashtbl.mli";
                                    pos_lnum = 7;
                                    pos_bol = 318;
                                    pos_cnum = 343
                                  };
                                Ortac_runtime.stop =
                                  {
                                    pos_fname = "hashtbl.mli";
                                    pos_lnum = 7;
                                    pos_bol = 318;
                                    pos_cnum = 345
                                  }
                              })))
              } in
          Model.push (Model.drop_n state__003_ 0) h__005_
      | Clear ->
          let h_1__006_ = Model.get state__003_ 0 in
          let h_1__007_ =
            let open ModelElt in
              {
                contents =
                  (try []
                   with
                   | e ->
                       raise
                         (Ortac_runtime.Partial_function
                            (e,
                              {
                                Ortac_runtime.start =
                                  {
                                    pos_fname = "hashtbl.mli";
                                    pos_lnum = 12;
                                    pos_bol = 486;
                                    pos_cnum = 511
                                  };
                                Ortac_runtime.stop =
                                  {
                                    pos_fname = "hashtbl.mli";
                                    pos_lnum = 12;
                                    pos_bol = 486;
                                    pos_cnum = 513
                                  }
                              })))
              } in
          Model.push (Model.drop_n state__003_ 1) h_1__007_
      | Reset ->
          let h_2__008_ = Model.get state__003_ 0 in
          let h_2__009_ =
            let open ModelElt in
              {
                contents =
                  (try []
                   with
                   | e ->
                       raise
                         (Ortac_runtime.Partial_function
                            (e,
                              {
                                Ortac_runtime.start =
                                  {
                                    pos_fname = "hashtbl.mli";
                                    pos_lnum = 17;
                                    pos_bol = 655;
                                    pos_cnum = 680
                                  };
                                Ortac_runtime.stop =
                                  {
                                    pos_fname = "hashtbl.mli";
                                    pos_lnum = 17;
                                    pos_bol = 655;
                                    pos_cnum = 682
                                  }
                              })))
              } in
          Model.push (Model.drop_n state__003_ 1) h_2__009_
      | Copy ->
          let h1__010_ = Model.get state__003_ 0 in
          let h2__013_ =
            let open ModelElt in
              {
                contents =
                  (try h1__010_.contents
                   with
                   | e ->
                       raise
                         (Ortac_runtime.Partial_function
                            (e,
                              {
                                Ortac_runtime.start =
                                  {
                                    pos_fname = "hashtbl.mli";
                                    pos_lnum = 21;
                                    pos_bol = 819;
                                    pos_cnum = 845
                                  };
                                Ortac_runtime.stop =
                                  {
                                    pos_fname = "hashtbl.mli";
                                    pos_lnum = 21;
                                    pos_bol = 819;
                                    pos_cnum = 856
                                  }
                              })))
              }
          and h1__012_ = h1__010_ in
          Model.push (Model.push (Model.drop_n state__003_ 1) h1__012_)
            h2__013_
      | Add (a_2, b_2) ->
          let h_3__014_ = Model.get state__003_ 0 in
          let h_3__015_ =
            let open ModelElt in
              {
                contents =
                  (try (a_2, b_2) :: h_3__014_.contents
                   with
                   | e ->
                       raise
                         (Ortac_runtime.Partial_function
                            (e,
                              {
                                Ortac_runtime.start =
                                  {
                                    pos_fname = "hashtbl.mli";
                                    pos_lnum = 26;
                                    pos_bol = 1020;
                                    pos_cnum = 1045
                                  };
                                Ortac_runtime.stop =
                                  {
                                    pos_fname = "hashtbl.mli";
                                    pos_lnum = 26;
                                    pos_bol = 1020;
                                    pos_cnum = 1069
                                  }
                              })))
              } in
          Model.push (Model.drop_n state__003_ 1) h_3__015_
      | Find a_3 ->
          let h_4__016_ = Model.get state__003_ 0 in
          let h_4__017_ = h_4__016_ in
          Model.push (Model.drop_n state__003_ 1) h_4__017_
      | Find_opt a_4 ->
          let h_5__018_ = Model.get state__003_ 0 in
          let h_5__019_ = h_5__018_ in
          Model.push (Model.drop_n state__003_ 1) h_5__019_
      | Find_all a_5 ->
          let h_6__020_ = Model.get state__003_ 0 in
          let h_6__021_ = h_6__020_ in
          Model.push (Model.drop_n state__003_ 1) h_6__021_
      | Mem a_6 ->
          let h_7__022_ = Model.get state__003_ 0 in
          let h_7__023_ = h_7__022_ in
          Model.push (Model.drop_n state__003_ 1) h_7__023_
      | Remove a_7 ->
          let h_8__024_ = Model.get state__003_ 0 in
          let h_8__025_ =
            let open ModelElt in
              {
                contents =
                  (try remove_first a_7 h_8__024_.contents
                   with
                   | e ->
                       raise
                         (Ortac_runtime.Partial_function
                            (e,
                              {
                                Ortac_runtime.start =
                                  {
                                    pos_fname = "hashtbl.mli";
                                    pos_lnum = 56;
                                    pos_bol = 2643;
                                    pos_cnum = 2668
                                  };
                                Ortac_runtime.stop =
                                  {
                                    pos_fname = "hashtbl.mli";
                                    pos_lnum = 56;
                                    pos_bol = 2643;
                                    pos_cnum = 2680
                                  }
                              })))
              } in
          Model.push (Model.drop_n state__003_ 1) h_8__025_
      | Replace (a_8, b_3) ->
          let h_9__026_ = Model.get state__003_ 0 in
          let h_9__027_ =
            let open ModelElt in
              {
                contents =
                  (try (a_8, b_3) :: (remove_first a_8 h_9__026_.contents)
                   with
                   | e ->
                       raise
                         (Ortac_runtime.Partial_function
                            (e,
                              {
                                Ortac_runtime.start =
                                  {
                                    pos_fname = "hashtbl.mli";
                                    pos_lnum = 61;
                                    pos_bol = 2890;
                                    pos_cnum = 2915
                                  };
                                Ortac_runtime.stop =
                                  {
                                    pos_fname = "hashtbl.mli";
                                    pos_lnum = 61;
                                    pos_bol = 2890;
                                    pos_cnum = 2956
                                  }
                              })))
              } in
          Model.push (Model.drop_n state__003_ 1) h_9__027_
      | Length ->
          let h_10__028_ = Model.get state__003_ 0 in
          let h_10__029_ = h_10__028_ in
          Model.push (Model.drop_n state__003_ 1) h_10__029_
    let precond cmd__061_ state__062_ =
      match cmd__061_ with
      | Create (random, size) -> true
      | Clear -> let h_1__063_ = Model.get state__062_ 0 in true
      | Reset -> let h_2__064_ = Model.get state__062_ 0 in true
      | Copy -> let h1__065_ = Model.get state__062_ 0 in true
      | Add (a_2, b_2) -> let h_3__066_ = Model.get state__062_ 0 in true
      | Find a_3 -> let h_4__067_ = Model.get state__062_ 0 in true
      | Find_opt a_4 -> let h_5__068_ = Model.get state__062_ 0 in true
      | Find_all a_5 -> let h_6__069_ = Model.get state__062_ 0 in true
      | Mem a_6 -> let h_7__070_ = Model.get state__062_ 0 in true
      | Remove a_7 -> let h_8__071_ = Model.get state__062_ 0 in true
      | Replace (a_8, b_3) -> let h_9__072_ = Model.get state__062_ 0 in true
      | Length -> let h_10__073_ = Model.get state__062_ 0 in true
    let postcond _ _ _ = true
    let run cmd__074_ sut__075_ =
      match cmd__074_ with
      | Create (random, size) ->
          Res
            (sut,
              (let res__076_ = create ~random size in
               (SUT.push sut__075_ res__076_; res__076_)))
      | Clear ->
          Res
            (unit,
              (let h_1__077_ = SUT.pop sut__075_ in
               let res__078_ = clear h_1__077_ in
               (SUT.push sut__075_ h_1__077_; res__078_)))
      | Reset ->
          Res
            (unit,
              (let h_2__079_ = SUT.pop sut__075_ in
               let res__080_ = reset h_2__079_ in
               (SUT.push sut__075_ h_2__079_; res__080_)))
      | Copy ->
          Res
            (sut,
              (let h1__081_ = SUT.pop sut__075_ in
               let res__082_ = copy h1__081_ in
               (SUT.push sut__075_ h1__081_;
                SUT.push sut__075_ res__082_;
                res__082_)))
      | Add (a_2, b_2) ->
          Res
            (unit,
              (let h_3__083_ = SUT.pop sut__075_ in
               let res__084_ = add h_3__083_ a_2 b_2 in
               (SUT.push sut__075_ h_3__083_; res__084_)))
      | Find a_3 ->
          Res
            ((result int exn),
              (let h_4__085_ = SUT.pop sut__075_ in
               let res__086_ = protect (fun () -> find h_4__085_ a_3) () in
               (SUT.push sut__075_ h_4__085_; res__086_)))
      | Find_opt a_4 ->
          Res
            ((option int),
              (let h_5__087_ = SUT.pop sut__075_ in
               let res__088_ = find_opt h_5__087_ a_4 in
               (SUT.push sut__075_ h_5__087_; res__088_)))
      | Find_all a_5 ->
          Res
            ((list int),
              (let h_6__089_ = SUT.pop sut__075_ in
               let res__090_ = find_all h_6__089_ a_5 in
               (SUT.push sut__075_ h_6__089_; res__090_)))
      | Mem a_6 ->
          Res
            (bool,
              (let h_7__091_ = SUT.pop sut__075_ in
               let res__092_ = mem h_7__091_ a_6 in
               (SUT.push sut__075_ h_7__091_; res__092_)))
      | Remove a_7 ->
          Res
            (unit,
              (let h_8__093_ = SUT.pop sut__075_ in
               let res__094_ = remove h_8__093_ a_7 in
               (SUT.push sut__075_ h_8__093_; res__094_)))
      | Replace (a_8, b_3) ->
          Res
            (unit,
              (let h_9__095_ = SUT.pop sut__075_ in
               let res__096_ = replace h_9__095_ a_8 b_3 in
               (SUT.push sut__075_ h_9__095_; res__096_)))
      | Length ->
          Res
            (int,
              (let h_10__097_ = SUT.pop sut__075_ in
               let res__098_ = length h_10__097_ in
               (SUT.push sut__075_ h_10__097_; res__098_)))
  end
module STMTests = (Ortac_runtime.Make)(Spec)
let check_init_state () = ()
let ortac_show_cmd cmd__100_ state__101_ last__103_ res__102_ =
  let open Spec in
    let open STM in
      match (cmd__100_, res__102_) with
      | (Create (random, size), Res ((SUT, _), h)) ->
          let lhs = if last__103_ then "r" else SUT.get_name state__101_ 0
          and shift = 1 in
          Format.asprintf "let %s = %s %a %a" lhs "create"
            (Util.Pp.pp_bool true) random (Util.Pp.pp_int true) size
      | (Clear, Res ((Unit, _), _)) ->
          let lhs = if last__103_ then "r" else "_"
          and shift = 0 in
          Format.asprintf "let %s = %s %s" lhs "clear"
            (SUT.get_name state__101_ (0 + shift))
      | (Reset, Res ((Unit, _), _)) ->
          let lhs = if last__103_ then "r" else "_"
          and shift = 0 in
          Format.asprintf "let %s = %s %s" lhs "reset"
            (SUT.get_name state__101_ (0 + shift))
      | (Copy, Res ((SUT, _), h2)) ->
          let lhs = if last__103_ then "r" else SUT.get_name state__101_ 0
          and shift = 1 in
          Format.asprintf "let %s = %s %s" lhs "copy"
            (SUT.get_name state__101_ (0 + shift))
      | (Add (a_2, b_2), Res ((Unit, _), _)) ->
          let lhs = if last__103_ then "r" else "_"
          and shift = 0 in
          Format.asprintf "let %s = %s %s %a %a" lhs "add"
            (SUT.get_name state__101_ (0 + shift)) (Util.Pp.pp_char true) a_2
            (Util.Pp.pp_int true) b_2
      | (Find a_3, Res ((Result (Int, Exn), _), _)) ->
          let lhs = if last__103_ then "r" else "_"
          and shift = 0 in
          Format.asprintf "let %s = protect (fun () -> %s %s %a)" lhs "find"
            (SUT.get_name state__101_ (0 + shift)) (Util.Pp.pp_char true) a_3
      | (Find_opt a_4, Res ((Option (Int), _), _)) ->
          let lhs = if last__103_ then "r" else "_"
          and shift = 0 in
          Format.asprintf "let %s = %s %s %a" lhs "find_opt"
            (SUT.get_name state__101_ (0 + shift)) (Util.Pp.pp_char true) a_4
      | (Find_all a_5, Res ((List (Int), _), _)) ->
          let lhs = if last__103_ then "r" else "_"
          and shift = 0 in
          Format.asprintf "let %s = %s %s %a" lhs "find_all"
            (SUT.get_name state__101_ (0 + shift)) (Util.Pp.pp_char true) a_5
      | (Mem a_6, Res ((Bool, _), _)) ->
          let lhs = if last__103_ then "r" else "_"
          and shift = 0 in
          Format.asprintf "let %s = %s %s %a" lhs "mem"
            (SUT.get_name state__101_ (0 + shift)) (Util.Pp.pp_char true) a_6
      | (Remove a_7, Res ((Unit, _), _)) ->
          let lhs = if last__103_ then "r" else "_"
          and shift = 0 in
          Format.asprintf "let %s = %s %s %a" lhs "remove"
            (SUT.get_name state__101_ (0 + shift)) (Util.Pp.pp_char true) a_7
      | (Replace (a_8, b_3), Res ((Unit, _), _)) ->
          let lhs = if last__103_ then "r" else "_"
          and shift = 0 in
          Format.asprintf "let %s = %s %s %a %a" lhs "replace"
            (SUT.get_name state__101_ (0 + shift)) (Util.Pp.pp_char true) a_8
            (Util.Pp.pp_int true) b_3
      | (Length, Res ((Int, _), _)) ->
          let lhs = if last__103_ then "r" else "_"
          and shift = 0 in
          Format.asprintf "let %s = %s %s" lhs "length"
            (SUT.get_name state__101_ (0 + shift))
      | _ -> assert false
let ortac_postcond cmd__030_ state__031_ res__032_ =
  let open Spec in
    let open STM in
      let new_state__033_ = lazy (next_state cmd__030_ state__031_) in
      match (cmd__030_, res__032_) with
      | (Create (random, size), Res ((SUT, _), h)) -> None
      | (Clear, Res ((Unit, _), _)) -> None
      | (Reset, Res ((Unit, _), _)) -> None
      | (Copy, Res ((SUT, _), h2)) -> None
      | (Add (a_2, b_2), Res ((Unit, _), _)) -> None
      | (Find a_3, Res ((Result (Int, Exn), _), b_4)) ->
          (match b_4 with
           | Ok b_4 ->
               if
                 let h_old__038_ = Model.get state__031_ 0
                 and h_new__039_ =
                   lazy (Model.get (Lazy.force new_state__033_) 0) in
                 (try
                    Ortac_runtime.Gospelstdlib.List.mem (a_3, b_4)
                      (Lazy.force h_new__039_).contents
                  with
                  | e ->
                      raise
                        (Ortac_runtime.Partial_function
                           (e,
                             {
                               Ortac_runtime.start =
                                 {
                                   pos_fname = "hashtbl.mli";
                                   pos_lnum = 32;
                                   pos_bol = 1360;
                                   pos_cnum = 1372
                                 };
                               Ortac_runtime.stop =
                                 {
                                   pos_fname = "hashtbl.mli";
                                   pos_lnum = 32;
                                   pos_bol = 1360;
                                   pos_cnum = 1398
                                 }
                             })))
               then None
               else
                 Some
                   (Ortac_runtime.report "Hashtbl" "create ~random:false 16"
                      (Ortac_runtime.Protected_value
                         (Res (Ortac_runtime.dummy, ()))) "find"
                      [("List.mem (a, b) h.contents",
                         {
                           Ortac_runtime.start =
                             {
                               pos_fname = "hashtbl.mli";
                               pos_lnum = 32;
                               pos_bol = 1360;
                               pos_cnum = 1372
                             };
                           Ortac_runtime.stop =
                             {
                               pos_fname = "hashtbl.mli";
                               pos_lnum = 32;
                               pos_bol = 1360;
                               pos_cnum = 1398
                             }
                         })])
           | Error (Not_found) ->
               if
                 let h_old__042_ = Model.get state__031_ 0
                 and h_new__043_ =
                   lazy (Model.get (Lazy.force new_state__033_) 0) in
                 (try
                    not
                      (Ortac_runtime.Gospelstdlib.List.mem a_3
                         (Ortac_runtime.Gospelstdlib.List.map
                            Ortac_runtime.Gospelstdlib.fst
                            (Lazy.force h_new__043_).contents))
                  with
                  | e ->
                      raise
                        (Ortac_runtime.Partial_function
                           (e,
                             {
                               Ortac_runtime.start =
                                 {
                                   pos_fname = "hashtbl.mli";
                                   pos_lnum = 31;
                                   pos_bol = 1293;
                                   pos_cnum = 1317
                                 };
                               Ortac_runtime.stop =
                                 {
                                   pos_fname = "hashtbl.mli";
                                   pos_lnum = 31;
                                   pos_bol = 1293;
                                   pos_cnum = 1359
                                 }
                             })))
               then None
               else
                 Some
                   (Ortac_runtime.report "Hashtbl" "create ~random:false 16"
                      (Ortac_runtime.Exception "Not_found") "find"
                      [("not (List.mem a (List.map fst h.contents))",
                         {
                           Ortac_runtime.start =
                             {
                               pos_fname = "hashtbl.mli";
                               pos_lnum = 31;
                               pos_bol = 1293;
                               pos_cnum = 1317
                             };
                           Ortac_runtime.stop =
                             {
                               pos_fname = "hashtbl.mli";
                               pos_lnum = 31;
                               pos_bol = 1293;
                               pos_cnum = 1359
                             }
                         })])
           | _ -> None)
      | (Find_opt a_4, Res ((Option (Int), _), o)) ->
          if
            let h_old__045_ = Model.get state__031_ 0
            and h_new__046_ = lazy (Model.get (Lazy.force new_state__033_) 0) in
            (try
               (match o with
                | None ->
                    if
                      not
                        (Ortac_runtime.Gospelstdlib.List.mem a_4
                           (Ortac_runtime.Gospelstdlib.List.map
                              Ortac_runtime.Gospelstdlib.fst
                              (Lazy.force h_new__046_).contents))
                    then true
                    else false
                | Some b_5 ->
                    if
                      Ortac_runtime.Gospelstdlib.List.mem (a_4, b_5)
                        (Lazy.force h_new__046_).contents
                    then true
                    else false)
                 = true
             with
             | e ->
                 raise
                   (Ortac_runtime.Partial_function
                      (e,
                        {
                          Ortac_runtime.start =
                            {
                              pos_fname = "hashtbl.mli";
                              pos_lnum = 36;
                              pos_bol = 1559;
                              pos_cnum = 1571
                            };
                          Ortac_runtime.stop =
                            {
                              pos_fname = "hashtbl.mli";
                              pos_lnum = 38;
                              pos_bol = 1643;
                              pos_cnum = 1687
                            }
                        })))
          then None
          else
            Some
              (Ortac_runtime.report "Hashtbl" "create ~random:false 16"
                 (Ortac_runtime.Value (Res (Ortac_runtime.dummy, ())))
                 "find_opt"
                 [("match o with\n      | None -> not (List.mem a (List.map fst h.contents))\n      | Some b -> List.mem (a, b) h.contents",
                    {
                      Ortac_runtime.start =
                        {
                          pos_fname = "hashtbl.mli";
                          pos_lnum = 36;
                          pos_bol = 1559;
                          pos_cnum = 1571
                        };
                      Ortac_runtime.stop =
                        {
                          pos_fname = "hashtbl.mli";
                          pos_lnum = 38;
                          pos_bol = 1643;
                          pos_cnum = 1687
                        }
                    })])
      | (Find_all a_5, Res ((List (Int), _), bs)) ->
          if
            let h_old__048_ = Model.get state__031_ 0
            and h_new__049_ = lazy (Model.get (Lazy.force new_state__033_) 0) in
            (try
               (Ortac_runtime.Gospelstdlib.List.to_seq bs) =
                 (Ortac_runtime.Gospelstdlib.Sequence.filter_map
                    (fun (x_1, y) -> if x_1 = a_5 then Some y else None)
                    (Ortac_runtime.Gospelstdlib.List.to_seq
                       (Lazy.force h_new__049_).contents))
             with
             | e ->
                 raise
                   (Ortac_runtime.Partial_function
                      (e,
                        {
                          Ortac_runtime.start =
                            {
                              pos_fname = "hashtbl.mli";
                              pos_lnum = 42;
                              pos_bol = 1853;
                              pos_cnum = 1865
                            };
                          Ortac_runtime.stop =
                            {
                              pos_fname = "hashtbl.mli";
                              pos_lnum = 42;
                              pos_bol = 1853;
                              pos_cnum = 1947
                            }
                        })))
          then None
          else
            Some
              (Ortac_runtime.report "Hashtbl" "create ~random:false 16"
                 (Ortac_runtime.Value (Res (Ortac_runtime.dummy, ())))
                 "find_all"
                 [("bs = Sequence.filter_map (fun (x, y) -> if x = a then Some y else None) h.contents",
                    {
                      Ortac_runtime.start =
                        {
                          pos_fname = "hashtbl.mli";
                          pos_lnum = 42;
                          pos_bol = 1853;
                          pos_cnum = 1865
                        };
                      Ortac_runtime.stop =
                        {
                          pos_fname = "hashtbl.mli";
                          pos_lnum = 42;
                          pos_bol = 1853;
                          pos_cnum = 1947
                        }
                    })])
      | (Mem a_6, Res ((Bool, _), b_6)) ->
          if
            let h_old__051_ = Model.get state__031_ 0
            and h_new__052_ = lazy (Model.get (Lazy.force new_state__033_) 0) in
            (try
               (b_6 = true) =
                 (Ortac_runtime.Gospelstdlib.List.mem a_6
                    (Ortac_runtime.Gospelstdlib.List.map
                       Ortac_runtime.Gospelstdlib.fst
                       (Lazy.force h_new__052_).contents))
             with
             | e ->
                 raise
                   (Ortac_runtime.Partial_function
                      (e,
                        {
                          Ortac_runtime.start =
                            {
                              pos_fname = "hashtbl.mli";
                              pos_lnum = 46;
                              pos_bol = 2149;
                              pos_cnum = 2161
                            };
                          Ortac_runtime.stop =
                            {
                              pos_fname = "hashtbl.mli";
                              pos_lnum = 46;
                              pos_bol = 2149;
                              pos_cnum = 2201
                            }
                        })))
          then None
          else
            Some
              (Ortac_runtime.report "Hashtbl" "create ~random:false 16"
                 (Ortac_runtime.Value (Res (Ortac_runtime.dummy, ()))) "mem"
                 [("b = List.mem a (List.map fst h.contents)",
                    {
                      Ortac_runtime.start =
                        {
                          pos_fname = "hashtbl.mli";
                          pos_lnum = 46;
                          pos_bol = 2149;
                          pos_cnum = 2161
                        };
                      Ortac_runtime.stop =
                        {
                          pos_fname = "hashtbl.mli";
                          pos_lnum = 46;
                          pos_bol = 2149;
                          pos_cnum = 2201
                        }
                    })])
      | (Remove a_7, Res ((Unit, _), _)) -> None
      | (Replace (a_8, b_3), Res ((Unit, _), _)) -> None
      | (Length, Res ((Int, _), i)) ->
          if
            let h_old__058_ = Model.get state__031_ 0
            and h_new__059_ = lazy (Model.get (Lazy.force new_state__033_) 0) in
            (try
               (Ortac_runtime.Gospelstdlib.integer_of_int i) =
                 (Ortac_runtime.Gospelstdlib.List.length
                    (Lazy.force h_new__059_).contents)
             with
             | e ->
                 raise
                   (Ortac_runtime.Partial_function
                      (e,
                        {
                          Ortac_runtime.start =
                            {
                              pos_fname = "hashtbl.mli";
                              pos_lnum = 76;
                              pos_bol = 3727;
                              pos_cnum = 3739
                            };
                          Ortac_runtime.stop =
                            {
                              pos_fname = "hashtbl.mli";
                              pos_lnum = 76;
                              pos_bol = 3727;
                              pos_cnum = 3765
                            }
                        })))
          then None
          else
            Some
              (Ortac_runtime.report "Hashtbl" "create ~random:false 16"
                 (Ortac_runtime.Value
                    (Res
                       (integer,
                         (let h_old__056_ = Model.get state__031_ 0
                          and h_new__057_ =
                            lazy (Model.get (Lazy.force new_state__033_) 0) in
                          try
                            Ortac_runtime.Gospelstdlib.List.length
                              (Lazy.force h_new__057_).contents
                          with
                          | e ->
                              raise
                                (Ortac_runtime.Partial_function
                                   (e,
                                     {
                                       Ortac_runtime.start =
                                         {
                                           pos_fname = "hashtbl.mli";
                                           pos_lnum = 76;
                                           pos_bol = 3727;
                                           pos_cnum = 3743
                                         };
                                       Ortac_runtime.stop =
                                         {
                                           pos_fname = "hashtbl.mli";
                                           pos_lnum = 76;
                                           pos_bol = 3727;
                                           pos_cnum = 3765
                                         }
                                     })))))) "length"
                 [("i = List.length h.contents",
                    {
                      Ortac_runtime.start =
                        {
                          pos_fname = "hashtbl.mli";
                          pos_lnum = 76;
                          pos_bol = 3727;
                          pos_cnum = 3739
                        };
                      Ortac_runtime.stop =
                        {
                          pos_fname = "hashtbl.mli";
                          pos_lnum = 76;
                          pos_bol = 3727;
                          pos_cnum = 3765
                        }
                    })])
      | _ -> None
let _ =
  QCheck_base_runner.run_tests_main
    (let count = 1000 in
     [STMTests.agree_test ~count ~name:"Hashtbl STM tests" 1 check_init_state
        ortac_show_cmd ortac_postcond])