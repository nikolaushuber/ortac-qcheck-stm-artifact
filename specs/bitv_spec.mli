(** This module implements bit vectors, as an abstract datatype [t].
    Since bit vectors are particular cases of arrays, this module provides
    the same operations as module [Array]. It also provides bitwise operations
    and conversions to/from integer types.

    In the following, [false] stands for bit 0 and [true] for bit 1. *)

(*@ function map2 (f : 'a -> 'b -> 'c) (s1 : 'a sequence) (s2 : 'b sequence)
    : 'c sequence =
        Sequence.init (Sequence.length s1) (fun i -> f s1[i] s2[i]) *)

(*@ function population (bits : bool sequence) : integer =
    Sequence.fold_left (fun acc b -> if b then acc + 1 else acc) 0 bits *)

(*@ function op_and (a : bool) (b : bool) : bool = a && b *)
(*@ function op_or (a : bool) (b : bool) : bool = a || b *)
(*@ function op_not (a : bool) : bool = not a *)

(*@ function op_xor (a : bool) (b : bool) : bool =
    if a then
        if b then false else true
    else b *)

type t
(** the type of bit vectors *)
(*@ model size : integer
    mutable model bits : bool sequence *)

(** {2 Creation, access and assignment.} *)

val create : int -> bool -> t
(** [(Bitv.create n b)] creates a new bit vector of length [n],
    initialized with [b]. *)
(*@ t = create n b
    checks n >= 0
    ensures t.size = n
    ensures t.bits = Sequence.init n (fun _ -> b) *)

val init : int -> (int -> bool) -> t
(** [(Bitv.init n f)] returns a fresh vector of length [n],
    with bit number [i] initialized to the result of [(f i)]. *)

val set : t -> int -> bool -> unit
(** [(Bitv.set v n b)] sets the [n]th bit of [v] to the value [b]. *)
(*@ set v n b
    checks 0 <= n < v.size
    modifies v.bits
    ensures v.bits = Sequence.set (old v.bits) n b *)

val get : t -> int -> bool
(** [(Bitv.get v n)] returns the [n]th bit of [v]. *)
(*@ r = get v n
    checks 0 <= n < v.size
    ensures r = v.bits[n] *)

val length : t -> int
(** [Bitv.length] returns the length (number of elements) of the given
    vector. *)
(*@ r = length v
    ensures r = v.size *)

val equal : t -> t -> bool
(** Returns [true] if two bit vectors are of the same length and
    with the same bits. *)
(*@ r = equal v1 v2
    ensures r =
        if v1.size <> v2.size then false
        else
            Sequence.fold_left
                ( fun a b -> a && b)
                true
                (Sequence.init v1.size (fun i ->
                    if v1.bits[i] then
                        if v2.bits[i] then true else false
                    else
                        if v2.bits[i] then false else true)) *)

val tanimoto : t -> t -> float
(** [Bitv.tanimoto v1 v2] is |inter(v1,v2)| / |union(v1,v2)|.
    Also called the Jaccard score.
    (1 - tanimoto) is a proper distance.
    raises [Invalid_argument] if the two vectors do not have the same length *)

val max_length : int
(** @deprecated Use [exceeds_max_length] instead.
    On a 32-bit platform (e.g. Javascript) the computation of [max_length]
    may overflow and return a negative value. *)

val exceeds_max_length : int -> bool
(** Returns true if the argument exceeds the maximum length of a bit vector
    (System dependent). *)

(** {2 Copies and concatenations.} *)

val copy : t -> t
(** [(Bitv.copy v)] returns a copy of [v],
    that is, a fresh vector containing the same elements as [v]. *)
(*@ r = copy v
    ensures r.size = v.size
    ensures r.bits = v.bits *)

val append : t -> t -> t
(** [(Bitv.append v1 v2)] returns a fresh vector containing the
    concatenation of the vectors [v1] and [v2]. *)
(*@ r = append v1 v2
    ensures r.size = v1.size + v2.size
    ensures r.bits = v1.bits ++ v2.bits*)

val concat : t list -> t
(** [Bitv.concat] is similar to [Bitv.append], but catenates a list of
    vectors. *)

(** {2 Sub-vectors and filling.} *)

val sub : t -> int -> int -> t
(** [(Bitv.sub v start len)] returns a fresh
    vector of length [len], containing the bits number [start] to
    [start + len - 1] of vector [v].  Raise [Invalid_argument
    "Bitv.sub"] if [start] and [len] do not designate a valid
    subvector of [v]; that is, if [start < 0], or [len < 0], or [start
    + len > Bitv.length a]. *)
(*@ r = sub v start len
    checks 0 <= len <= v.size
    checks len <= len + start <= v.size
    ensures r.size = len
    ensures r.bits = if len = 0 then Sequence.empty
        else v.bits[start..start+len-1] *)

val fill : t -> int -> int -> bool -> unit
(** [(Bitv.fill v ofs len b)] modifies the vector [v] in place,
    storing [b] in elements number [ofs] to [ofs + len - 1].  Raise
    [Invalid_argument "Bitv.fill"] if [ofs] and [len] do not designate
    a valid subvector of [v]. *)
(*@ fill v ofs len b
    checks 0 <= ofs
    checks 0 <= len
    checks ofs + len <= v.size
    modifies v.bits
    ensures v.bits = Sequence.init
        (old v.size)
        (fun i -> if ofs <= i < ofs + len then b else (old v.bits[i])) *)

val blit : t -> int -> t -> int -> int -> unit
(** [(Bitv.blit v1 o1 v2 o2 len)] copies [len] elements from vector
    [v1], starting at element number [o1], to vector [v2], starting at
    element number [o2]. It does not work correctly if [v1] and [v2] are
    the same vector with the source and destination chunks overlapping.
    Raise [Invalid_argument "Bitv.blit"] if [o1] and [len] do not
    designate a valid subvector of [v1], or if [o2] and [len] do not
    designate a valid subvector of [v2]. *)
(*@ blit v1 o1 v2 o2 len
    checks 0 <= o1 <= o1 + len <= v1.size
    checks 0 <= o2 <= o2 + len <= v2.size
    modifies v2.bits
    ensures v2.bits =
        if o2 = 0 then old (v1.bits[o1..o1+len-1]) ++ v2.bits[len..]
        else old (v2.bits[..o2-1]) ++ v1.bits[o1..o1+len-1]
            ++ v2.bits[o2+len..] *)

(** {2 Iterators} *)

val iter : (bool -> unit) -> t -> unit
(** [(Bitv.iter f v)] applies function [f] in turn to all
    the elements of [v]. *)

val map : (bool -> bool) -> t -> t
(** Given a function [f], [(Bitv.map f v)] applies [f] to all
    the elements of [v], and builds a vector with the results returned
    by [f]. *)

val iteri : (int -> bool -> unit) -> t -> unit
val mapi : (int -> bool -> bool) -> t -> t
(** [Bitv.iteri] and [Bitv.mapi] are similar to [Bitv.iter]
    and [Bitv.map] respectively, but the function is applied to the
    index of the element as first argument, and the element itself as
    second argument. *)

val fold_left : ('a -> bool -> 'a) -> 'a -> t -> 'a
(** [(Bitv.fold_left f x v)] computes [f (... (f (f x (get v 0)) (get
    v 1)) ...) (get v (n-1))], where [n] is the length of the vector
    [v]. *)

val fold_right : (bool -> 'a -> 'a) -> t -> 'a -> 'a
(** [(Bitv.fold_right f a x)] computes [f (get v 0) (f (get v 1)
    ( ... (f (get v (n-1)) x) ...))], where [n] is the length of the
    vector [v]. *)

val foldi_left : ('a -> int -> bool -> 'a) -> 'a -> t -> 'a
val foldi_right : (int -> bool -> 'a -> 'a) -> t -> 'a -> 'a

(** {2 Pop count and other iterations} *)

val pop: t -> int
(** Population count, i.e., number of 1 bits *)
(*@ r = pop v
    ensures r = population v.bits *)

val iteri_true : (int -> unit) -> t -> unit
(** [iteri_true f v] applies function [f] in turn to all indexes of
    the elements of [v] which are set (i.e. [true]); indexes are
    visited from least significant to most significant. *)

val gray_iter : (t -> unit) -> int -> unit
(** [gray_iter f n] iterates function [f] on all bit vectors
    of length [n], once each, using a Gray code. The order in which
    bit vectors are processed is unspecified. *)

(** {2 Bitwise operations.}

    All the bitwise operations return fresh vectors. *)

val bw_and : t -> t -> t
(** bitwise AND;
    raises [Invalid_argument] if the two vectors do not have the same length *)
(*@ r = bw_and v1 v2
    checks v1.size = v2.size
    ensures r.size = v1.size
    ensures r.bits = map2 op_and v1.bits v2.bits *)

val bw_or  : t -> t -> t
(** bitwise OR;
    raises [Invalid_argument] if the two vectors do not have the same length *)
(*@ r = bw_or v1 v2
    checks v1.size = v2.size
    ensures r.size = v1.size
    ensures r.bits = map2 op_or v1.bits v2.bits *)

val bw_xor : t -> t -> t
(** bitwise XOR;
    raises [Invalid_argument] if the two vectors do not have the same length *)
(*@ r = bw_xor v1 v2
    checks v1.size = v2.size
    ensures r.size = v1.size
    ensures r.bits = map2 op_xor v1.bits v2.bits *)

val bw_not : t -> t
(** bitwise NOT *)
(*@ r = bw_not v
    ensures r.size = v.size
    ensures r.bits = Sequence.map op_not v.bits *)

val shiftl : t -> int -> t
(** moves bits from least to most significant; introduces zeros *)
(*@ r = shiftl v n
    ensures r.size = v.size
    ensures r.bits =
        if n = 0 then v.bits
        else if n > 0 then
            if n < v.size then
                Sequence.init n (fun _ -> false) ++ v.bits[..(v.size - n - 1)]
            else Sequence.init v.size (fun _ -> false)
        else
            if (-n) < v.size then
                v.bits[(-n)..] ++ Sequence.init (-n) (fun _ -> false)
            else Sequence.init v.size (fun _ -> false) *)

val shiftr : t -> int -> t
(** moves bits from most to least significant; introduces zeros *)
(*@ r = shiftr v n
    ensures r.size = v.size
    ensures r.bits =
        if n = 0 then v.bits
        else if n > 0 then
            if n < v.size then v.bits[n..] ++ Sequence.init n (fun _ -> false)
            else Sequence.init v.size (fun _ -> false)
        else
            if (-n) < v.size then
                Sequence.init (-n) (fun _ -> false)
                    ++ v.bits[..(v.size + n - 1)]
            else Sequence.init v.size (fun _ -> false) *)

val rotatel : t -> int -> t
(** moves bits from least to most significant with wraparound *)
(*@ r = rotatel v n
    ensures r.size = v.size
    ensures r.bits =
        if n = 0 then v.bits
        else if n > 0 then v.bits[(v.size - (mod n v.size))..]
            ++ v.bits[..(v.size - (mod n v.size) - 1)]
        else v.bits[(mod (-n) v.size)..] ++ v.bits[..((mod (-n) v.size) - 1)] *)

val rotater : t -> int -> t
(** moves bits from most to least significant with wraparound *)
(*@ r = rotater v n
    ensures r.size = v.size
    ensures r.bits =
        if n = 0 then v.bits
        else if n > 0 then v.bits[(mod n v.size)..]
            ++ v.bits[..((mod n v.size) - 1)]
        else v.bits[(v.size - (mod (-n) v.size))..]
            ++ v.bits[..(v.size - (mod (-n) v.size) - 1)] *)

(** {2 Test functions} *)

val all_zeros : t -> bool
(** returns [true] if and only if the vector only contains zeros *)
(*@ r = all_zeros v
    ensures r = not (Sequence.fold_left op_or false v.bits)*)

val all_ones  : t -> bool
(** returns [true] if and only if the vector only contains ones *)
(*@ r = all_ones v
    ensures r = Sequence.fold_left op_and true v.bits *)

(** {2 Conversions to and from lists of integers}

    The list gives the indices of bits which are set (i.e. [true]). *)

val to_list : t -> int list
val of_list : int list -> t
val of_list_with_length : int list -> int -> t
