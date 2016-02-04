{-# LANGUAGE ScopedTypeVariables #-}
import Debug.Trace
import Data.Ratio
import Data.Fixed
import Data.Array
import qualified Data.Map as Map
import Data.List

import Euler

frequency xs = (Map.fromListWith (+) [(x, 1) | x <- xs])


-- After you read through all the stuff about the n^k stuff, it
-- turns out you need none of it. The real question is at which
-- indices in bernoulli denominators have a given value n.
prob545 n k =
  -- Key to the whole thing is the Staut-Clausen theory; which maps
  -- a bernoulli index to its denominator. 
  let factors = primeFactors n
      fm1     = map (\p -> primeFactors $ p-1) factors
      freqPrimesInFm1 = Map.toList $ Map.unionsWith max $ map frequency fm1
      -- Since we know the factors that go into n, we can find the minimum
      -- number which has the property given; this is F(1), so to speak.
      -- for n=20010, this is 308
      minCover = product $ map (\(a,b) -> a*b) freqPrimesInFm1
      -- Breakdown generates a signature for n; if we multiply something by minCover
      -- and it doesn't match, it isn't in our set. 
      minCoverBreakdown = breakdown minCover
      check n = minCoverBreakdown == (breakdown n)      
  in head $ drop (k-2) $ 
     filter check $
     map (*minCover) [2..]

-- This takes a number 'n', and checks every
-- permutation of its prime factors multiplied
-- together to figure out which ones +1 are prime.
-- The idea is, we know that anything we want to
-- multiply into our 'minCover' from above must not
-- a product to the set which, when you add 1, is prime
-- otherwise there would be a new prime number, and
-- we wouldn't get 'n' (in this case, 20010) 
breakdown n =
  filter isPrime $
  map (+1) $
  map product $
  subsequences $ primeFactors n


main = print $ prob545 20010 (10^5)

