module Euler where
import Debug.Trace

(^!) x n = x^n
  
squareRoot 0 = 0
squareRoot 1 = 1
squareRoot n =
  let twopows = iterate (^!2) 2
      (lowerRoot, lowerN) = last $ takeWhile ((n>=) . snd) $ zip (1:twopows) twopows
      newtonStep x =  div (x + div n x) 2
      iters = iterate newtonStep (squareRoot (div n lowerN) * lowerRoot)
      isRoot r  =  r^!2 <= n && n < (r+1)^!2
  in  head $ dropWhile (not . isRoot) iters

cubeRoot 0 = 0
cubeRoot 1 = 1
cubeRoot 2 = 1
cubeRoot n =
  let threepows = 1 : iterate (^!3) 3
      (lowerRoot, lowerN) = last $ takeWhile ((n>=) . snd) $ zip (1:threepows) threepows
      newtonStep x = (2*x + (div n (x*x)) ) `div` 3 
      iters = iterate newtonStep (cubeRoot (div n lowerN) * lowerRoot)
      isRoot r  =  r^!3 <= n && n < (r+1)^!3
  in  head $ dropWhile (not . isRoot) iters



isPrime = ((==1).length.primeFactors)

primes = 2 : filter ((==1) . length . primeFactors) [3,5..]
 
primeFactors n = factor n primes
  where
    factor n (p:ps) 
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      = factor n ps


data NatTrie v = NatTrie (NatTrie v) v (NatTrie v)

memo1 arg_to_index index_to_arg f = (\n -> index nats (arg_to_index n))
  where nats = go 0 1
        go i s = NatTrie (go (i+s) s') (f (index_to_arg i)) (go (i+s') s')
          where s' = 2*s
        index (NatTrie l v r) i
          | i <  0    = f (index_to_arg i)
          | i == 0    = v
          | otherwise = case (i-1) `divMod` 2 of
              (i',0) -> index l i'
              (i',1) -> index r i'

memoNat = memo1 id id
memoNat2 :: (Integer -> Integer -> Integer) -> (Integer -> Integer -> Integer)
memoNat2 f = memoNat (\n -> memoNat (f n))
