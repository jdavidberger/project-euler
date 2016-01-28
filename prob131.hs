import Data.List
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

icubes = zip cubes [1..]

cubes =  map (^3) [1..]

target = 1000000

-- For n^3 + n^2*p = m^3 we can rewrite so that
-- n^2 * (n + p) = m^3
-- Since we presuppose that m^3 / n^2 must be
-- a whole number, m^3/n^2 must reform into
-- some other cube or p must be 0

prob131 t =
  map (\(n,p) -> (n, p, round $ (fromIntegral $ f n p) ** (1/3) )) $
  map fromJust $
  filter (not.isNothing) $
  map solve $
  takeWhile (<t*1000) cubes -- hack. Not sure what the upper bound for (n+p) actually is? 
    where solve s =
            if length primelist == 0 then Nothing else Just $ (s, head primelist)
            where primelist =
                    filter isPrime $
                    takeWhile (<=t) $
                    map (\c-> c-s) $
                    (dropWhile (<=s) cubes)

    
main = putStrLn $ show $ length $ prob131 target
