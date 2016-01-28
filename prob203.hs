
import Data.List


isPrime = ((==1).length.primeFactors)

primes = 2 : filter ((==1) . length . primeFactors) [3,5..]
 
primeFactors n = factor n primes
  where
    factor n (p:ps) 
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      = factor n ps

pascal :: [[Integer]]
pascal = [1] : 
         ( map (\row -> zipWith (+) (row++[0]) (0:row) ) pascal )

pdist = nub $ concat $ take 51 pascal

prob203 = 
    filter squarefree pdist -- \\ takeWhile (<= foldl1 max pdist) sprimes
        
isSqrtPrime x = truncate s == ceiling s && (isPrime $ truncate$ s)
                where s = sqrt $ fromIntegral x

{-squarefree s = 
    let limit = s `div` 2 in
    (isSqrtPrime s == False) && [] == (filter ((==0).(s`mod`)) $ takeWhile (\x -> x <= limit) sprimes) 
-}

squarefree s = 
    length factors == length (nub factors)
    where factors = primeFactors s

sprimes = map (^2) primes

main = print $ sum prob203
