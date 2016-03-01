import Debug.Trace

import Euler
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe
import Data.List

p' 0 _ = 1
p' n m =
  let myPrimes = takeWhile (<=m) primes
      f k = p (n-k) k
  in if n < 0 then 0 else sum $ map f myPrimes

p = memoNat2 p'

p_ n = p n n

prob77 = (binsearch p_ 5000 1 100) + 1

main = print prob77
