(* generated by imandra_extract from "prelude.iml" *)




#6 "prelude.iml"
type 'a printer = Format.formatter -> 'a -> unit

#7 "prelude.iml"
module Caml =
struct
  include Pervasives
  type use_normal_equality
  let (==) _ _ = (assert false : use_normal_equality) 
  let (!=) _ _ = (assert false : use_normal_equality) 
  module String =
  struct
    include String
    let prefix pre s = CCString.prefix ~pre s 
    let suffix a b = CCString.suffix ~suf:a b 
    let unsafe_to_nat s =
      try
        let n = Z.of_string s  in
        if Z.lt n Z.zero then Z.minus_one else n
      with | _ -> Z.minus_one 
  end
  module List = List
  module Array = Array
  module Set = Set
  module Map = Map
  module Printf = Printf
  module Format = Format
  let float_of_string = float_of_string 
  let count_function_actual_implem (_ : 'a) =
    (failwith
       "the `count` function is not evaluable, its only purpose is helping proving termination of function in Logic mode" : 
       'b) 
  module Int :
  sig
    type t = int
    val (+) : t -> t -> t
    val (-) : t -> t -> t
    val (~-) : t -> t
    val ( * ) : t -> t -> t
    val (/) : t -> t -> t
    val (mod) : t -> t -> t
    val (<) : t -> t -> bool
    val (<=) : t -> t -> bool
    val (>) : t -> t -> bool
    val (>=) : t -> t -> bool
    val min : t -> t -> t
    val max : t -> t -> t
    val incr : t ref -> unit
    val decr : t ref -> unit
    val succ : t -> t
    val pred : t -> t
    val of_int : int -> t
  end =
  struct
    type t = int
    include Pervasives
    let of_int i = i 
  end 
end

#69 "prelude.iml"
module Caml_unix = Unix

#70 "prelude.iml"
module Caml_sys = Sys

#74 "prelude.iml"
module Unix = struct  end

#75 "prelude.iml"
module Sys = struct  end






#85 "prelude.iml"
[@@@ocaml.text
  " {2 Bare minimum needed for ordinals and validation} "]
#97 "prelude.iml"
type nonrec int = Z.t[@@ocaml.doc
  " Builtin integer type, using arbitrary precision integers.\n\n    This type is an alias to {!Z.t}\n    (using {{: https://github.com/ocaml/Zarith} Zarith}).\n\n    {b NOTE}: here Imandra diverges from normal OCaml, where integers width\n    is bounded by native machine integers.\n    \"Normal\" OCaml integers have type {!Caml.Int.t} and can be entered\n    using the 'i' prefix: [0i]\n"]

#99 "prelude.iml"
type nonrec float = float

#101 "prelude.iml"
type nonrec real = Q.t

#105 "prelude.iml"
type nonrec string = string[@@ocaml.doc
  " Type of (byte)strings. Need to have it here so as to be\n    able to type [Z.of_string \"42\"] "]

#108 "prelude.iml"
let (=) = Pervasives.(=)
[@@ocaml.doc
  " Equality. Must be applied to non-function types. "]

#110 "prelude.iml"
let (<) : int -> int -> bool = (<) 

#111 "prelude.iml"
let (<=) : int -> int -> bool = (<=) 

#112 "prelude.iml"
let (>) : int -> int -> bool = (>) 

#113 "prelude.iml"
let (>=) : int -> int -> bool = (>=) 

#114 "prelude.iml"
let min : int -> int -> int = min 

#115 "prelude.iml"
let max : int -> int -> int = max 

#117 "prelude.iml"
let (<.) : real -> real -> bool = Q.lt 

#118 "prelude.iml"
let (<=.) : real -> real -> bool = Q.leq 

#119 "prelude.iml"
let (>.) : real -> real -> bool = Q.gt 

#120 "prelude.iml"
let (>=.) : real -> real -> bool = Q.geq 

#121 "prelude.iml"
let min_r : real -> real -> real = Q.min 

#122 "prelude.iml"
let max_r : real -> real -> real = Q.max 

#124 "prelude.iml"
let (<>) = Pervasives.(<>) 

#125 "prelude.iml"
let not = let open Pervasives in not 

#126 "prelude.iml"
let implies x y = if x then y else true 

#127 "prelude.iml"
let explies x y = implies y x 

#128 "prelude.iml"
let iff x y = (implies x y) && (implies y x) 

#130 "prelude.iml"
let (+) = Z.(+) 

#131 "prelude.iml"
let (~-) = Z.(~-) 

#132 "prelude.iml"
let abs (x : int) =
  if x >= (Z.of_string "0") then x else - x 

#133 "prelude.iml"
let mk_nat (x : int) =
  (if x >= (Z.of_string "0") then x else Z.of_string "0" : 
                                           int) 

#135 "prelude.iml"
let (-) = Z.(-) 

#136 "prelude.iml"
let (~+) (x : Z.t) = x 

#137 "prelude.iml"
let ( * ) = Z.( * ) 

#141 "prelude.iml"
let (/) = Z.ediv
[@@ocaml.doc
  " Euclidian division on integers,\n    see http://smtlib.cs.uiowa.edu/theories-Ints.shtml "]

#144 "prelude.iml"
let (mod) = Z.erem
[@@ocaml.doc " Euclidian remainder on integers "]

#148 "prelude.iml"
let const x _ = x
[@@ocaml.doc
  " [const x y] returns [x]. In other words, [const x] is\n    the constant function that always returns [x]. "]

#151 "prelude.iml"
let compare (x : int) (y : int) =
  if x = y
  then Z.of_string "0"
  else if x < y then Z.of_string "-1" else Z.of_string "1"
[@@ocaml.doc " Total order "]
#153 "prelude.iml"
[@@@ocaml.text " {2 Ordinals} "]
#158 "prelude.iml"
module Ordinal :
sig
  type t = private
    | Int of int 
    | Cons of t* int* t 
  val pp : Format.formatter -> t -> unit
  val of_int : int -> t
  val (~$) : int -> t
  val (<<) : t -> t -> bool
  val plus : t -> t -> t
  val (+) : t -> t -> t
  val of_list : t list -> t
  val shift : t -> by:t -> t
  val is_valid : t -> bool
  val zero : t
  val one : t
  val omega : t
  val omega_omega : t
end =
struct
  type t =
    | Int of int 
    | Cons of t* int* t
            [@ocaml.doc
              " [cons a x tl] is [x\194\183(\207\137^a) + tl], where [tl < \207\137\194\183a], [a\226\137\1600], [x\226\137\1600] "]
  [@@ocaml.doc
    " Ordinals, up to \206\181\226\130\128, in Cantor Normal Form "]
  let pp out (x : t) =
    (let pp_coeff out x =
       if Z.equal Z.one x
       then ()
       else
         Format.fprintf out "%a@<1>\194\183" Z.pp_print
           x
     in
     let rec pp out =
       function
         | Int x -> Z.pp_print out x
         | Cons (a,x,tl) ->
           Format.fprintf out "%a@<1>\207\137%a%a"
             pp_coeff x pp_power a pp_tail tl

     and pp_tail out =
       function
         | Int n when Z.equal Z.zero n -> ()
         | x -> Format.fprintf out "@ + %a" pp x

     and pp_power out =
       function
         | Int n when Z.equal Z.one n -> ()
         | x -> Format.fprintf out "^%a" pp_inner x

     and pp_inner out x =
       match x with
         | Int _ -> pp out x
         | Cons _ -> Format.fprintf out "(@[%a@])" pp x
     in Format.fprintf out "@[%a@]" pp x : unit)
  [@@program ]
  let of_int_unsafe (x : int) = (Int x : t) 
  let zero = Int (Z.of_string "0") 
  let one = Int (Z.of_string "1") 
  let two = Int (Z.of_string "2") 
  let of_int (x : int) = (of_int_unsafe (mk_nat x) : t) 
  let rec (<<) (x : t) (y : t) =
    (match (x, y) with
      | (Int x,Int y) -> x < y
      | (Int _,Cons _) -> true
      | (Cons _,Int _) -> false
      | (Cons (a1,x1,tl1),Cons (a2,x2,tl2)) ->
        (a1 << a2) ||
        ((a1 = a2) &&
         ((x1 < x2) || ((x1 = x2) && (tl1 << tl2)))) : 
          bool)
  [@@ocaml.doc
    " Special axiom: the original well founded relation we use\n      for proving all the other functions terminating. "]
  let rec plus (x : t) (y : t) =
    (match (x, y) with
      | (Int x,Int y) -> Int (x + y)
      | (Int _,Cons _) -> y
      | (Cons (a,x,tl),Int _) -> Cons (a, x, (plus tl y))
      | (Cons (a1,x1,tl1),Cons (a2,x2,tl2)) ->
        if a1 << a2
        then y
        else
        if a1 = a2
        then Cons (a1, (x1 + x2), tl2)
        else Cons (a1, x1, (plus tl1 y)) : t)
  [@@ocaml.doc
    " Addition of ordinals. Not commutative. "]
  let rec shift (x : t) ~by:(n : t)  =
    (if
      (n = (Int (Z.of_string "0"))) ||
      (x = (Int (Z.of_string "0")))
     then x
     else
       (match x with
         | Int x -> Cons (n, x, zero)
         | Cons (a,x,tl) ->
           Cons ((plus a n), x, (shift tl ~by:n))) : 
         t) 
  let rec of_list_rec (acc : t) (l : t list) =
    (match l with
      | [] -> acc
      | x::tail ->
        of_list_rec (plus (shift acc ~by:one) x) tail : 
          t) 
  let of_list (l : t list) =
    (match l with
      | [] -> zero
      | x::[] -> x
      | x::y::[] -> plus (shift ~by:one x) y
      | x::y::z::[] ->
        plus (shift ~by:two x)
          (plus (shift ~by:one y) z)
      | x::y::z::tl ->
        of_list_rec
          (plus (shift ~by:two x)
             (plus (shift ~by:one y) z)) tl : t)

  let count (x : 'a) =
    (Caml.count_function_actual_implem x : t)
  [@@opaque ]
  let rec is_valid_rec (x : t) =
    (match x with
      | Int x -> x >= (Z.of_string "0")
      | Cons (a,x,tl) ->
        (is_valid_rec a) &&
        ((a <> zero) &&
         ((x > (Z.of_string "0")) &&
          ((is_valid_rec tl) &&
           ((match tl with
              | Cons (b,_,_) -> b << a
              | Int _ -> true))))) : bool)
  [@@ocaml.doc " Is this a valid ordinal? "]
  let is_valid (x : t) =
    (match x with
      | Int x -> x >= (Z.of_string "0")
      | o -> is_valid_rec o : bool)
  [@@ocaml.doc " Is this a valid ordinal? "]
  let (+) = plus 
  let (~$) = of_int 
  let omega = of_list [one; zero] 
  let omega_omega = shift omega omega 
end [@@ocaml.doc
  " We need to define ordinals before any recursive function is defined,\n    because ordinals are used for termination proofs.\n"]


#344 "prelude.iml"
[@@@ocaml.text " {2 Other builtin types} "]
#346 "prelude.iml"
type nonrec unit = unit =
  | () 

#350 "prelude.iml"
type ('a,'b) result = ('a,'b) Pervasives.result =
  | Ok of 'a 
  | Error of 'b [@@ocaml.doc
  " Result type, representing either a successul result [Ok x]\n    or an error [Error x]. "]

#353 "prelude.iml"
type ('a,'b) either =
  | Left of 'a 
  | Right of 'b [@@ocaml.doc
  " A familiar type for Haskellers "]

#362 "prelude.iml"
let (|>) x f = f x
[@@ocaml.doc
  " Pipeline operator.\n\n    [x |> f] is the same as [f x], but it composes nicely:\n    [ x |> f |> g |> h] can be more readable than [h(g(f x))].\n"]

#369 "prelude.iml"
let (@@) f x = f x
[@@ocaml.doc
  " Right-associative application operator.\n\n    [f @@ x] is the same as [f x], but it binds to the right:\n    [f @@ g @@ h @@ x] is the same as [f (g (h x))] but with fewer parenthesis.\n"]

#372 "prelude.iml"
let id x = x
[@@ocaml.doc
  " Identity function. [id x = x] always holds. "]

#377 "prelude.iml"
let (%>) f g x = g (f x)
[@@ocaml.doc
  " Mathematical composition operator.\n\n    [f %> g] is [fun x -> g (f x)] "]

#381 "prelude.iml"
let (==) = Caml.(==) [@@program ]

#382 "prelude.iml"
let (!=) = Caml.(!=) [@@program ]

#384 "prelude.iml"
let (+.) : real -> real -> real = Q.(+) 

#385 "prelude.iml"
let (-.) : real -> real -> real = Q.(-) 

#386 "prelude.iml"
let (~-.) = Q.neg 

#387 "prelude.iml"
let ( *. ) : real -> real -> real = Q.( * ) 

#388 "prelude.iml"
let (/.) : real -> real -> real = Q.(/) 

#390 "prelude.iml"
let (==>) a b = implies a b 

#391 "prelude.iml"
let (<==) a b = explies a b 

#392 "prelude.iml"
let (<==>) a b = iff a b 

#402 "prelude.iml"
module List =
struct
  type 'a t = 'a list
  let empty = [] 
  let is_empty = function | [] -> true | _::_ -> false
  [@@ocaml.doc " Test whether a list is empty "]
  let cons x y = x :: y
  [@@ocaml.doc
    " [cons x l] prepends [x] at the beginning of [l], returning a new list "]
  let return x = [x] [@@ocaml.doc " Singleton list "]
  let hd = List.hd
  [@@ocaml.doc
    " Partial function to access the head of the list.\n      This function will fail when applied to the empty list.\n      {b NOTE} it is recommended to rely on pattern matching instead "]
  let tl = List.tl
  [@@ocaml.doc
    " Partial function to access the tail of the list.\n      This function will fail when applied to the empty list\n      {b NOTE} it is recommended to rely on pattern matching instead "]
  let rec append l1 l2 =
    match l1 with
      | [] -> l2
      | x::l1' -> x :: (append l1' l2)
  [@@ocaml.doc
    " Concatenation. [append l1 l2] returns a list composed of all\n      the elements of [l1], followed by all the elements of [l2] "]
  let rec rev l =
    match l with
      | [] -> []
      | x::l' -> append (rev l') [x]
  [@@ocaml.doc " Reverse a list "]
  let rec length l =
    match l with
      | [] -> Z.of_string "0"
      | _::l2 -> (Z.of_string "1") + (length l2)
  [@@ocaml.doc
    " Compute the length of a list. Linear time. "]
  let len_nonnegative l =
    ((length l)[@trigger ]) >= (Z.of_string "0")
  [@@theorem ][@@fc ][@@induct ]
  let len_zero_is_empty x =
    ((length x) = (Z.of_string "0")) = (x = [])
  [@@theorem ][@@rewrite ][@@induct ]
  let rec split l =
    match l with
      | [] -> ([], [])
      | (x,y)::tail ->
        let (tail1,tail2) = split tail  in
        ((x :: tail1), (y :: tail2))
  [@@ocaml.doc
    " Split a list of pairs into a pair of lists "]
  let rec map f l =
    match l with
      | [] -> []
      | x::l2 -> (f x) :: (map f l2)
  [@@ocaml.doc
    " Map a function over a list.\n\n      - [map f [] = []]\n      - [map f [x] = [f x]]\n      - [map f (x :: tail) = f x :: map f tail]\n  "]
  let rec for_all f l =
    match l with
      | [] -> true
      | x::l2 -> (f x) && (for_all f l2)
  [@@ocaml.doc
    " [for_all f l] tests whether all elements of [l] satisfy the predicate [f] "]
  let rec exists f l =
    match l with
      | [] -> false
      | x::l2 -> (f x) || (exists f l2)
  [@@ocaml.doc
    " [exists f l] tests whether there is an element of [l]\n      that satisfies the predicate [f] "]
  let rec fold_left f acc =
    function
      | [] -> acc
      | x::tail -> fold_left f (f acc x) tail
  [@@ocaml.doc
    " Fold-left, with an accumulator that makes induction more challenging "]
  let rec fold_right f ~base  l =
    match l with
      | [] -> base
      | x::tail -> f x (fold_right f ~base tail)
  [@@ocaml.doc
    " Fold-right, without accumulator. This is generally more friendly for\n      induction than [fold_left]. "]
  let rec filter f =
    function
      | [] -> []
      | x::tail ->
        let tail = filter f tail  in
        if f x then x :: tail else tail
  [@@ocaml.doc
    " [filter f l] keeps only the elements of [l] that satisfy [f]. "]
  let rec filter_map f =
    function
      | [] -> []
      | x::tail ->
        let tail = filter_map f tail  in
        (match f x with
          | None  -> tail
          | Some y -> y :: tail)

  let rec flat_map f =
    function
      | [] -> []
      | x::tail -> append (f x) (flat_map f tail) 
  let rec mem x =
    function
      | [] -> false
      | y::tail -> (x = y) || (mem x tail)
  [@@ocaml.doc
    " [mem x l] returns [true] iff [x] is an element of [l] "]
  let rec mem_assoc x =
    function
      | [] -> false
      | (k,_)::tail -> (x = k) || (mem_assoc x tail) 
  let rec nth n =
    function
      | [] -> None
      | y::tail ->
        if n = (Z.of_string "0")
        then Some y
        else nth (n - (Z.of_string "1")) tail

  let rec assoc x =
    function
      | [] -> None
      | (k,v)::tail ->
        if x = k then Some v else assoc x tail

  let rec take n =
    function
      | [] -> []
      | _ when n <= (Z.of_string "0") -> []
      | x::tl -> x :: (take (n - (Z.of_string "1")) tl)
  [@@ocaml.doc
    " [take n l] returns a list composed of the first (at most) [n] elements\n      of [l]. If [length l <= n] then it returns [l] "]
  let rec drop n =
    function
      | [] -> []
      | l when n <= (Z.of_string "0") -> l
      | _::tl -> drop (n - (Z.of_string "1")) tl
  [@@ocaml.doc
    " [drop n l] returns [l] where the first (at most) [n] elements\n      have been removed. If [length l <= n] then it returns [[]] "]
  let rec (--) i j =
    if i >= j
    then []
    else i :: ((i + (Z.of_string "1")) -- j)
  [@@ocaml.doc
    " Integer range. [i -- j] is the list [[i; i+1; i+2; \226\128\166; j-1]].\n      Returns the empty list if [i >= j]. "]
  let rec insert_sorted ~leq  x l =
    match l with
      | [] -> [x]
      | y::_ when leq x y -> x :: l
      | y::tail -> y :: (insert_sorted ~leq x tail)
  [@@ocaml.doc
    " Insert [x] in [l], keeping [l] sorted. "]
  let sort ~leq  l =
    (fold_left
       (fun acc  -> fun x  -> insert_sorted ~leq x acc)
       [] l : _ list)
  [@@ocaml.doc " Basic sorting function "]
  let rec is_sorted ~leq  =
    function
      | []|_::[] -> true
      | x::(y::_ as tail) ->
        (leq x y) && (is_sorted ~leq tail)
  [@@ocaml.doc
    " Check whether a list is sorted, using the [leq] small-or-equal-than\n      predicatet "]
end[@@ocaml.doc
  " {2 List module}\n\n    This module contains many safe functions for manipulating lists.\n"]

#582 "prelude.iml"
let (@) = List.append
[@@ocaml.doc " Infix alias to {!List.append} "]

#585 "prelude.iml"
let (--) = List.(--) [@@ocaml.doc " Alias to {!List.--} "]

#587 "prelude.iml"
module Int =
struct
  type t = int
  let (+) = (+) 
  let (-) = (-) 
  let (~-) = (~-) 
  let ( * ) = ( * ) 
  let (/) = (/) 
  let (mod) = (mod) 
  let (<) = (<) 
  let (<=) = (<=) 
  let (>) = (>) 
  let (>=) = (>=) 
  let min = min 
  let max = max 
  let to_string : t -> string = Z.to_string
  [@@ocaml.doc
    " Conversion to a string.\n      Only works for nonnegative numbers "]
  let compare (x : t) (y : t) =
    if x = y
    then Z.of_string "0"
    else
    if x < y
    then Z.of_string "-1"
    else Z.of_string "1"

  let equal = (=) 
  let compare = Pervasives.compare [@@program ]
  let pp = Z.pp_print [@@program ]
  let of_caml_int = Z.of_int [@@program ]
end

#625 "prelude.iml"
module Option =
struct
  type 'a t = 'a option
  let map f =
    function | None  -> None | Some x -> Some (f x)
  [@@ocaml.doc
    " Map over the option.\n\n      - [map f None = None]\n      - [map f (Some x) = Some (f x)]\n  "]
  let map_or ~default  f =
    function | None  -> default | Some x -> f x 
  let is_some =
    function | None  -> false | Some _ -> true
  [@@ocaml.doc
    " Returns [true] iff the argument is of the form [Some x] "]
  let is_none =
    function | None  -> true | Some _ -> false
  [@@ocaml.doc
    " Returns [true] iff the argument is [None] "]
  let return x = Some x
  [@@ocaml.doc
    " Wrap a value into an option. [return x = Some x] "]
  let (>|=) x f = map f x
  [@@ocaml.doc " Infix alias to {!map} "]
  let (>>=) o f =
    match o with | None  -> None | Some x -> f x
  [@@ocaml.doc
    " Infix monadic operator, useful for chaining multiple optional computations\n      together.\n\n      It holds that [(return x >>= f) = f x] "]
  let or_ ~else_  a =
    match a with | None  -> else_ | Some _ -> a
  [@@ocaml.doc
    " Choice of a value\n\n      - [or_ ~else_:x None = x]\n      - [or_ ~else_:x (Some y) = Some y]\n  "]
  let (<+>) a b = or_ ~else_:b a 
  let exists p =
    function | None  -> false | Some x -> p x 
  let for_all p =
    function | None  -> true | Some x -> p x 
  let get_or ~default  x =
    match x with | None  -> default | Some y -> y 
  let fold f acc o =
    match o with | None  -> acc | Some x -> f acc x 
end[@@ocaml.doc
  " {2 Option module}\n\n    The option type [type 'a option = None | Some of 'a] is useful for\n    representing partial functions and optional values.\n    "]

#712 "prelude.iml"
module Result =
struct
  type ('a,'b) t = ('a,'b) result
  let return x = Ok x 
  let fail s = Error s 
  let map f e =
    match e with | Ok x -> Ok (f x) | Error s -> Error s 
  let map_err f e =
    match e with
      | Ok _ as res -> res
      | Error y -> Error (f y) 
  let get_or e ~default  =
    match e with | Ok x -> x | Error _ -> default 
  let map_or f e ~default  =
    match e with | Ok x -> f x | Error _ -> default 
  let (>|=) e f = map f e 
  let flat_map f e =
    match e with | Ok x -> f x | Error s -> Error s 
  let (>>=) e f = flat_map f e 
  let fold ~ok  ~error  x =
    match x with | Ok x -> ok x | Error s -> error s 
  let is_ok = function | Ok _ -> true | Error _ -> false 
  let is_error =
    function | Ok _ -> false | Error _ -> true 
end

#768 "prelude.iml"
module Real =
struct
  type t = real
  let of_int : int -> t = Q.of_bigint 
  let (+) = (+.) 
  let (-) = (-.) 
  let (~-) = (~-.) 
  let ( * ) = ( *. ) 
  let (/) = (/.) 
  let (<) = (<.) 
  let (<=) = (<=.) 
  let (>) = (>.) 
  let (>=) = (>=.) 
  let abs r =
    if r >= (of_int (Z.of_string "0")) then r else - r 
  let min = min_r 
  let max = max_r 
  let mk_of_float = Q.of_float [@@program ]
  let mk_of_q (x : Q.t) = x [@@program ]
  let mk_of_string (x : string) = Q.of_string x
  [@@program ]
  let to_float = Q.to_float [@@program ]
  let of_float = Q.of_float 
  let compare (x : t) (y : t) =
    if x = y then 0 else if x < y then (-1) else 1 
  let pp = Q.pp_print [@@program ]
  let to_string = Q.to_string [@@program ]
  let to_string_approx x =
    string_of_float @@ (Q.to_float x) [@@program ]
end

#809 "prelude.iml"
module Map :
sig
  type (+'a,'b) t
  val const : 'b -> (_,'b) t
  val add : 'a -> 'b -> ('a,'b) t -> ('a,'b) t
  val add' : ('a,'b) t -> 'a -> 'b -> ('a,'b) t
  val get : 'a -> ('a,'b) t -> 'b
  val get' : ('a,'b) t -> 'a -> 'b
  val get_default : (_,'b) t -> 'b
  val of_list : default:'b -> ('a* 'b) list -> ('a,'b) t
  val filter_map :
    default:('b -> 'c) ->
    f:('a -> 'b -> 'c option) ->
    ('a,'b) t -> ('a,'c) t[@@program ]
  val for_all :
    default:('b -> bool) ->
    f:('a -> 'b -> bool) -> ('a,'b) t -> bool[@@program
]
  val merge :
    default:('b -> 'c -> 'd) ->
    f_both:('a -> 'b -> 'c -> 'd option) ->
    f1:('a -> 'b -> 'd option) ->
    f2:('a -> 'c -> 'd option) ->
    ('a,'b) t -> ('a,'c) t -> ('a,'d) t[@@program
]
  val extract : ('a,'b) t -> (('a* 'b) list* 'b)
  [@@program ]
  val pp : 'a printer -> 'b printer -> ('a,'b) t printer
  [@@program ]
end =
struct
  type (+'a,'b) t = {
    l: ('a* 'b) list ;
    default: 'b }
  let const x = ({ default = x; l = [] } : _ t) 
  let add_rec k v m =
    (let rec aux l =
       match l with
         | [] -> if v = m.default then [] else [(k, v)]
         | (k',v')::tail ->
           (match Caml.compare k k' with
             | 0 ->
               if v = m.default
               then tail
               else (k, v) :: tail
             | n when let open Caml.Int in n < 0 ->
               if v = m.default then l else (k, v) :: l
             | _ -> (k', v') :: (aux tail))
     in
     { m with l = (aux m.l) } : _ t)
  [@@program ]
  let add' m k v = add_rec k v m
  [@@ocaml.doc
    " [add' m k v] adds the binding [k -> v] to [m] "]
  let add k v m = add' m k v
  [@@ocaml.doc
    " Same as {!add'} but with arguments swapped "]
  let get_default (m : (_,'b) t) = (m.default : 'b) 
  let get_rec k m =
    let rec aux l =
      match l with
        | [] -> m.default
        | (k',v)::tail -> if k = k' then v else aux tail
    in
    aux m.l [@@program ]
  let get' m k = get_rec k m 
  let get (k : 'a) (m : ('a,'b) t) = (get' m k : 'b) 
  let rec of_list ~default:(default : 'b) 
      (l : ('a* 'b) list) =
    (match l with
      | [] -> const default
      | (k,v)::tail -> add k v (of_list ~default tail) : 
                         ('a,'b) t) 
  let filter_map ~default  ~f  m =
    (let rec aux =
       function
         | [] -> []
         | (x,v)::tl ->
           let tl = aux tl  in
           (match f x v with
             | None  -> tl
             | Some v' -> (x, v') :: tl)
     in
     { default = (default m.default); l = (aux m.l) } : 
       _ t) [@@program ]
  let for_all ~default  ~f  m =
    ((default m.default) &&
     (List.for_all (fun (x,v)  -> f x v) m.l) : 
       bool) [@@program ]
  let merge ~default  ~f_both  ~f1  ~f2 
      (s1 : ('a,'b) t) (s2 : ('a,'c) t) =
    (let open Pervasives in
     let rec aux l1 l2 =
       match (l1, l2) with
         | ([],[]) -> []
         | ([],_) ->
           CCList.filter_map
             (fun (k,v)  ->
                (CCOpt.map (fun v  -> (k, v))) @@
                (f2 k v)) l2
         | (_,[]) ->
           CCList.filter_map
             (fun (k,v)  ->
                (CCOpt.map (fun v  -> (k, v))) @@
                (f1 k v)) l1
         | ((x1,v1)::tl1,(x2,v2)::tl2) ->
           if x1 = x2
           then
             let tl = aux tl1 tl2  in
             (match f_both x1 v1 v2 with
               | None  -> tl
               | Some v -> (x1, v) :: tl)
           else
           if x1 < x2
           then
             (let tl = aux tl1 l2  in
              match f1 x1 v1 with
                | None  -> tl
                | Some v -> (x1, v) :: tl)
           else
             (let tl = aux l1 tl2  in
              match f2 x2 v2 with
                | None  -> tl
                | Some v -> (x2, v) :: tl)
     in
     {
       default = (default s1.default s2.default);
       l = (aux s1.l s2.l)
     } : ('a,'d) t)
  [@@program ]
  let extract (m : ('a,'b) t) =
    (((m.l), (m.default)) : (('a* 'b) list* 'b))
  [@@program ]
  let pp pp_k pp_v out (m : (_,_) t) =
    (match m.l with
      | [] ->
        Format.fprintf out "(@[Map.const %a@])" pp_v
          m.default
      | _ ->
        let pp_sep out () = Format.fprintf out ";@ "
        in
        let pp_pair out (k,v) =
          Format.fprintf out "(@[%a,@ %a@])" pp_k k
            pp_v v
        in
        Format.fprintf out
          "(@[Map.of_list@ ~default:%a@ [@[%a@]]@])"
          pp_v m.default
          (Format.pp_print_list ~pp_sep pp_pair) 
          m.l : unit)
  [@@program ]
end 







#967 "prelude.iml"
module Multiset :
sig
  type +'a t = ('a,int) Map.t
  val empty : 'a t
  val add : 'a -> 'a t -> 'a t
  val remove : 'a -> 'a t -> 'a t
  val mem : 'a -> 'a t -> bool
  val find : 'a -> 'a t -> int
  val of_list : 'a list -> 'a t
end =
struct
  type +'a t = ('a,int) Map.t
  let empty = Map.const (Z.of_string "0") 
  let add (x : 'a) (m : 'a t) =
    (Map.add x ((Map.get x m) + (Z.of_string "1")) m : 
       'a t) 
  let find = Map.get 
  let mem x m = ((find x m) > (Z.of_string "0") : bool) 
  let remove (x : 'a) (m : 'a t) =
    (let n =
       max (Z.of_string "0")
         ((Map.get x m) - (Z.of_string "1"))
     in
     Map.add x n m : 'a t)

  let rec of_list =
    function
      | [] -> empty
      | x::tail -> (add x) @@ (of_list tail) 
end [@@ocaml.doc
  " {2 Multiset}\n\n    A multiset is a collection of elements that don't have any particular\n    order, but can occur several times (unlike a regular set). "]
#994 "prelude.iml"
[@@@ocaml.text " {2 Sets} "]
#996 "prelude.iml"
module Set :
sig
  type +'a t = ('a,bool) Map.t
  val empty : 'a t
  val is_valid : _ t -> bool
  val is_empty : _ t -> bool
  val mem : 'a -> 'a t -> bool
  val add : 'a -> 'a t -> 'a t
  val subset : 'a t -> 'a t -> bool
  val union : 'a t -> 'a t -> 'a t
  val inter : 'a t -> 'a t -> 'a t
  val diff : 'a t -> 'a t -> 'a t
  val (++) : 'a t -> 'a t -> 'a t
  val (--) : 'a t -> 'a t -> 'a t
  val of_list : 'a list -> 'a t
  val to_list : 'a t -> 'a list
  val pp : 'a printer -> 'a t printer
end =
struct
  type +'a t = ('a,bool) Map.t
  let empty = Map.const false 
  let is_empty s = s = empty 
  let is_valid s = not (Map.get_default s) 
  let mem x s = Map.get x s 
  let subset (s1 : 'a t) (s2 : 'a t) =
    (Map.for_all s1
       ~default:(fun v1  ->
         if v1
         then Map.get_default s2
         else true)
       ~f:(fun x  ->
         fun v1  -> if v1 then mem x s2 else true) : 
       bool) 
  let add x s = Map.add x true s 
  let inter_ (s1 : 'a t) (s2 : 'a t) =
    (Map.merge s1 s2
       ~default:(fun v1  ->
         fun v2  ->
           assert (not v1);
           assert (not v2);
           false)
       ~f1:(fun _  -> fun _  -> None)
       ~f2:(fun _  -> fun _  -> None)
       ~f_both:(fun _  ->
         fun s1  ->
         fun s2  ->
           if s1 && s2
           then Some true
           else None) : 'a t)
  [@@program ]
  let inter = inter_ 
  let union_ (s1 : 'a t) (s2 : 'a t) =
    (Map.merge
       ~default:(fun v1  ->
         fun v2  ->
           assert (not v1);
           assert (not v2);
           false)
       ~f1:(fun _  -> fun _  -> Some true)
       ~f2:(fun _  -> fun _  -> Some true)
       ~f_both:(fun _  ->
         fun s1  ->
         fun s2  ->
           if s1 || s2
           then Some true
           else None) s1 s2 : 'a t)
  [@@program ]
  let union = union_ 
  let diff_ (s1 : 'a t) (s2 : 'a t) =
    (Map.merge
       ~default:(fun v1  ->
         fun v2  ->
           assert (not v1);
           assert (not v2);
           false)
       ~f1:(fun _  -> fun _  -> Some true)
       ~f2:(fun _  -> fun _  -> None)
       ~f_both:(fun _  ->
         fun s1  ->
         fun s2  ->
           if s1 && (not s2)
           then Some true
           else None) s1 s2 : 'a t)
  [@@program ]
  let diff = diff_ 
  let rec of_list =
    function | [] -> empty | x::tl -> add x (of_list tl) 
  let to_list (s : 'a t) =
    (let (l,_) = Map.extract s  in
     CCList.filter_map
       (fun (x,b)  -> if b then Some x else None) l : 
       'a list) [@@program ]
  let (++) = union 
  let (--) = diff 
  let pp pp_x out (x : 'a t) =
    (match to_list x with
      | [] -> Format.pp_print_string out "Set.empty"
      | l ->
        Format.fprintf out
          "(@[Set.of_list@ [@[%a@]]@])"
          (Format.pp_print_list
             ~pp_sep:(fun out  ->
               fun ()  ->
                 Format.fprintf out ";@ ")
             pp_x) l : unit)
  [@@program ]
end 


#1111 "prelude.iml"
module String :
sig
  type t = string
  val empty : t
  val length : t -> int
  val make : Caml.Int.t -> char -> t
  val append : t -> t -> t
  val get : t -> Caml.Int.t -> char
  val concat : t -> t list -> t
  val prefix : t -> t -> bool
  val suffix : t -> t -> bool
  val sub : t -> int -> int -> t option
  val of_int : int -> t
  val to_nat : t -> int option
end =
struct
  type t = string
  let empty = "" 
  let length (s : t) =
    (Z.of_int (Caml.String.length s) : int)
  [@@ocaml.doc
    " Length of the string, i.e. its number of bytes "]
  let make (i : Caml.Int.t) c = (String.make i c : t)
  [@@ocaml.doc
    " [make i c] makes a string containing [i] times the char [c] "]
  [@@program ]
  let append : t -> t -> t = Pervasives.(^)
  [@@ocaml.doc " String concatenation "]
  let get = Caml.String.get [@@program ]
  let rec concat sep (l : t list) =
    (match l with
      | [] -> ""
      | x::[] -> x
      | x::tail ->
        append x (append sep (concat sep tail)) : 
          t)
  [@@ocaml.doc
    " [concat sep l] concatenates strings in [l] with [sep] inserted between\n    each element.\n\n    - [concat sep [] = \"\"]\n    - [concat sep [x] = x]\n    - [concat sep [x;y] = x ^ sep ^ y]\n    - [concat sep (x :: tail) = x ^ sep ^ concat sep tail]\n    "]
  let prefix a b = Caml.String.prefix a b
  [@@ocaml.doc
    " [prefix a b] returns [true] iff [a] is a prefix of [b]\n      (or if [a=b] "]
  let suffix a b = Caml.String.suffix a b
  [@@ocaml.doc
    " [suffix a b] returns [true] iff [a] is a suffix of [b]\n      (or if [a=b] "]
  let unsafe_sub (a : t) (i : int) (len : int) =
    (Caml.String.sub a (Z.to_int i) (Z.to_int len) : 
       t) 
  let sub (a : t) (i : int) (len : int) =
    (if
      (i >= (Z.of_string "0")) &&
      ((len >= (Z.of_string "0")) &&
       ((i + len) <= (length a)))
     then Some (unsafe_sub a i len)
     else None : t option)
  [@@ocaml.doc
    " Substring. [sub s i len] returns the string [s[i], s[i+1],\226\128\166,s[i+len-1]]. "]
  let of_int (i : int) =
    (if i >= (Z.of_string "0")
     then Int.to_string i
     else append "-" (Int.to_string (- i)) : t)
  [@@ocaml.doc
    " String representation of an integer "]
  let unsafe_to_nat : t -> int =
    Caml.String.unsafe_to_nat 
  let to_nat (s : t) =
    (let x = unsafe_to_nat s  in
     if x >= (Z.of_string "0") then Some x else None : 
                                                  int option)
  [@@ocaml.doc
    " Parse a string into a nonnegative number, or return [None] "]
end [@@ocaml.doc
  " {2 Byte strings}\n\n    These strings correspond to OCaml native strings, and do not have\n    a particular unicode encoding.\n\n    Rather, they should be seen as sequences of bytes, and it is also\n    this way that Imandra considers them.\n"]

#1207 "prelude.iml"
let (^) = String.append
[@@ocaml.doc " Alias to {!String.append} "]

#1210 "prelude.iml"
let succ x = x + (Z.of_string "1")
[@@ocaml.doc " Next integer "]

#1213 "prelude.iml"
let pred x = x - (Z.of_string "1")
[@@ocaml.doc " Previous integer "]

#1215 "prelude.iml"
let fst (x,_) = x 

#1216 "prelude.iml"
let snd (_,y) = y 

#1218 "prelude.iml"
module Float =
struct
  type t = float
  module Round : sig type t end =
  struct
    type t =
      | Nearest_ties_to_even
          [@ocaml.doc " default "]
      | Nearest_ties_to_away 
      | Towards_positive 
      | Towards_negative 
      | Towards_zero 
    let _ = fun (x : t)  -> x = x [@@verify ]
  end 
  let of_int = Z.to_float [@@program ]
  let of_string = Caml.float_of_string [@@program ]
  let (~-) : t -> t = Caml.(~-.) 
  let (+) : t -> t -> t = Caml.(+.) 
  let (-) : t -> t -> t = Caml.(-.) 
  let ( * ) : t -> t -> t = Caml.( *. ) 
  let (/) : t -> t -> t = Caml.(/.) 
  let nan : t = Caml.nan 
  let infinity : t = Caml.infinity 
  let (<) : t -> t -> bool = Caml.(<) 
  let (<=) : t -> t -> bool = Caml.(<=) 
  let (>) : t -> t -> bool = Caml.(>) 
  let (>=) : t -> t -> bool = Caml.(>=) 
  let (=) : t -> t -> bool = Caml.(=) 
  let (<>) : t -> t -> bool = Caml.(<>) 
  let neg : t -> t = (~-) 
  let abs : t -> t = Caml.abs_float 
  let is_zero (x : t) =
    (Pervasives.(=) x (Caml.float_of_string "0.") : 
       bool) 
  let is_nan (x : t) =
    (Pervasives.(=) (Caml.classify_float x) Caml.FP_nan : 
       bool) 
  let is_infinite (x : t) =
    (Pervasives.(=) (Caml.classify_float x)
       Caml.FP_infinite : bool)

  let is_normal (x : t) =
    (Pervasives.(=) (Caml.classify_float x)
       Caml.FP_normal : bool)

  let is_subnormal (x : t) =
    (Pervasives.(=) (Caml.classify_float x)
       Caml.FP_subnormal : bool)

  let is_positive (x : t) =
    (x > (Caml.float_of_string "0.") : bool) 
  let is_negative (x : t) =
    (x < (Caml.float_of_string "0.") : bool) 
  let min (x : t) (y : t) =
    (if is_nan x
     then y
     else if is_nan y then x else Caml.min x y : 
                                    t) 
  let max (x : t) (y : t) =
    (if is_nan x
     then y
     else if is_nan y then x else Caml.max x y : 
                                    t) 
  let rem : t -> t -> t = Caml.mod_float 
  let sqrt : t -> t = Caml.sqrt 
end

#1277 "prelude.iml"
module Pervasives = struct  end








