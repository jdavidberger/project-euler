import Data.List

primes = 2 : filter ((==1) . length . primeFactors) [3,5..]

primeFactors n = factor n primes
  where
    factor n (p:ps) 
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      = factor n ps

isPerm x y = (sort (show x)) == (sort (show y))
isPrime = ((==1).length.primeFactors)
prob70 = head (filter (\x -> isPerm x (x-1)) (filter ((==1).length.primeFactors) [upper,upper-1..1]))
         where upper = 10000000