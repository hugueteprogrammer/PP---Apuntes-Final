type 'a t (*OK*)
(* el tipo para representar árboles binarios con nodos etiquetados con
   valores de tipo 'a *)

val empty : 'a t (*OK*)
(* el árbol vacío *)

val is_empty : 'a t -> bool (*OK*)

val leaf_tree : 'a -> 'a t (*OK*)
(* construye un árbol con un solo nodo (árbol hoja) *)

val comb : 'a -> 'a t -> 'a t -> 'a t (*OK*)
(* comb x l r construye un árbol con raiz x, rama izquierda l y rama
   derecha r *)

val root : 'a t -> 'a (*OK*)
(* devuelve la etiqueta o valor de la raíz;
   lanza Failure "root" si el árbol es vacío *)

val left_branch : 'a t -> 'a t (*OK*)
(* devuelve la rama izquierda;
   lanza Failure "left_branch" si el árbol es vacío *)

val right_branch : 'a t -> 'a t (*OK*)
(* devuelve la rama derecha;
   lanza Failure "right_branch" si el árbol es vacío *)

val size : 'a t -> int (*OK*)
(* número de nodos *)

val height : 'a t -> int (*OK*)
(* altura o número de niveles; 0 para el árbol vacío; 1 si tiene solo
   un nodo *)

val preorder : 'a t -> 'a list (*OK*)
(* primero la raíz *)

val inorder : 'a t -> 'a list (*OK*)
(* la raíz entre las ramas *)

val postorder : 'a t -> 'a list (*OK*)
(* la raíz al final *)

val breadth : 'a t -> 'a list (*OK*)

(* enumeración de los nodos del árbol "en anchura", es decir,
   recorrido por niveles y de izquierda a derecha *)

val leaves : 'a t -> 'a list (*OK*)
(* lista de hojas de izquierda a derecha *)

val find_in_depth : ('a -> bool) -> 'a t -> 'a (*OK*)
(* busca en profundidad (priorizando las ramas izquierdas) un nodo que
   satisfaga el predicado;
   lanza Not_found si ninguno lo satisface *)

val exists : ('a -> bool) -> 'a t -> bool (*OK*)

val for_all : ('a -> bool) -> 'a t -> bool (*OK*)

val map : ('a -> 'b) -> 'a t -> 'b t (*OK*)

val mirror : 'a t -> 'a t (*OK*)
(* imagen especular *)