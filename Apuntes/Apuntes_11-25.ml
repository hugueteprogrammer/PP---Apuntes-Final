type 'a bin_tree =
    E
  | N of 'a * 'a bin_tree * 'a bin_tree

let lf x = N(x, E, E);;

let rec num_nodes = function
    E -> 0
  | N (_, l, r) -> 1 + num_nodes l + num_nodes r

let rec height = function 
    E -> 0
  | N (_, l, r) -> 1 + max(height l) (height r)

(*EJEMPLOS
# let bt6 = N (6, lf 5, lf 11);;
val bt6 : int bin_tree = N (6, N (5, E, E), N (11, E, E))
# let bt7 = N (7, lf 2, bt6);;
val bt7 : int bin_tree = N (7, N (2, E, E), N (6, N (5, E, E), N (11, E, E)))
*)

let rec preorder = function (*Recorrido*)
    E -> []
  | N (x, l, r) ->
      [x] @ (preorder l) @ (preorder r) (* o x :: preorder l @ preorder r *)

(*
# preorder bt7;;
- : int list = [7; 2; 6; 5; 11]
*)
let rec leaves = function 
    E -> []
  | N (x, E, E) -> [x]
  | N (_, l, r) -> leaves l @ leaves r

(*
# leaves bt7;;
- : int list = [2; 5; 11]
*)

type 'a st_tree = (*Arboles estrictos*)
    Leaf of 'a 
  | Node of 'a * 'a st_tree * 'a st_tree

let lf x = Leaf x

(*
# let st6 = Node (6, lf 5, lf 11);; 
val st6 : int st_tree = Node (6, Leaf 5, Leaf 11)
# let st7 = Node (7, lf 2, st6);;         
val st7 : int st_tree = Node (7, Leaf 2, Node (6, Leaf 5, Leaf 11))
*)

let rec mirror = function 
    Leaf x -> Leaf x
  | Node (x, l, r) -> 
      Node (x, mirror r, mirror l)

(*
# mirror st7;;
- : int st_tree = Node (7, Node (6, Leaf 11, Leaf 5), Leaf 2)
*)

type 'a g_tree = (*Arboles generales*)
    Gt of 'a * 'a g_tree list 

let lf x = Gt (x, [])

(*
# let gt6 = Gt (6, [lf 5; lf 11]);;
val gt6 : int g_tree = Gt (6, [Gt (5, []); Gt (11, [])])
# let gt9 = Gt (9, [lf 4]);;        
val gt9 : int g_tree = Gt (9, [Gt (4, [])])
# let gt = Gt (2, [Gt (7, [lf 2; lf 10; gt6]); Gt (5, [gt9])]);;
val gt : int g_tree =
  Gt (2,
   [Gt (7, [Gt (2, []); Gt (10, []); Gt (6, [Gt (5, []); Gt (11, [])])]);
    Gt (5, [Gt (9, [Gt (4, [])])])])
*)

let rec num_nodes = function
    (*Gt (_, []) -> 1*) (*Esto puede sobrar porque el fold_left si la lista esta vacia devolvera 1*)
  | Gt (_, l) -> 
      List.fold_left (+) 1 (List.map num_nodes l) 

(*
# num_nodes gt;;
- : int = 10
*)

let rec num_nodes = function
    Gt (_, []) -> 1
  | Gt (x, h::t) -> 
      num_nodes h + num_nodes (Gt (x, t))

(*
# num_nodes gt
- : int = 10
*)