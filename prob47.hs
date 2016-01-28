import Data.List

primes = 2 : filter ((==1) . length . primeFactors) [3,5..]
 
primeFactors :: Int -> [Int]
primeFactors n = factor n primes
  where
    factor n (p:ps) 
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      = factor n ps

test n x y = length (intersect x y) == 0 && length x >= n && length y >= n

n_dist :: Int -> [[Int]] -> Bool
n_dist n (x:[]) = True
n_dist n (x:(y:tl)) = (test n x y) && n_dist n (y:tl)


prob47 :: Int -> Int
prob47 n = 
    head [ x | x <- [2..],
               let y = [x..x+n-1], 
               n_dist n (map (nub . primeFactors) y)]


               