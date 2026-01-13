let rec fib n = 
  if n <= 2 then 1
  else fib (n-1) + fib (n-2)

let fibto n =
  let rec aux acu cnt n =
    let result = fib cnt 
    in 
        match n with
        | n when n > result -> 
          if acu = "" then 
            aux (acu ^ "" ^ string_of_int(result)) (cnt+1) n
          else 
            aux (acu ^ ", " ^ string_of_int(result)) (cnt+1) n
        | n when n <= result -> acu 
        | _ -> ""
  in 
  aux "" 1 n

let () =
  if Array.length Sys.argv<2 then 
    print_endline "Invalid number of arguments"
  else 
    print_string (fibto (int_of_string Sys.argv.(1)))