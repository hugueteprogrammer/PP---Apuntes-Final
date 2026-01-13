(*Orden en el que se declaran las listas*)
[1;2;3];;
(*- : int list = [1; 2; 3]*)
1::(2::(3::[]));;
(*- : int list = [1; 2; 3]*)
1::2::3::[];;
(*- : int list = [1; 2; 3]*)

(*head y tail en listas*)
let hd (h::_) = h;;
(*Warning 8 [partial-match]: this pattern-matching is not exhaustive.
Here is an example of a case that is not matched:
[]

val hd : 'a list -> 'a = <fun>*)

let tl (_::t) = t;;
(*Warning 8 [partial-match]: this pattern-matching is not exhaustive.
Here is an example of a case that is not matched:
[]

val tl : 'a list -> 'a list = <fun>*)

(*Ejemplos
# hd [1;2;3];;
- : int = 1
(*Si está vacía, da un error de ejecucion*)
# hd [];; 
Exception: Match_failure ("//toplevel//", 1, 7).
*)

tl [1;2;3];;
(*- : int list = [2; 3]*)

tl [];;
(*Exception: Match_failure ("//toplevel//", 1, 7).*)

(*Función raise*)
raise;;
(*- : exn -> 'a = <fun>*)

let hd = function
  [] -> raise (Failure "hd")
  |h::_ -> h;;
(*val hd : 'a list -> 'a = <fun>*)

let tl = function
  [] -> raise (Failure "tl")
  |_::t -> t;;
(*val tl : 'a list -> 'a list = <fun>*)