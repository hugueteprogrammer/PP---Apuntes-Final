let fact n = 
  let f = ref 1 and i = ref 1 in 
  while !i <= n do 
    f := !f * !i;
    i := !i + 1
  done;
  !f

(*
# fact 5;;
- : int = 120
*)

let n = ref 0;;
let turno () =
  n := !n + 1;
  !n
(*
# turno();;
- : int = 1
# turno();;
- : int = 2
# turno();;
- : int = 3
# turno();;
- : int = 4
*)

let reset () =
  n := 0
(*
# reset();;
- : unit = ()
# turno();;
- : int = 1
# turno();;
- : int = 2
*)

let turno () = 
  let n = ref 0 in
  n := !n + 1;  
  !n
(*
val turno : unit -> int = <fun>
# turno();;
- : int = 1
# turno();;
- : int = 1
# turno();;
- : int = 1
*)

let turno = 
  let n = ref 0 in
  function () ->
    n := !n + 1;  
    !n

let turno, reset = 
  let n = ref 0 in
  (function () -> n := !n + 1; !n),
  (function () -> n := 0)

(*
# turno ();;
- : int = 1
# turno ();;
- : int = 2
# reset ();;
- : unit = ()
# turno ();;
- : int = 1
*)

(*MÓDULOS*)

module Counter : sig
  val turno : unit -> int
  val reset : unit -> unit
end = 
struct
  let n = ref 0

  let turno () = 
    n := !n + 1; !n

  let reset () = 
    n := 0
end

(*
# Counter.turno();;
- : int = 1
# Counter.turno();;
- : int = 2
# Counter.reset();;
- : unit = ()
# Counter.turno();;
- : int = 1
*)

module IntPair = struct
  type t = int * int
  let compare = compare
end
(*module IntPair : sig type t = int * int val compare : 'a -> 'a -> int end*)