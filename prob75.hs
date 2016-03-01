import Euler

import qualified Data.Map as Map

isEven n = (n `mod` 2) == 0
isOdd n = (n `mod` 2) == 1

limit = 1500000

triples = 
  let pred = ((<=limit).sum)
      relTriples = py_trips
      tripleFamily [a,b,c] = takeWhile pred $ map (\m -> [m*a,m*b,m*c]) [1..]
  in  concat $ map tripleFamily relTriples

prob75 =
  length $ filter (\(a,b) -> b == 1) $
  Map.toList $
  frequency $ map sum $ triples

py_trips =
  [ [a,b,c] | m <- [0..squareRoot limit], 
              n <- [0..m-1],
              let a = m*m - n*n
                  b = 2 * m *n
                  c = m*m + n*n,
              a > 0 && b > 0 && c > 0,
              isEven m || isEven n,
              gcd m n == 1,
              isOdd (m - n),
              a + b + c <= limit
            ]
          
main = print prob75
