import qualified Data.Set as S
import Data.Char
import Debug.Trace
import Euler
import Data.List

a120892' 0 = 1
a120892' 1 = 0
a120892' 2 = 3
a120892' n = 3 * a120892(n-1) + 3 * a120892(n-2) - a120892(n-3)

a120892 = memoNat a120892'

alt = concat $ repeat [-1, 1]

prob94 limit =
  let f s l1 = (2*l1 + s, 2*l1)
  in sum $ takeWhile (<=limit) $
     map perimeter $ 
     zipWith f alt $
     map a120892 [2..]

isSquare ss =
  ss == s*s where s = squareRoot ss

perimeter (l,l1) = 2*l + l1

isIntArea (l,l1) =
  let s = (2*l + l1) `div` 2
      rs = s * (s - l) * (s - l) * (s - l1)
  in ((2*l + l1) `mod` 2 == 0) && isSquare rs
  
area (l,l1) =
  let s = (2*l + l1) `div` 2
      rs = s * (s - l) * (s - l) * (s - l1)
  in squareRoot rs
     
prob94_naive limit =
  let sides = [1..]
      omtris = [ (l, l-1) | l <- sides, l - 1 > 0 ]
      optris = [ (l, l+1) | l <- sides, l - 1 > 0 ]
      f lst =
        filter isIntArea $
        takeWhile ((<=limit).perimeter) lst
  in sort $ (f omtris) ++ (f optris)

main = print $ prob94 (10^5)
