

import Data.Bits 

primes = 2 : filter ((==1) . length . primeFactors) [3,5..]
 
primeFactors n = factor n primes
  where
    factor n (p:ps) 
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      = factor n ps

--modexp b 0 m = 1
--modexp b e m = (b * (modexp b (e-1) m)) `mod` m

--modexp b e m = foldl (\acc i -> b * acc `mod` m) b [1..e-1]
  
modexp :: Integer -> Integer -> Integer -> Integer  
modexp b 0 m = 1
modexp b e m = rtn
    where
      bn = b * b `mod` m
      en = shiftR e 1
      nx = modexp bn en m
      rtn = 
          if testBit e 0 then b * nx `mod` m else nx
      

r (n,p) = c
    where a = modexp (p - 1) n a2
          b = modexp (p + 1) n a2
          c = (a + b) `mod` a2
          a2 =  p ^ 2

lim = 10000000000
lsqrt = (floor.sqrt) (fromIntegral lim)

prob123 = head $ filter ((>=lim).r) $ 
          dropWhile (\(n,p) -> p < lsqrt)  $ zip [1..] primes 

    
main = putStrLn $ show $ prob123