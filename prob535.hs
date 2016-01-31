import Debug.Trace

-- The basic strategy here is that we can quickly calculate
-- sums of natural series, so we find the cover number for any
-- given 'n'. The idea is that if we want the sum up to 11
--                                                         \/
--  1, 1, 2, 1, 3, 2, 4, 1, 5, 3, 6, 2, 7, 8, 4, 9, 1, 10, 11, 5
--                         /\       
-- then the index at 5 is the min_cover. This is important because
-- the list ending at 19 can be rewritten to be
-- 1, 1, 2, 1, 3, 2, 4, 1, 5, 1..11
-- and we can recursively find this subsequence
-- 1, 1, 2, 1, 1..5, 1..11
-- 1, 1, 1..2, 1..5, 1..11
find_min_cover n =
  let f :: Integer -> Integer -> Integer -> Integer
      f guess cmin cmax =
        let gcov = css guess
            nmin = if gcov > n then cmin else (guess+1)
            nmax = if gcov > n then guess else cmax
            tiebreak = if guess == cmax then 0 else 1
            nguess = (nmin + nmax + tiebreak) `div` 2
            isdone = cmin == cmax
         in if isdone then guess
            else f nguess nmin nmax 
      ans = f (n `div` 4) 0 (n `div` 2) 
   in ans

sum_natural_series n m = (n * (n+1) `div` 2) `mod` m
sum_sr_series n =
  let sr = squareRoot n
      sr_contrib = sr * (n - sr*sr + 1)
      pcontrib p = p * ( (p+1)^2 - p^2)
      pcontribs = map pcontrib [1..(sr-1)]
  in sum pcontribs + sr_contrib + n

-- Compute sum of Squared s
css_fn m =  
  let f 1 = 2
      f n = 
        let subn = find_min_cover n
            ncircles = n - subn
            sum_series = sum_sr_series ncircles
            sum_recurs = f subn
        in sum_series + sum_recurs
  in f (m+1)

-- This function needs to be memoized for any performance since
-- css_fn and find_min_cover bounce off of eachother
css :: Integer -> Integer
css = memoNat css_fn

-- Compute sum of S
cs :: Integer -> Integer -> Integer
cs 1 _ = 1
cs n m =
  let subn = find_min_cover n
      ncircles = n - subn
      sum_series = (sum_natural_series ncircles m)
      sum_recurs = cs subn m
  in (sum_series + sum_recurs) `mod` m

mod_group = 10^9
target = 10^18
prob535 = cs target mod_group
  
main = print prob535

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

(^!) :: Num a => a -> Int -> a
(^!) x n = x^n
  
squareRoot 0 = 0
squareRoot 1 = 1
squareRoot n =
  let twopows = iterate (^!2) 2
      (lowerRoot, lowerN) = last $ takeWhile ((n>=) . snd) $ zip (1:twopows) twopows
      newtonStep x = div (x + div n x) 2
      iters = iterate newtonStep (squareRoot (div n lowerN) * lowerRoot)
      isRoot r  =  r^!2 <= n && n < (r+1)^!2
  in  head $ dropWhile (not . isRoot) iters

