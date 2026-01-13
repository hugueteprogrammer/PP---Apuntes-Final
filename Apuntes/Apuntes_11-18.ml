type maybe_an_int = Some of int | None
	
let (//) x y =
	match (x, y) with
	    Some _, Some 0 -> None
    | Some a, Some b -> Some (a/b)
    | _ -> None
	
type booleano = V | F

let(&&&) b1 b2 =
	match (b1, b2) with
	V, V-> F
    | _ -> F
	
let (||||) b1 b2 =
	match (b1,b2) with
	    V, _ | _, V -> V
    | _ -> F
	
type palo = 
	  Pica
  | Trebol of unit 
  | Corazon of unit 
  | Diamante of unit
	
(*Pica()*)

type otro_int = Int of int 

type double_int = L of int | R of int

type numero = I of int | F of float

let rec suma n1 n2 =
	match n1, n2 with
	  I x, I y -> I (x + y)
  | F x, F y -> F (x +. y)
  | I x, F y -> F (float_of_int x +. y)
  | _ -> suma n2 n1
	
type maybe_an_int = Some_i of int | None_i
	
type maybe_an_string = Some_s of int | None_s
	
type maybe_an_float = Some_f of int | None_f
	
type 'a option = Some of 'a | None
	
type nat = Z | S of nat
(*podemos definir operaciones para este nuevo dato, pero no van a ser eficientes*)

let rec sum n1 = function
	  Z -> n1
  | S n2 -> sum (S n1) n2
      
let rec nat_of_int = function
	  0 -> Z
  | n -> S (nat_of_int (n-1))
      	   
let rec nat_of_int n = 
  if n < 0 then raise (Failure "nat_of_int")
  else if n = 0 then Z
  else S (nat_of_int (n-1))