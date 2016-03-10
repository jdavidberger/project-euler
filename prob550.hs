import qualified Data.Set as Set
import qualified Data.Map as Map
import Data.Char
import Debug.Trace
import Euler
import Data.Maybe
import Data.List

split n = [ filter (>1) [a, b] | a <- [1..n-1], b <- [1..n-1] ]

continuations lst' =
  let mix idx = [ sort $ sp ++ (take idx lst) ++ (drop (idx+1) lst) |
                  sp <- split $ lst !! idx ]
      lst = filter (>1) lst'
      sf a b = compare (length a) (length b)
      combos = sortBy sf $ nub $ concat $ map mix [0..(length lst)-1]
  in combos

canWinF'' :: [Integer] -> Bool
canWinF'' [] = False
canWinF'' lst =
  let c = continuations lst
  in if length c == 0 then True
     else any (not.canWinF) c

canWinF' lst= canWinF'' (filter (>1) lst)

key :: [Integer] -> Integer
key lst' =
  let lst = reverse $ sort lst'
  in product $ zipWith (^) primes lst

unkey n =
  let pp = primePowers n
      ppm = Map.fromList pp
      mx = fst $ maximum $ pp
      f i = Map.findWithDefault 0 i ppm
  in map f $ takeWhile (<=mx) primes

canWinF :: [Integer] -> Bool
canWinF = memo1 key unkey canWinF'

canWin lst = canWinF $ map (sum.(map snd).primePowers) lst

c n k = (n-1)^k

combos n 0 = [[]]
combos n k =
  [ (f : lst) | f <- [2..n], lst <- combos n (k-1)]

f n k =
  filter canWin $ combos n k

char n =  map (sum.(map snd)) $ map primePowers [2..n]

prob550 =
  0

main = print $ prob550
