(* === Curry y Uncurry === *)

let curry f = fun x y -> f (x, y)

let uncurry f = fun (x, y) -> f x y

(*
uncurry (+);;
let sum = uncurry (+);;
sum (2,1);;

let g = curry (function p -> 2 * fst p + 3 * snd p);;
let h = g 2;;
h 1, h 2, h 3;;

Resultados esperados: (7, 10, 13) 
*)

(* === Composición === *)

let comp f g = fun x -> f (g x)

(*
let f = let square x = x * x in comp square ((+) 1);;
f 1, f 2, f 3;;

Resultados esperados: (4, 9, 16)
*)

(* === Polimorfismo === *)

let i x = x
let j (x, _) = x
let k (_, y) = y
let l x = [x]

(*
i : 'a -> 'a       - 1 posible (identidad)
j : 'a * 'b -> 'a  - 1 posible
k : 'a * 'b -> 'b  - 1 posible
l : 'a -> 'a list  - infinitas posibles funciones
*)

