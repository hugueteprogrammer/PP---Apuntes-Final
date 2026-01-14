(*tribo.ml - Cálculo eficiente de la sucesión de Tribonacci*)

(*Definición del tipo de Matriz 3x3*)
type matrix = {
  a11: Z.t; a12: Z.t; a13: Z.t;
  a21: Z.t; a22: Z.t; a23: Z.t;
  a31: Z.t; a32: Z.t; a33: Z.t;
}

(*Definición de constantes Z.t*)
let zero = Z.zero
let one = Z.one

(*La Matriz de Tribonacci fundamental M:
   | 1 1 1 |
   | 1 0 0 |
   | 0 1 0 |
*)
let m_tribo = {
  a11 = one; a12 = one; a13 = one;
  a21 = one; a22 = zero; a23 = zero;
  a31 = zero; a32 = one; a33 = zero;
}

(* Matriz Identidad 3x3 (I)*)
let m_identity = {
  a11 = one; a12 = zero; a13 = zero;
  a21 = zero; a22 = one; a23 = zero;
  a31 = zero; a32 = zero; a33 = one;
}

(*Función para multiplicar dos matrices 3x3 (M * N) *)
let matrix_mult m n =
  (*Definimos f_sum para el producto escalar de Fila (a, b, c) y Columna (x, y, z)*)
  let f_sum a b c x y z =
    Z.((a * x) + (b * y) + (c * z)) 
  in
  {
    (*Elemento a11: Fila 1 de M (a11, a12, a13) * Columna 1 de N (n.a11, n.a21, n.a31) *)
    a11 = f_sum m.a11 m.a12 m.a13 n.a11 n.a21 n.a31;
    a12 = f_sum m.a11 m.a12 m.a13 n.a12 n.a22 n.a32;
    a13 = f_sum m.a11 m.a12 m.a13 n.a13 n.a23 n.a33;

    (*Elemento a21: Fila 2 de M (a21, a22, a23) * Columna 1 de N (n.a11, n.a21, n.a31) *)
    a21 = f_sum m.a21 m.a22 m.a23 n.a11 n.a21 n.a31;
    a22 = f_sum m.a21 m.a22 m.a23 n.a12 n.a22 n.a32;
    a23 = f_sum m.a21 m.a22 m.a23 n.a13 n.a23 n.a33;

    a31 = f_sum m.a31 m.a32 m.a33 n.a11 n.a21 n.a31;
    a32 = f_sum m.a31 m.a32 m.a33 n.a12 n.a22 n.a32;
    a33 = f_sum m.a31 m.a32 m.a33 n.a13 n.a23 n.a33;
  }

(*Función recursiva para calcular la potencia de una matriz (M^n)*)
(*No utiliza bucles ni variables, solo recursión y 'let' para ligaduras inmutables*)
let rec matrix_pow m power =
  if power = 0 then m_identity (*Caso Base: M^0 = I *)
  else
    let half_pow = power / 2 in
    let m_half = matrix_pow m half_pow in
    let m_squared = matrix_mult m_half m_half in
    if power mod 2 = 0 then
      m_squared (* Si n es par: M^n = (M^(n/2))^2 *)
    else
      matrix_mult m m_squared (*Si n es impar: M^n = M * (M^((n-1)/2))^2*)

let tribo n =
  match n with
  | 0 | 1 -> zero (*tribo_0 = 0, tribo_1 = 0 [cite: 3, 4]*)
  | 2 -> one    (*tribo_2 = 1 [cite: 5] *)
  | n when n < 0 -> failwith "El índice de Tribonacci debe ser no negativo."
  | _ ->
    (*Fórmula: Vector_n = M^(n-2) * Vector_inicial
    Vector_inicial = [tribo_2; tribo_1; tribo_0] = [1; 0; 0]*)
    let n_minus_2 = n - 2 in
    let m_powered = matrix_pow m_tribo n_minus_2 in

    (*El término tribo_n es el elemento (a11) de M^(n-2) multiplicado por 1,
    ya que solo el primer elemento del vector inicial [1; 0; 0] es no nulo.
    tribo_n = m_powered.a11 * 1 + m_powered.a12 * 0 + m_powered.a13 * 0*)
    m_powered.a11

(* Función de punto de entrada del programa *)
let main () =
  try
    let arg = Sys.argv.(1) in (* El argumento es el índice 'n' *)
    let n = int_of_string arg in
    let result = tribo n in
    print_endline (Z.to_string result) (* Imprime la representación decimal [cite: 18] *)
  with
  | Invalid_argument _ ->
      print_endline "Uso: ./tribo <entero_n>";
      exit 1
  | Failure msg ->
      print_endline ("Error: " ^ msg);
      exit 1

(* Ejecución del programa *)
let () = main ()