import qualified Data.Set as Set
import qualified Data.Map as Map
import Data.Char
import Debug.Trace
import Euler
import Data.Maybe
import Data.List
import Control.Monad

sortByLS :: [[Integer]] -> [[Integer]]
sortByLS =
  let sf a b = if lord == EQ then elor else lord
        where lord = compare (length a) (length b)
              elor = compare (head a) (head b)
  in sortBy sf

split n = [ filter (>1) [a, b] | a <- [1..n-1], b <- [a..n-1] ]

splits lst =
  let mix (el,idx) = [ sp ++ a ++ (drop 1 b) |
                       sp <- split el ] where (a,b) = splitAt idx lst
  in map mix $ zip lst [0..]

continuations lst' =
  let lst = filter (>1) lst'
  in nub $ concat $ splits lst'

canWinF' [] = Nothing
canWinF' lst =
  listToMaybe $ filter (\c -> Nothing == canWinF c) $ continuations lst

key :: [Integer] -> Integer
key lst' =
  let lst = reverse $ sort $ f $ filter (>1) lst'
      f lst = concat $ map (\z -> if length z `mod` 2 == 0 then [] else [head z]) $ group lst
  in product $ zipWith (^) primes lst

unkey :: Integer -> [Integer]
unkey n =
  let pp = primePowers n
      ppm = Map.fromList pp
      mx = fst $ maximum $ pp
      f i = Map.findWithDefault 0 i ppm
  in map f $ takeWhile (<=mx) primes

canWinF :: [Integer] -> Maybe [Integer]
canWinF =
  let f lst =
        concat $
        map (\z -> if length z `mod` 2 == 0 then []
                   else [head z]) $
        group lst
  in memo1 key unkey canWinF'

facCount = map (sum.(map snd).primePowers)
canWin = canWinF.facCount

c n k = (n-1)^k

combos n 0 = [[]]
combos n k =
  [ (f : lst) | f <- [2..n], lst <- combos n (k-1)]

allCombos lst 0 = [[]]
allCombos lst k =
  [ (f : rst) | f <- lst, rst <- allCombos lst (k-1)]

allCombosOrd :: Integer -> Integer -> [[Integer]]
allCombosOrd n 0 = [[]]
allCombosOrd n k = if n <= 0 then [[]] else 
  [ (f : rst) |
    f <- [1..n],
    rst <- map (map((f)+)) $ allCombosOrd (n-f) (k-1)]

f_naive n k =
  filter (\c -> Nothing /= canWin c) $ combos n k

perm_count :: [Integer] -> Integer
perm_count lst =
  let elems = Map.toList $ frequency lst
  in factorial (toInteger $ length lst) `div` (product $ map (factorial.snd) elems)

f' n k =
  let freqs = Map.toList $ frequency $ map (sum.(map snd).primePowers) [2..n]
      cs = allCombos freqs k
      f item = (map fst item, product $ map snd item)
      csc = map f cs
  in sum $ map snd $ filter ((Nothing /=).canWinF.fst) csc


powerset' [] = [[]]
powerset' (x:xs) = powerset xs ++ map (x:) (powerset xs)

powerset :: [a] -> [[a]]
powerset = filterM (const [True, False])

f n k =
  let freqs = Map.toList $ frequency $ map (sum.(map snd).primePowers) [2..n]
      f lst = (sum $ map snd $ map ((\a -> freqs !! (a-1)).fromInteger) lst, lst)
      cs = map f $
        filter ((Nothing /=).canWinF) $
        
        allCombosOrd (toInteger $ (length freqs)) k
  in cs 

     
char n =  map (sum.(map snd)) $ map primePowers [2..n]

prob550 =
  length $ filter ((/=Nothing).canWinF) $ powerset [2..13]

main = print $ prob550
