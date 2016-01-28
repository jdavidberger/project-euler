--module Main where

import Debug.Trace
import Data.List

palinize2 :: Integer -> Integer
palinize2 x = read $ (show x) ++ (reverse $ show x)

palinize3 :: Integer -> [Integer]
palinize3 x = map (\i -> read $ ((show x)) ++ (i : reverse (show x))) "0123456789"

palins2 = map palinize2 [1..] 
palins3 = [2..9] ++ concat (map palinize3 $ [1..])

isPalin x = (show x) == (reverse $ show x)
palins = filter isPalin [10..]

squares :: [Integer]
squares = (map (^2) [1..])
limit :: Integer
limit = 10^8
sqrtl = floor $ sqrt $ fromIntegral limit 

searchfunc :: Integer -> [Integer]
searchfunc target = rec_search 0 [] $  reverse (takeWhile (<target) squares)
                    where
                      rec_search :: Integer -> [Integer] -> [Integer] -> [Integer]
                      rec_search sm [] [] = []
                      rec_search sm l1 [] = 
                          if sm == target then l1 else 
                              if sm > target then 
                                 rec_search (sm - head l1) (tail l1) []
                              else []
                      rec_search sm l1 l2 =
                          if sm > target then rec_search (sm - head l1) (tail l1) l2
                          else if sm < target then rec_search (sm + head l2) (l1 ++ [head l2]) (tail l2)
                               else l1
   

prob125 :: [Integer]
prob125 = filter (/=0) $ map (sum.searchfunc) mypalins 
                  where
                    mypalins = concat (map (takeWhile (<limit)) [palins2,palins3])

main = putStrLn (show (sum prob125))