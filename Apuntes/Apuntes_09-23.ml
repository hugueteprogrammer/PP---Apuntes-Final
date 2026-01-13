(*Función para comprobar un valor*)
let not_Zero = function 0 -> false | _ -> true;;
(*val not_Zero : int -> bool = <fun>*)
(*Ejemplos
# not_Zero 0;;
- : bool = false
# not_Zero 3;;  
- : bool = true
# not_Zero (-5);;
- : bool = true
*)

(*EL ORDEN IMPORTA. Si cambiamos el orden: *)
let otra = function _ -> true | 0 -> false;;
(*Warning 11 [redundant-case]: this match case is unused.

val otra : int -> bool = <fun>*)

(*Ejemplos
# otra 0;;
- : bool = true
# otra 3;;
- : bool = true
# otra (-5);;
- : bool = true
*)

(*Declaración de funciones algebraicas*)
(*Doble*)
let doble = function x -> 2 * x;; (*x es un nombre genérico, se puede poner cualquiera*)
(* val doble : int -> int = <fun>*)

(*Ejemplos
# doble 0;;
- : int = 0
# doble 3;;
- : int = 6
# doble (-5);;
- : int = -10
*)

(*Raíz cuadrada*)
let sqr = function y -> y*y;;
(*val sqr : int -> int = <fun>*)

(*Ejemplos
# sqr (-5);;
- : int = 25
# sqr (3);;
- : int = 9
# sqr (0);;
- : int = 0
*)

(*Aplicaciones de funciones*)
doble(sqr 5);;
(*- : int = 50*)
doble sqr 5;; (*Hay que parentizar*)
(*Error: The function doble has type int -> int (*Se esta intendo aplicar doble a sqr*)
       It is applied to too many arguments
Line 1, characters 10-11:   This extra argument is not expected.*)

(*Función identidad*)
let id = function x -> x;; (*No tiene valor con lo cual se puede aplicar a cualquier cosa*)
(*val id : 'a -> 'a = <fun>*)

(*Ejemplos
# id 4;;
- : int = 4
# id 3.2;;
- : float = 3.2
# id "hola";;
- : string = "hola"
# id doble;;
- : int -> int = <fun>
# id doble 5;;
- : int 10
# id (doble 5);;
- : int 10
# (id doble) (id 5);;
- : int 10
*)