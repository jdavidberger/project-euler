import Debug.Trace

import Euler
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe
import Data.List

candidates = map (+(-1)) primes

filter357 n =
  let d = divisors n
      ds = map (\m -> m + (n `div` m)) d
  in all isPrime ds

prob357 = sum $ takeWhile (<10^8) $ filter filter357 candidates

main = print prob357
