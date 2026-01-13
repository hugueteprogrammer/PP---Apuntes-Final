(*Ejercicio 1*)
let mueve = function
  |(ori,des) when ori = 2 && ori > des-> string_of_int des ^ "<--" ^ string_of_int ori ^ "   " ^string_of_int(des+ori)^"\n"
  |(ori,des) when ori = 2 && des > ori-> string_of_int((des+ori) mod 2) ^ "   " ^ string_of_int ori ^ "-->" ^ string_of_int des^"\n"
  |(ori,des) when des = 2 && des > ori-> string_of_int ori ^ "-->" ^ string_of_int des ^ "   " ^string_of_int(des+ori)^"\n"
  |(ori,des) when des = 2 && ori > des-> string_of_int((des+ori) mod 2) ^ "   " ^ string_of_int des ^ "<--" ^ string_of_int ori^"\n"
  |(ori,des) when ori < des -> string_of_int ori ^ "---2-->" ^ string_of_int des ^ "\n"
  |(ori,des) -> string_of_int des ^ "<--2---" ^ string_of_int ori ^ "\n"
 
let otro ori des=
  6 - ori - des

let rec hanoi n ori des =
  (* n número de discos, 1 <= ori <= 3, 1 <= dest <= 3, ori <> des *)
  if n = 0 then ""
  else
    let otro = otro ori des in
    hanoi (n-1) ori otro ^ mueve (ori, des) ^ hanoi (n-1) otro des

let hanoi n ori des =
  if n = 0 || ori = des then ""
  else hanoi n ori des

let print_hanoi n ori des =
  if n < 0 || ori < 1 || ori > 3 || des < 1 || des > 3
  then print_endline "**ERROR**"
  else print_endline ("=========\n" ^
                      hanoi n ori des ^
                      "=========")

(*Ejercicio 2*)
let rec hanoi n ori des =
  (* n número de discos, 1 <= ori <= 3, 1 <= dest <= 3, ori <> des *)
  if n = 0 then ""
  else
    let otro = otro ori des in
    hanoi (n-1) ori otro ^ mueve (ori, des) ^ hanoi (n-1) otro des

let hanoi n ori des =
  if n = 0 || ori = des then ""
  else hanoi n ori des

let crono f x =
let t = Sys.time () in
let _ = f x in
Sys.time () -. t

let rec n_hanoi_mov n nd ori des = 
  if nd = 0 || ori = des then 
    (ori,des)
  else
    let otro = 6 - ori - des in
    let mitad =  1 lsl (nd-1) - 1 in
    if n <= mitad then 
      n_hanoi_mov n (nd -1) ori otro
    else if n = mitad +1 then 
      (ori, des)
    else
      n_hanoi_mov (n- mitad - 1) (nd -1) otro des

(*Calculo del tiempo*)
let () =
  for n = 20 to 25 do
    let tiempo = crono (fun x -> ignore (hanoi x 1 3)) n in
    Printf.printf "n = %d -> tiempo = %f s\n" n tiempo
  done

(*Complejidad de n_hanoi_mov*)
let () =
  let tiempo = crono (fun () ->
    for i = 1 to 1_000_000 do
      ignore (n_hanoi_mov (i mod ((1 lsl 10) - 1)) 10 1 3)
    done
  ) () in
  Printf.printf "Tiempo total (1 millón de llamadas a n_hanoi_mov): %f s\n" tiempo

(*1. Crecimiento temporal de hanoi (en segundos)
n = 20 -> tiempo = 0.909162 s
n = 21 -> tiempo = 1.899169 s
n = 22 -> tiempo = 3.746446 s
n = 23 -> tiempo = 7.990495 s
n = 24 -> tiempo = 14.809407 s
n = 25 -> tiempo = 29.646719 s
=> Se duplica aproximadamente al aumentar n en 1 → O(2^n) confirmada.*)

(*2. Complejidad de n_hanoi_mov
Tiempo total (1 millón de llamadas a n_hanoi_mov): 0.452914 s
=> O(nd) confirmada (prácticamente instantánea).*)