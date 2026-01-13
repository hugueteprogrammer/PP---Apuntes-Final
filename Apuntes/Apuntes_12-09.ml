(*ARRAYS*)
let v = [|1;2;3|];;
(*val v : int array = [|1; 2; 3|]*)
(*# v.(0);;
- : int = 1*)

Array.length;;
(*- : 'a array -> int = <fun>*)
Array.length v;;
(*- : int = 3*)
Array.get;;
(*- : 'a array -> int -> 'a = <fun>*)
Array.get v 1;;
(*- : int = 2*)
Array.set;;
(*- : 'a array -> int -> 'a -> unit = <fun>*)
Array.set v 1 100;;
(*- : unit = ()*)
v;;
(*- : int array = [|1; 100; 3|]*)
v.(1) <- 200;;
(*- : unit = ()*)
v;;
(*- : int array = [|1; 200; 3|]*)
Array.make;; 
(*- : int -> 'a -> 'a array = <fun>*)
Array.make 10 0;;
(*- : int array = [|0; 0; 0; 0; 0; 0; 0; 0; 0; 0|]*)
Array.init;;
(*- : int -> (int -> 'a) -> 'a array = <fun>*)
let v = Array.init 10 (function _ -> Random.int 100);;
(*val v : int array = [|54; 62; 10; 65; 96; 61; 95; 37; 83; 34|]*)
compare;;
(*- : 'a -> 'a -> int = <fun>*)
Array.sort;;
(*- : ('a -> 'a -> int) -> 'a array -> unit = <fun>*)
Array.sort compare v;;
(*- : unit = ()*)
v;;
(*- : int array = [|10; 34; 37; 54; 61; 62; 65; 83; 95; 96|]*)
let v = Array.init 10 (function _ -> Random.int 100);;
(*val v : int array = [|98; 95; 44; 34; 6; 28; 80; 58; 16; 38|]*)
Array.copy v;;
(*- : int array = [|98; 95; 44; 34; 6; 28; 80; 58; 16; 38|]*)
let w = Array.copy v;;
(*val w : int array = [|98; 95; 44; 34; 6; 28; 80; 58; 16; 38|]*)
Array.sort compare w;;
(*- : unit = ()*)
w;;
(*- : int array = [|6; 16; 28; 34; 38; 44; 58; 80; 95; 98|]*)
v;;
(*- : int array = [|98; 95; 44; 34; 6; 28; 80; 58; 16; 38|]*)

let vprod v1 v2 = 
  if Array.length v1 = Array.length v2 then
    let p = ref 0 in
    for i = 0 to Array.length v1 - 1 do
      p := !p + v1.(i) * v2.(i)
    done;
    !p
  else 
    raise(Invalid_argument "vprod");;
(*Ejemplos
# vprod v w;;
- : int = 34005
# vprod v [||];;
Exception: Invalid_argument "vprod".
*)

(*REGISTROS*)
type persona = {nombre : string; edad: int};;
(*type persona = { nombre : string; edad : int; }*)
{nombre="Jose"; edad = 17};;
(*- : persona = {nombre = "Jose"; edad = 17}*)
{nombre="Jose"; edad = 17}.nombre;;
(*- : string = "Jose"*)
{nombre="Jose"; edad = 17}.edad;;
(*- : int = 17*)

let p1 = {nombre ="Jose"; edad = 17};;
(*val p1 : persona = {nombre = "Jose"; edad = 17}*)
let p2 = {nombre = "Maria"; edad = 19};;
(*val p2 : persona = {nombre = "Maria"; edad = 19}*)

p1.nombre;;
(*- : string = "Jose"*)
p2.nombre;;
(*- : string = "Maria"*)

let otra_mas_vieja p =
  {nombre = p.nombre; edad = p.edad + 1};;
(*val otra_mas_vieja : persona -> persona = <fun>*)
let otra_mas_vieja p =
  {p with edad = p.edad + 1};;
(*val otra_mas_vieja : persona -> persona = <fun>*)

otra_mas_vieja p1;;
(*- : persona = {nombre = "Jose"; edad = 18}*)

type persona =
  {nombre: string; mutable edad: int};;
(*type persona = { nombre : string; mutable edad : int; }*)
let envejece p =
  p.edad <- p.edad+1;;
(*val envejece : persona -> unit = <fun>*)

let p1 = {nombre = "Jose"; edad = 17};;
(*val p1 : persona = {nombre = "Jose"; edad = 17}*)
envejece p1;;
(*- : unit = ()*)
p1;;
(*- : persona = {nombre = "Jose"; edad = 18}*)

type 'a ref = {mutable contents : 'a}
(*type 'a ref = { mutable contents : 'a; }*)
let ref x = {contents = x}
(*val ref : 'a -> 'a ref = <fun>*)
let (!) v = v.contents
(*val ( ! ) : 'a ref -> 'a = <fun>*)
let (:=) v x = v.contents <- x
(*val ( := ) : 'a ref -> 'a -> unit = <fun>*)

module Counter : sig
  val next : unit -> int
  val reset : unit -> unit
end = 
  struct 
  let n = ref 0
  let next () = n := !n + 1; !n
  let reset () = n := 0
end

let c1 = object
  val mutable n = 0
  method next = n <- n+1; n
  method reset = n <- 0
end
