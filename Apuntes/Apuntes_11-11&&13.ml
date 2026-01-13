(*11/11/2025*)

(*int -> (int*int) list option*)

let come (i1, j1) (i2, j2) =
  i1 = i2 ||  (*Misma fila*)
  j1 = j2 ||  (*Misma columna*)
  abs(i2-i1) = abs(j2-j1) (*Misma diagonal*)

(*Ejemplos

# come (1,3) (1,5);;                            
- : bool = true
# come (4,4) (2,1);;
- : bool = false
*)

let rec compatible c = function
    [] -> true 
  | h::t -> not (come c h) && compatible c t

let reinas n = 
  let rec aux camino (i, j) = 
    if i > n then Some camino
    else if j > n then None
      else if compatible (i, j) camino then 
        match aux ((i,j)::camino) (i+1, 1) with
            None -> aux camino (i, j+1)
          | Some l -> Some l 
      else aux camino (i, j+1) 
  in aux [] (1,1)

(*Ejemplos

# reinas 0;;
- : (int * int) list option = Some []
# reinas 8;;
- : (int * int) list option =
Some [(8, 4); (7, 2); (6, 7); (5, 3); (4, 6); (3, 8); (2, 5); (1, 1)]
# reinas 20;;
- : (int * int) list option =
Some
 [(20, 11); (19, 6); (18, 14); (17, 7); (16, 10); (15, 8); (14, 19);
  (13, 16); (12, 9); (11, 17); (10, 20); (9, 18); (8, 12); (7, 15); (6, 13);
  (5, 4); (4, 2); (3, 5); (2, 3); (1, 1)]
# reinas 3;;
- : (int * int) list option = None
*)

(*13/11/2025*)

type exn =
    Division_by_zero
  | Not_found
  | Failure of string
  | Reinas

(*exception Reinas of ...*)

let tl' = function
    _::t -> t
  | [] -> []

let tl' l =
  try 
    List.tl l
  with
    Failure _ -> [] 

(*int -> (int*int) list*)

let reinas n = 
  let rec aux camino (i, j) = 
    if i > n then camino
    else if j > n then raise Not_found
      else if compatible (i, j) camino then 
        try aux ((i,j)::camino) (i+1, 1) with
            Not_found -> aux camino (i, j+1)
      else aux camino (i, j+1) 
  in aux [] (1,1)

(*Ejemplos

# reinas 0;;
- : (int * int) list = []
# reinas 1;;
- : (int * int) list = [(1, 1)]
# reinas 2;;
Exception: Not_found.
# reinas 20;;
- : (int * int) list =
[(20, 11); (19, 6); (18, 14); (17, 7); (16, 10); (15, 8); (14, 19); (13, 16);
 (12, 9); (11, 17); (10, 20); (9, 18); (8, 12); (7, 15); (6, 13); (5, 4);
 (4, 2); (3, 5); (2, 3); (1, 1)]
*)