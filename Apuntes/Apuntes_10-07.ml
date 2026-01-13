(*funciones curry*)
let suma x y = x + y;;
(*val suma : int -> int -> int = <fun>*)
(*Ejemplos
# suma 3;;
- : int -> int = <fun>
# suma 3 5;;
- : int = 8
# (+);;
- : int -> int -> int = <fun>
# (=);;
- : 'a -> 'a -> bool = <fun>
# (<=);;
- : 'a -> 'a -> bool = <fun>
*)

(*NO HACER*)
let pos = function x -> if x >= 0 then true else false;;
(*val pos : int -> bool = <fun>*)
(*MEJOR*)
let pos = function x -> x >= 0;;
(*val pos : int -> bool = <fun>*)
(*O (curryficada)*)
let pos = (<=) 0;;
(*val pos : int -> bool = <fun>*)

(*Ejemplos
# pos 0;;
- : bool = true
# pos 3;;
- : bool = true
# pos (-5);;
- : bool = false
*)

(*tuplas*)
true, 3, "trio";;
(*- : bool * int * string = (true, 3, "trio")*)
(true, 3), "trio";;
(*- : (bool * int) * string = ((true, 3), "trio")*)
let p = (true, 3), "trio";;
(*val p : (bool * int) * string = ((true, 3), "trio")*)
let x, y = p;;
(*val x : bool * int = (true, 3)
val y : string = "trio"*)
(*Funcion fst (first) y Funcion snd (second)*)
fst;;
(*- : 'a * 'b -> 'a = <fun>*)
fst p;;
(*- : bool * int = (true, 3)*)
snd;;
(*- : 'a * 'b -> 'b = <fun>*)
snd p;;
(*- : string = "trio"*)
snd (fst p);;
(*- : int = 3*)

snd fst p;;
(*Error: The value fst has type 'a * 'b -> 'a
       but an expression was expected of type 'c * ('d -> 'e)*)


(*RECURSIVIDAD*)
let fact n = (*Falta algo aquí*)
  if n = 0 then 1
  else n * fact (n-1)
(*Error: Unbound value fact*)


(*Forma correcta*)
let rec fact n = 
  if n = 0 then 1
  else n * fact (n-1);;

(*Ejemplos
# fact 3;;
- : int = 6
# fact 5;;
- : int = 120
# fact 21;;
- : int = -4249290049419214848 (*da este valor porque la pila de ints da la vuelta*) 
# fact 63;; (*Este es máximo que cabe sin que el resultado te de 0, a partir de aqui siempre da 0*)
- : int = 1585267068834414592
# fact 100;;
- : int = 0
# fact (-5);; (*Nunca llega a la condicion de parada*)
Stack overflow during evaluation (looping recursion?).
*)