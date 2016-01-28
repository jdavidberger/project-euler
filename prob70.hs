import Data.List

primes = 2 : filter ((==1) . length . primeFactors) [3,5..]

nearlyPrimes limit =
  let f n = map (*n) $ takeWhile (\m -> n * m < limit) primes in
  concat $ map f $ takeWhile (\n -> n < (2 * limit) ) primes

primeFactors n = factor n primes
  where
    factor n (p:ps) 
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      = factor n ps

isPerm x y = (sort (show x)) == (sort (show y))
isPrime = ((==1).length.primeFactors)

phi 1 = 1
phi n =
  let nfactors = primeFactors n in
  length $ filter (\m -> null $ nfactors `intersect` primeFactors m) [1..n]

phi_np 1 = 1
phi_np n =
  let nfactors = primeFactors n in
  n - (sum nfactors) + 1

phis = map phi [1..]

inSet n = let phin = phi_np n in isPerm n phin

prob70set = filter inSet [1..]
prob70metric n = n - (phi n)


upper = 10000000
prob70 = last $ filter inSet $ nearlyPrimes upper

main = print prob70
