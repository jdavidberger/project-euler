{-# LANGUAGE ScopedTypeVariables #-}
import Debug.Trace
import Data.Ratio
import Data.Fixed
import Data.Array
import qualified Data.Map as Map
import Data.List

import Euler

fact :: [Integer]
fact = 1 : (zipWith (*) fact [1..])

fact_n = (fact !!)

binom n k =
  let fn i = (n + 1 - i)
      fd i = i
      k' = if k > (n `div` 2) then (n-k) else k
  in (product $ map fn [1..k']) `div` (product $ map fd [1..k'])

binom_f n k = (fact_n n) `div` ( (fact_n k) * (fact_n (n-k)) )

bern_f m = 
  let g k b_k =
        b_k * (( (binom m k) ) % (toInteger (m - k + 1) ))
  in (0-) $ sum $ zipWith g [0..(m-1)] bern

bern1 =
  (1%1) : map bern_f [1..]

bern =
  let
    f lst n =
        let newLst = lst ++ [ 1 % (n+1) ]
            g (idx1,aj1) (idx,aj) =
              res where res = (idx1, (idx % 1) * (aj1 - aj))
            newLst1 =
              scanr1 g $
              zip [0..] newLst
            newLst2 =
              (map snd newLst1) -- ++ [ 1 % (n+1) ]
        in newLst2
  in map head $ drop 1 $ scanl f [] [0..]
 

faul p =
  let f n = 
        let j = p + 1 - n
            b_j = bern !! j
            p1 = toInteger $ p + 1
            neg = if (mod j 2) == 1 then -1 else 1
            bin = neg * (binom p1 (toInteger j))
        in  b_j * (bin % p1)
  in map f [1..p+1]

faul_n p n =
  let j = p + 1 - n
      b_j = bern !! j
      bin = toInteger $ binom (p + 1) j
  in  b_j * (bin % (toInteger (p + 1)))



frequency xs = (Map.fromListWith (+) [(x, 1) | x <- xs])

bern_denoms =
  let
    f n =
        let n2 = 2*n
            pred p = n2 `mod` (p-1) == 0
            nprimes = takeWhile (<=(n2+1)) primes
            pc = filter pred $ nprimes
        in product pc
  in map f [2..]

pm1s = map (+(-1)) primes

gen_p n =
  let pred p = n `mod` (p-1) == 0
      nprimes = filter pred $ takeWhile (<=(n+1)) primes
  in (nprimes, map (+(-1)) nprimes)
  

check1 n =
  let pred p = n `mod` (p-1) == 0
      nprimes = filter pred $ takeWhile (<=(n+1)) primes
  in   (primeFactors 20010) == nprimes



breakdown n =
  filter isPrime $ map (+1) $ map product $ subsequences $ primeFactors n

prob545 n k =
  let factors = primeFactors n
      fm1     = map (\p -> primeFactors $ p-1) factors
      freqPrimesInFm1 = Map.toList $ Map.unionsWith max $ map frequency fm1
      minCover = product $ map (\(a,b) -> a*b) freqPrimesInFm1
      minCoverBreakdown = breakdown minCover
      check n = minCoverBreakdown == (breakdown n)
  in head $ drop (k-2) $ filter check $ map (*minCover) [2..]

main = print $ prob545 20010 (10^5)
