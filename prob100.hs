import Debug.Trace

import Euler
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe


a046090 0 = 1
a046090 1 = 4
a046090 2 = 21
a046090 n = 7*a046090(n-1) - 7*a046090(n-2) + a046090(n-3)


isValidCount c =
  let v = 8*c*c - 8*c + 4
      sv = squareRoot v
  in (sv + 2) `mod` 4 == 0 && sv*sv == v && sv > 2

getBalls c =
  let v = 8*c*c - 8*c + 4
      sv = squareRoot v
  in ((sv + 2) `div` 4, c)

prob100 start =  
  fst $ head $ map getBalls $ filter isValidCount $ filter (>=start) $ map a046090 [1..]
  
main = print $ prob100 (10^12)
