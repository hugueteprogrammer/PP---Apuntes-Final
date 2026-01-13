val is_bst : ('a -> 'a -> bool) -> 'a BinTree.t -> bool

val mem : ('a -> 'a -> bool) -> 'a -> 'a BinTree.t -> bool

val add : ('a -> 'a -> bool) -> 'a -> 'a BinTree.t -> 'a BinTree.t

val remove : ('a -> 'a -> bool) -> 'a -> 'a BinTree.t -> 'a BinTree.t