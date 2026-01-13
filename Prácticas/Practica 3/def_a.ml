let pi = 3.141592653589793

let e = 2.718281828459045

let max_int_f = float_of_int max_int

let perimeter r = (2.0 *. r *. pi)

let area r = (pi *. r *. r)

let next_char c = Char.chr(Char.code c+1)

let abs_f x = if x < 0. then -.x else x

let odd c = if 2*c-1 = 0 then true else false 

let next_5_mult n = 5 * ((n/5) + 1)

let is_letter c = if ('a'<=c && c<='z')||('A'<=c && c<='Z') then true else false

let string_of_bool b = if b then "true" else "false"