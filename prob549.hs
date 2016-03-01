import Debug.Trace

import Euler
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe
import Data.List

pcumsum' p =
  let f n m =
        n + (length $ filter (==p) $ primeFactors m)
  in drop 1 $ scanl f 0 [1..]

pcumsum = memoNat pcumsum'

ncount p = 
  let f m =
        take p $ repeat m
  in drop 1 $ concat $ map f [0..]

ncountsum p idx =
  sum $ takeWhile (>0) $ map (div idx) $ map (p^) [1..]

min_basis'' p n =
  1 + (length $ takeWhile (<n) $ map (ncountsum p) [1..] )

min_basis' p n =
  1 + (length $ takeWhile (<n) $ pcumsum p)

min_basis p 1 = p
min_basis p n =
  let f = memoNat2 min_basis''
  in f p n


sf n =
  let pp = primePowers n
      f (p,m) = min_basis p m
  in maximum $ map f pp

sF n =
  sum $ map sf [2..n]

limit = 10^8
prob549 = sF limit

main = print prob549
