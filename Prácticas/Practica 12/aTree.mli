type 'a a_tree = 'a option array
type 'a t = 'a a_tree

val from_bin : 'a BinTree.t -> 'a t
val breadth : 'a t -> 'a list
val mem : ('a -> 'a -> bool) -> 'a -> 'a t -> bool
