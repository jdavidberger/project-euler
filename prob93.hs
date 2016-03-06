import Data.Ratio
import Data.List

fm = flip (-)

-- Special form(s) of div which maps x / 0 to 0
cdiv a 0 = 0
cdiv a b = a / b

fcdiv 0 b = 0
fcdiv a b = b / a

genChoose _ 0 = [[]]
genChoose l n =
  concat $
  map (\h -> map (h:) (genChoose l (n-1))) l

ops :: [Ratio Integer -> Ratio Integer -> Ratio Integer]
ops = [fm, fcdiv, (-), (+), (*), (cdiv) ]

opCombos = genChoose ops 3

doEval [a,b,c,d] [o1,o2,o3] =
  o1 a $ o2 b $ o3 c d

genSeq s =
  let perms = permutations s
  in sort $ nub $ map numerator $ filter (0<) $ filter ((==1).denominator) $ [ doEval p op | p <- perms, op <- opCombos ]

matchSeq s =
  length $ takeWhile (\(a,b) -> a==b) $ zip [1..] (genSeq (map (%1) s))

allSets =
  [ [a,b,c,d] | d <- [1..9], c <- [1..d-1], b <- [1..c-1], a <- [1..b-1] ]

prob93 = snd $ maximum $ zip (map matchSeq allSets) allSets

main = print prob93
