module Main where

import Data.List
import Data.Char

-- | String split in style of python string.split()
split :: String -> String -> [String]
split tok splitme = unfoldr (sp1 tok) splitme
    where sp1 _ "" = Nothing
          sp1 t s = case find (t `isSuffixOf`) (inits s) of
                      Nothing -> Just (s, "")
                      Just p -> Just (take ((length p) - (length t)) p,
                                      drop (length p) s)

code (x,y) = [ x > 0, x < 0, 
               y > 0, y < 0, 
               x > y, y < x,
               -x > y, -x < y]

toint x = read x :: Float

thru_origin pts = foldl (&&) True $
                  foldl ( zipWith (||) ) (head codes) (tail codes)
                  where codes = (map code pts)


thru_origin2 [a,b,c] = area [a,b,c] ==
                       area [a,b,(0.0,0.0)] + 
                       area [a,c,(0.0,0.0)] + 
                       area [b,c,(0.0,0.0)]

diff (x1,y1) (x2,y2) = sqrt (a^2 + b^2)
                       where a = x1-x2
                             b = y1-y2

area [(x1,y1),(x2,y2),(x3,y3)] = abs (x1*y2+x2*y3+x3*y1-x1*y3-x3*y2-x2*y1) / 2.0
                       

semiperimiter [a, b, c] = ((diff a b) + (diff b c) + (diff a b)) / 2.0

prob102 input = show $ length (filter thru_origin2 mynumbers)
    where
      mylines :: [String]
      mylines = lines input
      mynumbers :: [[(Float,Float)]]
      mynumbers = map (\x -> mypoints (map toint (split "," x))) mylines
      mypoints :: [Float] -> [(Float,Float)]
      mypoints [a,b,c,d,e,f] = [(a,b),(c,d),(e,f)]


main = do
     input <- readFile "triangles.txt"
     print $ prob102 input
    