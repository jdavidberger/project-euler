module Main where

import Data.List

isPan x = (sort x) == "123456789"

isPanFib x = b == "123456789" && c == "123456789" 
    where a = x `mod` 1000000000
          b = sort (show a)
          c = sort $ take 9 $ show x
         
isFibPan n = b == "123456789" && c == "123456789"
    where a = n `mod` 1000000000
          b = sort (show a)
          c = sort $ take 9 $ show n

fib = 1 : 1 : zipWith (+) fib (tail fib)

prob104 =   
    snd.head $ dropWhile (not.isPanFib.fst) (zip fib [1..])
    
main = putStrLn $ show $ prob104