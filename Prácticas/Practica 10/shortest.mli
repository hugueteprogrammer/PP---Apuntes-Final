
type move =
    North | South | West | East

val shortest :
    int -> int -> ((int * int) * move) list -> move list

