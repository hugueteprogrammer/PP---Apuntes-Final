type 'a st_bin_tree =
    Leaf of 'a
  | Node of 'a st_bin_tree * 'a * 'a st_bin_tree

type 'a t = 'a st_bin_tree

let leaf_tree x = Leaf x

let is_leaf = function
    Leaf x -> true
  | _ -> false

let comb x l r = Node(l, x, r)

let root = function
    Leaf x -> x  
  | Node(l,x,r) -> x

let left_branch = function
    Leaf _ -> raise (Failure "left_branch")
  | Node(l,_,_) -> l

let right_branch = function
    Leaf _ -> raise (Failure "right_branch")
  | Node(_,_,r) -> r

let rec size = function
    Leaf x -> 1
  | Node (l, _, r) -> 1 + size l + size r

let rec height = function 
    Leaf x -> 1
  | Node (l, _, r) -> 1 + max(height l) (height r)

let rec preorder = function
    Leaf x -> [x]
  | Node (l, x, r) -> [x] @ (preorder l) @ (preorder r)

let rec inorder = function
    Leaf x -> [x]
  | Node (l, x, r) -> (inorder l) @ [x] @ (inorder r)

let rec postorder = function
    Leaf x -> [x]
  | Node (l, x, r) -> (postorder l) @ (postorder r) @ [x]

let breadth t =
  let rec aux out_q in_q acc =
    match out_q with
    | [] -> 
        (* Caso 1: Se acabó la lista de salida *)
        if in_q = [] then 
          List.rev acc (* Fin total: devolvemos el resultado enderezado *)
        else 
          (* Volcamos la entrada en la salida dándole la vuelta *)
          aux (List.rev in_q) [] acc

    | t :: rest -> 
        (* Caso 2: Procesamos el primer árbol de la cola *)
        match t with
        | Leaf x -> 
            (* Guardamos x en acc y seguimos. No hay hijos que añadir *)
            aux rest in_q (x :: acc)
            
        | Node(l, x, r) -> 
            (* Guardamos x en acc.*)
            aux rest (r :: l :: in_q) (x :: acc)
  in
  aux [t] [] []

let rec leaves = function 
    Leaf x -> [x]
  | Node (l, _, r) -> leaves l @ leaves r

let rec find_in_depth n = function
    Leaf x -> 
      if n x then x
      else raise (Not_found)
  | Node(l,x,r) -> 
      if n x then x
      else 
        try 
          find_in_depth n l
        with Not_found ->
          find_in_depth n r

let rec exists p = function
    Leaf x -> p x 
  | Node(l,x,r) -> p x || exists p l || exists p r

let rec for_all p = function
    Leaf x -> p x
  | Node(l,x,r) -> p x && for_all p l && for_all p r

let rec map f = function
    Leaf x -> Leaf (f x)
  | Node(l,x,r) -> Node (map f l, f x, map f r)

let rec mirror = function 
    Leaf x -> Leaf x
  | Node (l, x, r) -> 
      Node (mirror r, x, mirror l)

let rec to_bin = function
    Leaf x -> 
        BinTree.comb x (BinTree.empty) (BinTree.empty)
    | Node(l, x, r) -> 
        BinTree.comb x (to_bin l) (to_bin r)

let rec from_bin t = 
  if BinTree.is_empty t then 
    raise (Failure "from_bin") 
  else
    let l = BinTree.left_branch t in
    let r = BinTree.right_branch t in
    let x = BinTree.root t in

    if BinTree.is_empty l && BinTree.is_empty r then 
      Leaf x
    else if not (BinTree.is_empty l) && not (BinTree.is_empty r) then
      Node (from_bin l, x, from_bin r)
    else 
      raise(Failure "from_bin");;