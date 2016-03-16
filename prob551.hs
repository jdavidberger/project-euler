import Debug.Trace
import Data.Char
import Euler

digits x = map digitToInt (show x)

ga' l n = 
  let f a = l + a + (sum $ digits a)
  in iterate f n
ga = memoNat2 ga'

solve_for_max_naive max l n = head $
  dropWhile ((<(max)).snd) $
  scanl (\(ll, li) item -> (ll + 1, item)) (-1,0) $
  ga l n

breakup n =
  if n `mod` 10 == 0 then
    let (pn, pc) = breakup (n `div` 10)
    in (pn, pc + 1)
  else (n, 0)

solve_for_max' max l n
  | max <= 1000 = head $ dropWhile ((<(max)).snd) $ scanl (\(ll, li) item -> (ll + 1, item)) (-1,0) $ ga l n
  | otherwise =
    let self = solve_for_max
        (pn', pc') = breakup max
        (pn, solvefirst, solvenext, pc) =
          if pc' >= 3
          then (pn', (pn' `div` 10) * 10^(pc'+1), (pn `mod` 10) * 10^pc, pc')
          else (max `div` (10^3), max `div` (10^3) * (10^3), max `mod` (10^3), 3)
        (fl, fres) = self solvefirst l n
        prefix_score = l + (sum $ digits $ solvefirst)
        (nl, nres) = self solvenext prefix_score (fres `mod` (10^(pc)))
        base = 10^(pc)
        f (length,val) d = (length + a, b `mod` base)
          where (a, b) = self (base) (d+l-1) (val `mod` base )
        (gn, gc) = self (max - 1) l n
        nnres = (nres `mod` base) + pn * 10^pc
    in if pn' < 10 
       then if gc `mod` base == ((max-1) `mod` base)
            then (gn+1, l + gc + (sum $ digits gc))
            else (gn, gc) 
       else (fl + nl, if nnres < max then nnres + base else nnres)

solve_for_max = memoNat3 solve_for_max'
  
a' = ga 0 1
a = (a' !!) 


target = 10^15
prob551 = solve_for_max (binsearch' (\n -> (fst $ solve_for_max n 0 1))  (target - 1)) 0 1

main = print $ prob551
