module Main where

import Debug.Trace

primes = 2 : filter isprime [3,5..]

isprime :: Int -> Bool
isprime = ((==1) . length . primeFactors)
 
primeFactors n = factor n primes
  where
    factor n (p:ps) 
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      = factor n ps


concati a b = (read ((show a) ++  (show b)))::Int

flatten = foldl (++) []
operate :: [Int] -> [Int]

operate prm = flatten ([ [(concati a b), (concati b a)] | a <- prm,
                                               b <- prm,
                                               a /= b])

op a b = (map (concati a) b) ++ (map (\x ->concati x a) b)

works b a = all isprime (op a b)

dualPrimes = [ (a,b) | a <- primes,
                       b <- (takeWhile (<a) primes),
                       works [b] a]

tripPrimes = [ (a,b,c) | (a,b) <- dualPrimes,
                         c <- (takeWhile (<b) primes),
                         works [a,b] c]

quadPrimes = [ (a,b,c,d) | (a,b) <- dualPrimes,
                           let c = 3,
                           let d = 7,
                           works [a,b] 3,
                           works [a,b] 7]

fivePrimes = [ (a,b,c,d,e) | (a,b,c) <- tripPrimes,
                             let d = 3,
                             let e = 7,
                             works [a,b,c,d] 3,
                             works [a,b,c,d] 7]

prob60 = 
    head fivePrimes



main = 
    putStrLn (show prob60)