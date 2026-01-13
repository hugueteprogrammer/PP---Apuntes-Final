val i_prod : int list -> int
(* i_prod l devuelve el producto de todos los elementos de l *)

val f_prod : float list -> float
(* f_prod l devuelve el producto de todos los elementos de l *)

val lmin : 'a list -> 'a
(* devuelve el mínimo de una lista *)

val lmin_lmax : 'a list -> 'a * 'a
(* devuelve un par con el mínimo y el máximo de una lista (en ese orden) *)

val last : 'a list -> 'a
(* devuelve el último elemento de una lista *)

val rev : 'a list -> 'a list
(* rev l = List.rev l *)

val rev_append : 'a list -> 'a list -> 'a list
(* rev_append l = List.rev_append l *)

val rev_map : ('a -> 'b) -> 'a list -> 'b list
(* rev_map f l = List.rev_map f l *)

val concat : string list -> string
(* concat sl = String.concat "" sl *)