module Main where

import Data.List
import Ratio

primes = 2 : filter ((==1) . length . primeFactors) [3,5..]
 
primeFactors n = factor n primes
  where
    factor n (p:ps) 
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      = factor n ps



relprimes n = rtn 
    where factors = primeFactors n
          rtn = filter (not.common) [lower..upper]
          lower = if mod n 3 == 0 then n`div`3 + 1 else n`div`3
          upper = if mod n 2 == 0 then n`div`2 - 1 else n`div`2
          common x = any (\y -> mod x y == 0) factors

inrange d = dropWhile (<=(1%3)) (takeWhile (<(1%2)) $ fracs)
            where fracs = map (\x->x%d) (relprimes d)

fullrange = foldl (++) [] (map inrange [1..10000])

main = putStrLn $ show $ length fullrange
