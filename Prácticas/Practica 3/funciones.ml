let rec sum_to n = 
  if n <= 0 then 0
  else n + sum_to(n-1);;

let rec exp_2 n =
  if n = 0 then 1 
  else 2 * exp_2(n-1)

let rec num_cifras n = 
  if (n < 10) then 1 
  else 1 + num_cifras(n/10)

let rec sum_cifras n = 
  if n < 10 then n 
  else (n mod 10) + sum_cifras (n/10)