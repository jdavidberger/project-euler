import Euler
import Debug.Trace
import Data.List
import qualified Data.Map as Map

cartProd xs ys = [ [x,y] | x <- xs, y <- ys]

produceTuple k 1 = map (\x -> [x]) [1..k]
produceTuple k n =
  let f x =        
        map (x:) $ produceTuple (x) (n-1)
  in concat $ map f [1..k]

naive n k =
  let fbase = factorial n
      count lst =
        let fs = Map.toList $ frequency lst
        in fbase `div` ( product $ map (factorial.snd) fs)
      max_pc = length $ takeWhile (<=k) prime_count 
      pred lst =        
        (sum $ map (prime_count!!) lst) == n
  in map count $ filter pred $ produceTuple max_pc k
-- sum $ 
main = print 0
