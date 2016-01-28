import List
import qualified Data.Set as S
import Debug.Trace
import Data.Maybe

isPrime = ((==1).length.primeFactors)

primes = 2 : filter ((==1) . length . primeFactors) [3,5..]
 
primeFactors n = factor n primes
  where
    factor n (p:ps) 
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      = factor n ps

isCube x = head (dropWhile (<x) cubes) == x

f n p = n^3 + n^2*p

tprimes =  map (\p-> (p, map (\n -> n^3 + n^2*p) $ takeWhile (<=p) [1..])) primes

icubes = zip cubes [1..]

cubes =  map (^3) [1..]

target = 1000000

prob131 t = map fromJust $ filter (not.isNothing) $ map solve $ takeWhile (<t) cubes
    where solve n = if (length $ (snd rtn)) == 0 then Nothing else Just rtn
              where
                rtn = (n , filter (isPrime.fst) $ map (\c->(c-n,c)) $ takeWhile (<t) (dropWhile (<=n) cubes))

