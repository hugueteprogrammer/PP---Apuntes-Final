(* Abstract syntax for a simple C language *)

(* Context management *)

type context =
  (string * float) list

exception No_binding of string

let empty_context =
  []

let get_binding ctx s =
  try List.assoc s ctx with
    Not_found -> raise (No_binding s)

let add_binding ctx s v =
  (s, v) :: List.remove_assoc s ctx

(* Syntax trees and support functions for arithmetic expressions,
   boolean expressiones and statements *)

(* Arithmetic expressions *)

type arith_oper =
    Opp

type arith_bi_oper =
    Sum | Sub | Prod | Div | Mod

type arith =
    C of float
  | Var of string
  | Arith_op of arith_oper * arith
  | Arith_bi_op of arith_bi_oper * arith * arith

let arith_op1_fun = function
    Opp -> (function x -> -.x)

let arith_op2_fun = function
    Sum  -> (+.)
  | Sub  -> (-.)
  | Prod -> ( *. )
  | Div  -> (/.)
  | Mod  -> (mod_float)

let rec eval ctx = function
    C f ->
      f
  | Var s ->
      get_binding ctx s
  | Arith_op (op, e) ->
      (arith_op1_fun op) (eval ctx e)
  | Arith_bi_op (op, e1, e2) ->
      (arith_op2_fun op) (eval ctx e1) (eval ctx e2)

(* Boolean expressions *)

type boolean_oper =
    Not

type boolean_bi_oper =
    Or | And

type comp =
    Equal | Not_equal | Less | Less_equal | Greater | Greater_equal

type boolean =
    B of bool
  | Boolean_op of boolean_oper * boolean
  | Boolean_bi_op of boolean_bi_oper * boolean * boolean
  | Comp of comp * arith * arith

let boolean_op1_fun = function
    Not -> not

let boolean_op2_fun = function
    Or -> (||)
  | And -> (&&)

let comp_fun = function
    Equal -> (=)
  | Not_equal -> (<>)
  | Less -> (<)
  | Less_equal -> (<=)
  | Greater -> (>)
  | Greater_equal -> (>=)

let rec test ctx = function
    B b ->
      b
  | Boolean_op (op, e) ->
      (boolean_op1_fun op) (test ctx e)
  | Boolean_bi_op (op, e1, e2) ->
      (boolean_op2_fun op) (test ctx e1) (test ctx e2)
  | Comp (c, a1, a2) ->
      (comp_fun c) (eval ctx a1) (eval ctx a2)

(* Statements *)

type statement =
    Bind of string * arith
  | If of boolean * statement list * statement list
  | While of boolean * statement list
  | For of statement * boolean * statement * statement list
  | Print of arith

exception Runtime_error of string

let rec legal_body var statements =
  let check s =
    match s with 
    | Bind (s, _) -> s <> var
    | If(_, s1, s2) -> (legal_body var s1) && (legal_body var s2)
    | While (_, s) -> legal_body var s
    | For (i, _, u, s) -> (legal_body var [i]) && (legal_body var [u]) && (legal_body var s)
    | Print _ -> true
  in 
  List.for_all check statements

let rec exec ctx = function
    [] ->
      ctx

  | Bind (s, a) :: rest ->
      let ctx' = add_binding ctx s (eval ctx a) in
      exec ctx' rest

  | If (condition, body1, body2) :: rest ->
      let ctx' =
        if test ctx condition then exec ctx body1
        else exec ctx body2 in
      exec ctx' rest

  | While (condition, body) :: rest ->
      if test ctx condition then 
        let ctx' = exec ctx body in
        exec ctx'(While(condition, body)::rest)
    else
      exec ctx rest 

  | For (init, condition, update, body) :: rest ->
      (match init with
      | Bind (name, _) ->
        if legal_body name body then 
          let new_statement = [init; While (condition, body @ [update])] in
          exec ctx (new_statement @ rest)
        else 
          raise (Runtime_error "illegal manipulation of counter in for loop")
        | _ -> 
          raise (Runtime_error "illegal statement in init section of for loop")
        )

  | Print a :: rest ->
      let _ = print_endline (string_of_float (eval ctx a)) in
      exec ctx rest