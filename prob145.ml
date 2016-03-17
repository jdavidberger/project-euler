let rec range i j = if i >= j then [] else i :: (range (i+1) j);;

let is_odd n = n mod 2 == 1;;
  
let rec all f ls =
  match ls with
  | [] -> true
  | hd :: tl -> if f hd then all f tl else false

let any f ls =
  List.length (List.filter f ls) > 0
  
let digits (n) =
  let rec f m =
    if m == 0
    then []
    else (m mod 10) :: (f (m / 10)) in
  List.rev (f n);;

let undigits =
  let f acc i =
    acc * 10 + i in
  List.fold_left f 0;;
  
let reverse_number(n) =
  let inp = ref n 
  and ot = ref 0 in 
  while !inp > 0 do
    ot  := !ot * 10 + (!inp mod 10);
    inp := !inp / 10;                
  done;
  !ot;;

let is_all_odd = all is_odd;;

let check(n) =
  n mod 10 != 0 &&
    is_all_odd (digits (n + (undigits (List.rev (digits n)))));;

(* Turns out brute forceing is actually a few hundred seconds, might as well leave it at that. *)
let rec prob145(n) =
  let rtn = ref 0 in
  for i = 1 to n do
    rtn := !rtn + if check i then 1 else 0
  done;
  !rtn;;

let main () =
  print_int ( prob145 1000000000 );
  print_newline ();
;;

if !Sys.interactive then () else main ();;
  
