
type move =
    North | South | West | East

val tour :
    int -> int -> ((int * int) * move) list -> move list

