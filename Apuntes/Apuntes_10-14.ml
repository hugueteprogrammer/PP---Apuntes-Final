let rec fib2 = function
  0 -> 0, 1
  | n -> let f1, f2 = fib2 (n-1) in 
         f1 + f2, f1;;
(*val fib2 : int -> int * int = <fun>*)

let fib n =
  fst (fib2 n);;
(*val fib : int -> int = <fun>*)

(*Ejemplos
# fib 10;;
- : int = 55
# fib 40;;
- : int = 102334155
# fib 100;;
- : int = 3736710778780434371
# fib 126;;
- : int = 536354571351657128
# fib 91;;
- : int = -4563325426479245499
*)

(*Llamada recursiva doble*)
let fib n = 
  let rec fib2 = function
    0 -> 0, 1
  | n -> let f1, f2 = fib2 (n-1) in 
         f1 + f2, f1
in fst (fib2 n);;
(*val fib2 : int -> int * int = <fun>*)

(*Ejemplos
# fib 10;;
- : int = 55
# fib 20;;
- : int = 6765
*)

(*LISTAS*)
[1;2;3;4];;
(*- : int list = [1; 2; 3; 4]*)
[1;2];;    
(*- : int list = [1; 2]*)
[1];;  
(*- : int list = [1]*)

[1;2.5];; (*En una lista todos los valores tienen que ser del mismo tipo*)
(*Error: The constant 2.5 has type float but an expression was expected of type int*)

List.length;; (*Función de la longitud de la lista*)
(*- : 'a list -> int = <fun>*)

(*Ejemplo*)
let l = ['a';'e';'i';'o';'u'];;
(*val l : char list = ['a'; 'e'; 'i'; 'o'; 'u']
# List.length l;;
- : int = 5*)

[];; (*LISTA VACÍA*)
(*- : 'a list = []*)
List.length [];; (*Y su longitud es 0*)
(*- : int = 0*)

List.tl;; (*Quita el primer elemento*)
(*- : 'a list -> 'a list = <fun>*)

(*Ejemplo
# List.tl l;;
- : char list = ['e'; 'i'; 'o'; 'u']
*)

List.hd;; (*Devuelve el primer elemento*)
(*- : 'a list -> 'a = <fun>*)
List.hd l;;
(*- : char = 'a'*)

List.hd [];; (*No tiene valores, con lo cual da un error de ejecucion*)
(*Exception: Failure "hd".*)
List.tl [];; (*Lo mismo para tl*)
(*Exception: Failure "tl".*)

List.append [1;2;3] [4;5];; (*append junta dos listas*)
(*- : int list = [1; 2; 3; 4; 5]*)

List.init;; (*Inicializar listas*)
(*- : int -> (int -> 'a) -> 'a list = <fun>*)

(*Ejemplos
# List.init 5 (function x->x);;
- : int list = [0; 1; 2; 3; 4]
# List.init 5 (function x->0);;
- : int list = [0; 0; 0; 0; 0]
# List.init 5 (function x->x*2);;
- : int list = [0; 2; 4; 6; 8]
*)