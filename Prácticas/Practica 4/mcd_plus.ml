let rec mcd_pasos (a,b) = 
  let rec aux (x, y) pasos =
    if y = 0 then (x, pasos +1)
    else aux (y, x mod y) (pasos +1)
  in 
  aux (a,b) 0