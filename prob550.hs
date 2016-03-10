import qualified Data.Set as Set
import Data.Char
import Debug.Trace
import Euler
import Data.Choose
import Data.Maybe


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
