
import Ratio
import Debug.Trace

lineqnslv [ [ c, d ] ] =
    [ d / c]

lineqnslv matrix = 
    let eq1 = head matrix
        eqn = tail matrix
        eqn_d = map remVariable eqn
        remVariable eq = tail $ zipWith (-) eq eq1_d
            where 
              delta = head eq / head eq1
              eq1_d = map (*delta) eq1

        sln = lineqnslv eqn_d
        slv1 = ((last eq1) - (sum $ zipWith (*) (0:sln++[0]) eq1)) / (head eq1)
    in slv1 : sln

solve = (map (\x->numerator x `div` denominator x)).lineqnslv.(map (map (%1)))

polyf coeff = map func [1..]
    where 
      func n = sum $ zipWith (*) (reverse coeff) $ map (n^) [0..]

approx n = polyf $ solve $
    map (\(x, i)-> reverse (take (length n) (sqrs i)) ++ [x]) $ zip n [1..]
        where 
          sqrs n = map (n^) [0..]

prob101f = polyf $ take 11 $ cycle [1,-1]

prob101 = 
    sum $ map (\i-> approx (take i t) !! i) [1..10]
        where
          t = prob101f
    