let f n = 
  if n mod 2 = 0 then n / 2 
  else 3 * n + 1

let rec length_and_top n =
  match n with
  | 1 -> (1,1)
  | _ -> 
      let (length, top) = length_and_top (f n) in 
      (1+length, max n top)    