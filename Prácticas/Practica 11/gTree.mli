type 'a g_tree = (*OK*)
    Gt of 'a * 'a g_tree list

type 'a t = 'a g_tree (*OK*)

val leaf_tree : 'a -> 'a t (*OK*)

val root : 'a t -> 'a (*OK*)

val branches : 'a t -> 'a t list (*OK*)

val size : 'a t -> int (*OK*)

val height : 'a t -> int (*OK*)
(* altura o número de niveles; 1 si tiene solo un nodo *)

val preorder : 'a t -> 'a list (*OK*)

val postorder : 'a t -> 'a list (*OK*)
 
val breadth : 'a t -> 'a list (*OK*)

val leaves : 'a t -> 'a list (*OK*)

val find_in_depth : ('a -> bool) -> 'a t -> 'a (*OK*)

val breadth_find :  ('a -> bool) -> 'a t -> 'a (*OK*)

val exists : ('a -> bool) -> 'a t -> bool (*OK*)

val for_all : ('a -> bool) -> 'a t -> bool (*OK*)

val map : ('a -> 'b) -> 'a t -> 'b t (*OK*)

val mirror : 'a t -> 'a t

val from_bin : 'a BinTree.t -> 'a t
(* no inyectiva (no reversible) *)
(* lanza Failure "from_bin" si el árbol es vacío *)

val from_st_bin : 'a StBinTree.t -> 'a t