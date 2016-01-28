module Main where

import Data.List

-- | String split in style of python string.split()
split :: String -> String -> [String]
split tok splitme = unfoldr (sp1 tok) splitme
    where sp1 _ "" = Nothing
          sp1 t s = case find (t `isSuffixOf`) (inits s) of
                      Nothing -> Just (s, "")
                      Just p -> Just (take ((length p) - (length t)) p,
                                      drop (length p) s)

toint x = read x :: Int

prob99 input = show (maximum values )
    where
      exp [a,b] = a^b
      mylines = lines input
      mynumbers = map ((map toint).split ",") mylines
      values = map exp mynumbers

main = interact (prob99)