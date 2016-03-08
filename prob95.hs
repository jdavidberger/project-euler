import qualified Data.Set as Set
import Data.Char
import Debug.Trace
import Euler

amicable' n =
  sum $ divisors n

amicable = memoNat amicable'

chain'' n s =
  if Set.member n s then [] else 
    n : (chain'' (amicable n) (Set.insert n s))

    
limit = 1000000

chain' n s = 
  if n > limit then [] else 
    if Set.member n s then chain'' n Set.empty else 
      chain' (amicable n) (Set.insert n s)

chain n = chain' n Set.empty 

-- About as stupid of a solution as it gets. Could be massively
-- sped up by cacheing chains. But this way only takes 16 seconds
-- and the code is decently clear
prob95 =
  minimum $ snd $ maximum $
  map (\c -> (length c, c)) $
  map chain [1..limit]

main = print $ prob95
