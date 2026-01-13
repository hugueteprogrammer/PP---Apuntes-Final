type 'a bin_tree =
    Empty
  | Node of 'a * 'a bin_tree * 'a bin_tree

type 'a t =
  'a bin_tree

let empty = Empty

let is_empty = function
    Empty -> true
  | _ -> false
  
let leaf_tree x = Node(x, Empty, Empty)

let comb x l r = Node(x, l, r) 

let root = function
    Empty -> raise (Failure "root")
  | Node(x,l,r) -> x

let left_branch = function
    Empty -> raise (Failure "left_branch")
  | Node(x,l,r) -> l

let right_branch = function
    Empty -> raise (Failure "right_branch")
  | Node(x,l,r) -> r

let rec size = function
    Empty -> 0
  | Node (_, l, r) -> 1 + size l + size r

let rec height = function 
    Empty -> 0
  | Node (_, l, r) -> 1 + max(height l) (height r)

let rec preorder = function
    Empty -> []
  | Node (x, l, r) -> [x] @ (preorder l) @ (preorder r)

let rec inorder = function
    Empty -> []
  | Node (x, l, r) -> (inorder l) @ [x] @ (inorder r)

let rec postorder = function
    Empty -> []
  | Node (x, l, r) -> (postorder l) @ (postorder r) @ [x]

let breadth t =
  let rec aux out_q in_q acc =
    match out_q with
    | [] -> 
        if in_q = [] then 
          List.rev acc (* Fin total: devolvemos el resultado enderezado *)
        else 
          (* Volcamos la entrada en la salida dándole la vuelta *)
          aux (List.rev in_q) [] acc
    | Empty :: rest -> 
      (* Si encontramos un Empty en la cola, lo ignoramos *)      
      aux rest in_q acc
            
    | Node(x, l, r) :: rest-> 
      (*Añadimos x al resultado (acc). Añadimos l y r a la pila de entrada (in_q) solo si no son Empty *)
      let q_with_l = match l with Empty -> in_q | _ -> l :: in_q in
      let q_with_lr = match r with Empty -> q_with_l | _ -> r :: q_with_l in
        
      aux rest q_with_lr (x :: acc)
  in
  (* Caso inicial *)
  match t with
  | Empty -> []
  | _ -> aux [t] [] []
  
let rec leaves = function 
    Empty -> []
  | Node (x, Empty, Empty) -> [x]
  | Node (_, l, r) -> leaves l @ leaves r

let rec find_in_depth n = function
    Empty -> raise (Not_found)
  | Node(x,l,r) -> 
      if n x then x
      else 
        try 
          find_in_depth n l
        with Not_found ->
          find_in_depth n r

let rec exists p = function
    Empty -> false
  | Node(x,l,r) -> p x || exists p l || exists p r

let rec for_all p = function
    Empty -> true
  | Node(x,l,r) -> p x && for_all p l && for_all p r

let rec map f = function
    Empty -> Empty
  | Node(x,l,r) -> Node (f x, map f l, map f r)

let rec mirror = function 
    Empty -> Empty 
  | Node (x, l, r) -> Node (x, mirror r, mirror l)