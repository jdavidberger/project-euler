import Data.List

primes = 2 : filter ((==1) . length . primeFactors) [3,5..]

nearlyPrimes limit =
  let seperatedBy n =
        reverse $ takeWhile (\(x,y) -> x*y < limit) $ zip (drop n primes) primes in
   sortBy (\(x,y)->x*y) $ concat $ takeWhile (not.null) $ map seperatedBy [1..]

primeFactors n = factor n primes
  where
    factor n (p:ps) 
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      = factor n ps

isPerm (n,m) y = (sort (show $n*m)) == (sort (show y))
isPrime = ((==1).length.primeFactors)

phi_np (n,m) =
  n*m - n - m + 1

inSet n = let phin = phi_np n in isPerm n phin

upper = 10000000
prob70 = last $ filter inSet $ nearlyPrimes upper

main = print prob70
