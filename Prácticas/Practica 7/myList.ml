(*LISTAS DE PRUEBA*)
let prueba_1 = [5;3;8;7;2]
let prueba_2 = [9;1;4;3]

(*FUNCIONES*)
let hd = function
  [] -> raise (Failure "hd")
  |h::_ -> h;;

let tl = function
  [] -> raise (Failure "tl")
  |_::t -> t;;

let last lst = 
  let rec aux acu rest =
    match rest with
    | [] -> acu
    | h::t -> aux h t
  in 
  match lst with
  | [] -> raise (Invalid_argument "last")
  | h::t -> aux h t

let rec length = function
   [] -> 0
  |_::xs -> 1 + length xs

let length' lst =
  let rec aux list acu =
    match list with
    |[] -> acu
    |_::xs -> aux xs (acu+1)
in 
aux lst 0

let rec compare_lengths l1 l2 =
  match (l1, l2) with
  | ([],[]) -> 0
  | (_::_, []) -> 1
  | ([], _::_) -> 1
  | (_::xs, _::ys) -> compare_lengths xs ys

let rec append l1 l2 =
  match (l1, l2) with
  | ([],[]) -> []
  | (_::_, []) -> l1
  | ([], _::_) -> l2
  | (_::xs, _::ys) -> append xs ys

let rec rev_append l1 l2 = 
  match l1 with
  | [] -> l2
  | x :: xs -> rev_append xs (x::l2)

let rev list =
  let rec aux lst acu =
    match lst with
    | [] -> lst
    | x :: xs -> aux xs (x::acu)
  in 
  aux list []

let concat l =
  let rec append_tr acc l1 l2 =
    match l1 with
    | [] -> List.rev_append acc l2 (* rev_append es TR y evita @ *)
    | h :: t -> append_tr (h :: acc) t l2
  in
  let rec loop acc = function
    | [] -> acc
    | h :: t -> loop (append_tr [] h acc) t
  in
  List.rev (loop [] l)

let flatten = concat

let init n f =
  let rec aux i acu = 
    match i with
    | i when i<0 -> acu
    | _ -> aux (i-1) (f i:: acu)
  in 
  aux (n-1) []

let rec nth l n =
  match l with
  | _ when n < 0 -> invalid_arg "List.nth"
  | [] -> raise (Failure "nth")
  | h :: t ->
    match n with
    | 0 -> h 
    | _ -> nth t (n - 1)

let rec map f = function
  | [] -> []
  | h::t -> (f h) :: (map f t)

let rev_map f l =
  let rec aux acu = function
  | [] -> List.rev acu
  | h::t -> aux ((f h)::acu) t
in 
aux [] l

let rec map2 f l1 l2 =
  match (l1, l2) with
  | ([], []) -> []
  | (h1 :: t1, h2 :: t2) -> (f h1 h2) :: (map2 f t1 t2)
  | _ -> invalid_arg "List.map2: lists have different lengths" 

let rec combine l1 l2 =
  match (l1, l2) with
  | ([], []) -> []
  | (h1 :: t1, h2 :: t2) -> (h1, h2) :: (combine t1 t2)
  | _ -> invalid_arg "List.combine: lists have different lengths"

let rec split = function
  | [] -> ([], [])
  | (a, b) :: t ->
    let (ta, tb) = split t in
    (a :: ta, b :: tb)

let rec filter p = function
  | [] -> []
  | h :: t ->
    let res_t = filter p t in
    if p h then h :: res_t else res_t

let filter' p l =
  let rec aux acu = function
    | [] -> List.rev acu
    | h :: t ->
      if p h then aux (h :: acu) t
      else aux acu t
  in
  aux [] l

let rec partition p = function
  | [] -> ([], [])
  | h :: t ->
    let (trues, falses) = partition p t in
    if p h then (h :: trues, falses) else (trues, h :: falses)

let partition' p l =
  let rec aux trues falses = function
    | [] -> (List.rev trues, List.rev falses)
    | h :: t ->
      if p h then aux (h :: trues) falses t
      else aux trues (h :: falses) t
  in
  aux [] [] l

let rec find p = function
  | [] -> raise Not_found
  | h :: t -> if p h then h else find p t

let rec for_all p = function
  | [] -> true
  | h :: t -> p h && (for_all p t)

let rec exists p = function
  | [] -> false
  | h :: t -> p h || (exists p t)

let rec mem x = function
  | [] -> false
  | h :: t -> x = h || (mem x t)

let rec take n = function
  | [] -> []
  | l when n <= 0 -> []
  | h :: t -> h :: (take (n - 1) t)

let rec drop n = function
  | l when n <= 0 -> l
  | [] -> []
  | _ :: t -> drop (n - 1) t

let rec fold_left f   acu = function
  | [] -> acu 
  | h::t -> fold_left f (f acu h) t 

let rec fold_right f l acu = 
  match l with 
  | [] -> acu
  | h::t -> f h (fold_right f t acu)