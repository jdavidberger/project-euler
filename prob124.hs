import Data.List
import qualified Data.Set as S

primes = 2 : filter ((==1) . length . primeFactors) [3,5..]
 



primeFactors n = S.toList $ S.fromList $ factor n primes
  where
    factor n (p:ps) 
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      = factor n ps

rad = product.primeFactors 


prob124 n = (sortBy (\x y-> 
                      if cmp (fst x) (fst y) == EQ then cmp (snd x) (snd y) 
                      else cmp (fst x) (fst y))
                      (map (\x -> (rad x, x)) [1..n]))
          where cmp a b = if a < b then LT else if a > b then GT else EQ

limit = 100000
want  =  10000

main = putStrLn $ show $ snd $ (!! (want-1)) $ prob124 limit
