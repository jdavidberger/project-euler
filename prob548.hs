import Debug.Trace

import Euler
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe
import Data.List

ppUnder n pl max =
  let starters = takeWhile (\m -> (p^m) < n) [1..max]
      p = head pl
      f m = map ( (p, m) : ) $ ppUnder ( n `div` (p^m)) (tail pl) (m)
      rtn = map f starters
  in [] : (concat $ rtn)

limit = (10^16)
primeSigs = ppUnder limit primes 60

min_equiv' 1 = 1
min_equiv' n =
  fromPrimePowers $ zip primes $ map snd $ primePowers n

min_equiv = memoNat min_equiv'
  
gozinta' 1 = 1
gozinta' n = sum $ map gozinta $ divisors n

gozinta = memoNat (gozinta'.min_equiv)

prob548_filter 1 = False
prob548_filter n =
  n == gozinta n

prob548_naive =
  filter prob548_filter [1..limit]

prob548 =
  sum $
  filter prob548_filter $
  filter (<limit) $
  map gozinta $
  map fromPrimePowers primeSigs
  
main = print (prob548 + 1)
