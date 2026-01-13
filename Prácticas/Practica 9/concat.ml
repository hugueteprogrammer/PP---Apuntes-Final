(*Ejercicio 1*)
let concat l =
  let rec aux acc = function
      [] -> acc
    | h::t -> aux (List.append acc h) t
  in aux [] l

let concat l =
  List.fold_left (fun acc h -> List.append acc h) [] l

(* EXPLICACIÓN DE LA INEFICIENCIA DE LOS ALGORITMOS ANTERIORES:

  En el primer algoritmo, el problema se de debe al coste de la función List.append. 
  En OCaml, las listas son enlazadas simples y para concatenar dos listas, el programa
  debe recorrer completamente la primera para llegar al final y enlazarla con la segunda
  El coste es proporcional a la longitud de la primera lista.
  
  En el segundo algoritmo, al usar List.fold_left de la manera que aparece, el acumulador (acc) 
  actúa como la primera lista en el append: Al principio está vacío, luego tiene todos los 
  elementos de la primera lista y por último, a medida que avanza el fold, acc se hace más grande
  Para añadir la última lista, Ocaml debe recorrer todos los elementos que ya ha concatenado 
  anteriormente y esto resulta en tiempos muy altos para listas grandes.
  
*)

let concat' l =
  List.fold_right (fun acc h -> List.append acc h) l []

(* ¿Por qué fold_right será mejor?
  
  Cuando se implementa el algoritmo con fold_right, el orden se invierte: h :: (resto).
  Como se añade al principio los nuevos elementos de la lista concatenada o se procesan de derecha a 
  izquierda manteniendo la estructura, evitan reconstruir el acumulador una y otra vez como primer argumento

*)

let concat'' l =
  let rec aux acu = function
      [] -> List.rev acu
    | h :: t ->
      aux (List.rev_append h acu) t
    in
    aux [] l

(*Ejercicio 2*)

let rec sublists = function
    [] -> [[]]
  | h :: t -> 
      let subs = sublists t in 
      let with_h = List.map (fun s -> h :: s) subs in
      List.append subs with_h