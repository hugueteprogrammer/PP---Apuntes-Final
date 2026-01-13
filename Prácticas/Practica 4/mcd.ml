let rec mcd (a,b) =
  match (a,b) with 
  | (0, b) -> b
  | (a, 0) -> a
  | (a, b) when a > b -> mcd (a-b, b)
  | (a, b) -> mcd (a, b-a) 

let rec mcd' (a,b) =
  match (a,b) with 
  | (0, b) -> b
  | (a, 0) -> a
  | (a, b) -> mcd' (b, a mod b)