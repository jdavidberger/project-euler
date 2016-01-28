module Main where

numdivby upper = (upper - 1) : (map eq [2..upper-1])
           where 
             eq x = upper - ( upper `div` x - 1) - x

prob72 = show $  numdivby 8

main = putStrLn $ prob72