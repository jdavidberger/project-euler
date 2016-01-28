module Main where
import Debug.Trace
import Data.Ratio

cf x = takeWhile (/=0) as
    where
      as :: [Int]
      as = map floor afs
      afs :: [Double]
      afs = x : zipWith (\af a -> (1.0::Double) / (af-a) ) afs (map fromIntegral as)


period x = trace (show peri) peri 
    where peri = (drop 1 (take ((length (takeWhile (< ((head a)*2) ) a)) + 1) a))
          a = cf x

isOdd x = mod x 2 == 1

prob64 =
    length (filter isOdd (map (length.period.sqrt) [2..10000]))

main =     putStrLn (show prob64)
