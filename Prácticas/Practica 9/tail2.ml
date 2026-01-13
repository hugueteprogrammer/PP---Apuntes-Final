let rec front = function
    [] -> raise (Failure "front")
  | [_] -> []
  | h :: t -> h :: (front t [@tail_mod_cons])

let rec compress = function
  | h1 :: (h2 :: _ as t) -> 
      if h1 = h2 then 
        compress t
      else 
        h1 :: (compress t [@tail_mod_cons])
  | smaller -> smaller

(* 
  No es posible aplicar TMC a fold_right. TMC solo funciona cuando la llamada
  recursiva es el argumento directo de un constructor de datos (como ::).
  En fold_right, la llamada recursiva es un argumento de la función 'f' 
  (f h (fold_right ...)), por lo que el compilador no puede optimizarlo.

  Se copia la implementación de tail.ml para cumplir con la interfaz .mli
*)

let fold_right f l a =
  let rec aux acu = function
      [] -> acu
    | h :: t -> aux (f h acu) t
  in
  aux a (List.rev l) 