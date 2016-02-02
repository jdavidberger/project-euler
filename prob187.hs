import Euler
import Data.Array.Unboxed
import Debug.Trace
import Data.List

legendre_rec n 0 = n
legendre_rec 0 _ = 0
legendre_rec 1 _ = 1
legendre_rec 2 _ = 1
legendre_rec x a =
  legendre_rec x (a-1) - legendre_rec (x `div` prime_at(a)) (a-1)

legendre :: Integer -> Integer -> Integer
legendre = memoNat2 legendre_rec

legendre1 x a =
  let g [] = 0
      g part =
        let sgn = if (length part) `mod` 2 == 1 then -1 else 1        
        in sgn * (x `div` (product part))
      parts = sum $ map g $ subsequences $ prime_range 1 a
  in traceShow (x,a,prime_range 1 a) (x + parts)

phi_leg 1 = 0
phi_leg x =
  (legendre x psrx) + (psrx) - 1 where srx = squareRoot x
                                       psrx = phi_leg srx

prime_at a =
  head $ drop (fromInteger (a-1)) primes
prime_range a b =
  drop (fromInteger (a-1)) $ take (fromInteger (b)) (primes)

phi_m 1 = 0
phi_m 2 = 1
phi_m 3 = 2
phi_m x =
  let b = phi_m $ squareRoot x
      c = phi_m $ cubeRoot x
      leg =  legendre x c
      primesi = prime_range (c+1) b
      summa = sum $ map (\p -> phi_m (x `div` p)) primesi
      prod  = (b+c-2)*(b-c+1) `div` 2
      rtn  = leg + prod - summa
  in rtn

pi2 x =
  let primes = zip [1..] $ prime_range 1 psrx
      psrx = phi_m $ squareRoot x
      f (idx, p) =  phi_m (x `div` p) - idx + 1
      terms = map f primes
  in sum terms 
    
prob187 n = pi2 n
limit = 10^8
main = print $ prob187 limit
