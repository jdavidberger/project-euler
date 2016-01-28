import qualified Data.Set as S
import Data.Char
import Debug.Trace

digits x = map digitToInt (show x)

fact x = foldl (*) 1 [1..x]

nextchain x = sum $ map fact $ digits x

chain x = n : chain n
          where n = nextchain x

period x = length $ takeWhile (\(a,b) -> S.size (S.fromList a) == b) $ zip (scanl (\a b -> b : a) [x] (chain x)) [1..]

period2 x = if base == 62 then (period (nextchain x)) + 1 else base
    where 
      base = 1 + (length $ takeWhile (/=x) (take 61 mychain))
      mychain = chain x

uniques = concat $ map (\n -> map (\x -> (x,n+1)) $ all_pow n) [0..]

all_pow :: Int -> [Int]
all_pow n = concat $ map (\d -> powers d n) [1..9]
--powers 0 n = [ 0 ]
powers d 0 = [d]
powers d n = map (+(d * 10 ^ n)) (concat $ map (\d2 -> powers d2 (n-1)) [0..d])

prob74 = filter (\(a,n) -> period a == 60) (takeWhile (\(a,n) -> a <= 1000000) uniques)