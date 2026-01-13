open BinTree
type 'a a_tree = 'a option array
type 'a t = 'a a_tree

let rec height t =
  if BinTree.is_empty t then -1
  else 1 + max (height (BinTree.left_branch t)) (height (BinTree.right_branch t))

let from_bin tree =
  (*1.Calculamos la altura para saber el tamaño del array: 2^(h+1) - 1*)
  let h = height tree in
  let size = int_of_float (2. ** float_of_int (h + 1)) - 1 in
  let arr = Array.make size None in
  (*2.Función auxiliar recursiva para rellenar el array*)
  let rec fill t index =
    if not (BinTree.is_empty t) && index < size then begin
      arr.(index) <- Some (BinTree.root t);
      fill (BinTree.left_branch t) (2 * index + 1);
      fill (BinTree.right_branch t) (2 * index + 2)
    end
  in
  fill tree 0;
  arr

let breadth arr =
  let result = ref [] in
  (*Recorremos el array linealmente*)
  for i = 0 to Array.length arr - 1 do
    match arr.(i) with
    | Some x -> result := x :: !result
    | None -> ()
  done;
  List.rev !result

let mem ord elem arr =
  let len = Array.length arr in
  let index = ref 0 in
  let found = ref false in
  let continue = ref true in

  while !continue && !index < len do
    match arr.(!index) with
    | None -> 
        (*Si llegamos a un hueco vacío, el elemento no está*)
        continue := false
    | Some x ->
        if x = elem then 
          (*Elemento encontrado*)
          (found := true; continue := false)
        else if ord elem x then 
          (*Si elem < x, vamos al hijo izquierdo: 2*i + 1*)
          index := 2 * !index + 1
        else 
          (*si elem > x, vamos al hijo derecho: 2*i + 2*)
          index := 2 * !index + 2
  done;
  !found