import qualified Data.Set as Set
import qualified Data.Map as Map
import Data.Char
import Debug.Trace
import Euler
import Data.Maybe
import Data.List

split n = [ filter (>1) [a, b] | a <- [1..n-1], b <- [1..n-1] ]

continuations lst' = 
  let mix idx = [ sp ++ (take idx lst) ++ (drop (idx+1) lst) |
                  sp <- split $ lst !! idx ]
      lst = filter (>1) lst'
      combos = concat $ map mix [0..(length lst)-1]
  in combos

canWin' :: [Int] -> Bool
canWin' [] = False
canWin' lst =
  let c = continuations lst
  in if length c == 0 then True
     else traceShow lst $ any (not.canWin) c

key :: [Int] -> Int
key lst' =
  let lst = sort lst'
  in product $ zipWith (^) primes lst

unkey n =
  let pp = primePowers n
      ppm = Map.fromList pp
      mx = fst $ maximum $ pp
      f i = Map.findWithDefault 0 i ppm 
  in map f $ takeWhile (<=mx) primes

canWin :: [Int] -> Bool
canWin = memo1 key unkey canWin'

c n k = (n-1)^k


char n =  map (sum.(map snd)) $ map primePowers [2..n]

f' n 1 = length $ filter (>1) $ char n
f' n k =
  let ch = char n
      z 1 = f n (k-1)
      z 2 = l n (k-1)
      z _ = c n (k-1)
  in traceShow (n,k,map z ch,ch) $ sum $ map z ch

f = memoNat2 f'

l n k = (c n k) - (f n k)

prob550 =
  0
  
main = print $ prob550
