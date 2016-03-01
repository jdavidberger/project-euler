import Debug.Trace

import Euler
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe
import Data.List

limit = 50

sqlength (x1,y1) = x1*x1 + y1*y1

pdiff (x1,y1) (x2,y2) = (x1-x2, y1-y2)

checkl l1 l2 l3 = 
  let lst = sort [l1,l2,l3] in (lst !! 0) + (lst !! 1) == (lst !! 2) 


check (p1, p2) =
  let l1 = sqlength p1
      l2 = sqlength p2
      l3 = sqlength (pdiff p1 p2)
  in checkl l1 l2 l3

prob91 n =  
  let
    points = [ (x,y) | x <- [0..n], y <- [0..n], not (x == 0 && y == 0) ]
    candidates = [ ( p1, p2 ) | p1 <- points, p2 <- points, p1 /= p2 ]    
  in (length $ filter check candidates) `div` 2

main = print $ prob91 limit
