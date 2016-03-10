module Euler where
import Debug.Trace
import Data.Ratio
import Data.List
import qualified Data.Map as Map

--import Math.Combinatorics.Exact.Binomial

(^!) x n = x^n

squares = (map (^2) [1..])

isSquare ss =
  ss == s*s where s = squareRoot ss

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

primePowers :: Integer -> [(Integer, Integer)]
primePowers n = [(head x, toInteger $ length x) | x <- group $ primeFactors n]

primes = 2 : filter ((==1) . length . primeFactors) [3,5..]

fromPrimePowers pws =
  product [ p^k | (p,k) <- pws]

divisorsPP pp =
  init $ sequence [take (k+1) $ iterate (p*) 1 | (p,k) <- pp]

divisors n = takeWhile (<n) $ map product $ sequence
                    [take (fromInteger (k+1)) $ iterate (p*) 1 | (p, k) <- primePowers n]

binsearch_range f high =
  let p = head $ filter ((>=high).f.(2^)) $ [1..]
  in (2^(p-1), 2^p)

binsearch' f target =
  let (mn,mx) = binsearch_range f target
  in binsearch f target mn mx

binsearch :: (Int -> Int) -> Int -> Int -> Int -> Int
binsearch f target low high
  | high < low       = mid
  | val > target  = binsearch f target low (mid-1)
  | val < target  = binsearch f target (mid+1) high
  | otherwise        = mid
  where
    mid = low + ((high - low) `div` 2)
    val = f mid

primeFactors :: Integer -> [Integer]
primeFactors n = factor n primes
  where
    factor n (p:ps)
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      = factor n ps


data NatTrie v = NatTrie (NatTrie v) v (NatTrie v)

memo1 :: Integral a => (inp -> a) -> (a -> t) -> (t -> out) -> inp -> out
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

memoNat :: Integral a => (a -> b) -> a -> b
memoNat = memo1 id id

memoNat2 f = memoNat (\n -> memoNat (f n))

modProduct m =
  let pr a b =
        let an = numerator a
            bn = numerator b
            ad = denominator a
            bd = denominator b
        in (an * bn) % (ad * bd)
      p a b = (a `mod` m) * (b `mod` m) `mod` m
  in foldl pr 1

binom_mod m n k =
  let fn i = (n + 1 - i)
      fd i = i
      f  i = (fn i) % (fd i)
      k' = if k > (n `div` 2) then (n-k) else k
  in mod (numerator $ product $ map f [1..k']) m

binom n k =
  let fn i = (n + 1 - i)
      fd i = i
      k' = if k > (n `div` 2) then (n-k) else k
  in (product $ map fn [1..k']) `div` (product $ map fd [1..k'])

bernoulli =
  let
    f lst n =
        let newLst = lst ++ [ 1 % (n+1) ]
            g (idx1,aj1) (idx,aj) =
              res where res = (idx1, (idx % 1) * (aj1 - aj))
            newLst1 =
              scanr1 g $
              zip [0..] newLst
            newLst2 =
              (map snd newLst1)
        in newLst2
  in map head $ drop 1 $ scanl f [] [0..]

frequency xs = (Map.fromListWith (+) [(x, 1) | x <- xs])

prime_count_iter (n, last_prime, prime_count) p =
  ((p - last_prime), p, prime_count + 1)

prime_count =
  let f (n,_,c) = take (fromInteger n) $ repeat (c-1) in
  concat $ map f $ scanl prime_count_iter (0,0,0) primes

factorial n = product [1..n]


isEven n = (n `mod` 2) == 0
isOdd n = (n `mod` 2) == 1

pytriples maxSide =
     [ [a,b,c] | m <- [0..maxSide],
               n <- [0..m-1],
               let a = m*m - n*n
                   b = 2 * m *n
                   c = m*m + n*n,
               a > 0 && b > 0 && c > 0,
               isEven m || isEven n,
               gcd m n == 1,
               isOdd (m - n)
             ]


pytriangles maxSide =
  let pred = ((<=maxSide).maximum)
      relTriples = pytriples maxSide
      tripleFamily [a,b,c] = takeWhile pred $ map (\m -> [m*a,m*b,m*c]) [1..]
  in concat $ map tripleFamily relTriples

partitions' rf lst 0 _ = 1
partitions' rf lst n m =
  let mylst = takeWhile (<=m) lst
      f k = rf (n-k) k
  in if n < 0 then 0 else sum $ map f mylst

partitions lst =
  f where f = memoNat2 (partitions' f lst)
