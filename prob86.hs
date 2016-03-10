import Euler

import Debug.Trace
import Data.List
import qualified Data.Map as Map
import qualified Data.Set as Set

limit = 50

prob86c l =
  let [a,b,c] = map fromIntegral l
  in  [ (sqrt (a**2 + b**2) + c) ** 2,
        ((a+c)**2 + b**2),
        ((a+b)**2 + c**2),
        ((b+c)**2 + a**2) ]
      
prob86f' l =
  let m = minimum $ prob86c l
  in abs (m - (fromIntegral (round m))) < 0.001

prob86f [a,b,c] =
  isSquare $ minimum [ ((a+c)^2 + b^2),
                       ((a+b)^2 + c^2),
                       ((b+c)^2 + a^2) ]

prob86_naive limit =
  let f [l1,l2,_] = 
        Set.fromList $ map sort $ filter pred $
        (map (\c -> [l1, l2 - c, c]) [1..l2-1] ++
         map (\c -> [l1 - c, l2, c]) [1..l1-1])
      pred [a,b,c] =  (maximum [a,b,c]) <= limit
      count = length $ filter prob86f $ 
        Set.toList $
        Set.unions $
        map f $ pytriangles (3*limit)
  in count

-- Not particularly fast, but for the naive solution its fast enough...
main = print $ binsearch' prob86_naive (10000)
