open Hashtbl

type sut = (char, int) t

let init_sut = create ~random:false 16
