(*Asignaciones numéricas*)
let x = 10;;
(*val x : int = 10*)
x + 1;;
(*- : int = 11*)
let x = 1024 in x * x * x;;
(*- : int = 1073741824*)
x * x * x;;
(*- : int = 1000*)
1 + let x = 1024 in x * x * x;;
(*- : int = 1073741825*)
let y = let x = 1024 in x * x * x;;
(*val y : int = 1073741824*)
y * 3;;
(*- : int = 3221225472*)
let x = x + 1 in x * x * x;;
(*- : int = 1331*)
let x = 2 * x in let x = x + 1 in x * x * x;;
(*- : int = 9261*)

(*Asignaciones booleanas*)
not;;
(*- : bool -> bool = <fun>*)
let no = not;;
(*val no : bool -> bool = <fun>*)
no true;;
(*- : bool = false*)
no false;;
(*- : bool = true*)

(*Crear una función*)
function true -> false | false -> true;;
(*- : bool -> bool = <fun>*)

(*Ejemplos
# (function true -> false | false -> true) (2 < 3);; (*Se está aplicando al función a 2<3, que es true pero dará false por la forma de la función que cambia los resultados*)
- : bool = false
# let no = function true -> false | false -> true;; (*Se puede asignar a una variable*)
val no : bool -> bool = <fun>
# no true;;
- : bool = false
# no false;;
- : bool = true
# no (2 < 3);;
- : bool = false
*)

(*Función booleana parcial*)
let f = function true -> false;;
(*Line 1, characters 8-30:
1 | let f = function true -> false;;
            ^^^^^^^^^^^^^^^^^^^^^^
Warning 8 [partial-match]: this pattern-matching is not exhaustive.
Here is an example of a case that is not matched:
false (*da un warning pero no es un error, simplemente que hay una parte que dará error si lo queremos usar*)

val f : bool -> bool = <fun>*)

(*Ejemplo
# f true;; (*funciona*)
- : bool = false
# f false;; (*salta el error porque no está definido (excepción)*)
Exception: Match_failure ("//toplevel//", 1, 8).
*)

(*Función booleana que siempre devuelve lo mismo*)
let alwaystrue = function true -> true | false -> true;; (*siempre devuelve true*)
(*val alwaystrue : bool -> bool = <fun>*)

(*Ejemplos
# alwaystrue (3>5);; (*es falso...*)
- : bool = true (*...pero devuelve true*)
# alwaystrue ('a' = 'A');; (*es falso...*)
- : bool = true (*...pero devuelve true*)
*)

(*Función polimórfica*)
let alwaystrue = function _ -> true;; (*funcion polimórfica, se puede aplicar a cualquier valor de cualquier tipo*)
(*val alwaystrue : 'a -> bool = <fun> (*'a (alfa), indica que es una función polimórfica*)*)

(*Ejemplos
# alwaystrue 2;;
- : bool = true
# alwaystrue 3.5;;
- : bool = true
# alwaystrue "HOLA";;
- : bool = true
# alwaystrue (2/0);;
Exception: Division_by_zero.
# alwaystrue f;; (*También se puede aplicar a funciones*)
- : bool = true
*)

(*Si queremos usar el comodin pero solo con bool*)
let alwaystrue = function (_:bool) -> true;;
(*val alwaystrue : bool -> bool = <fun>*)