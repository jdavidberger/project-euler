module Main where

import List

p :: Int -> [Int]
p x = map (\n -> n * ( (x-2) * n + (4-x)) `div` 2) [1,2..]

p_i :: Int -> Int -> Int -> [Int]
p_i l u x = filter (>l) (takeWhile (<u) (p x))

inrange :: [Int] -> Int -> Int -> [Int]
inrange l b u = dropWhile (<b) (takeWhile (<u) l)

flatten :: [[a]] -> [a]
flatten = foldl (++) []

make_circular :: Int -> [[Int]] -> [(Int, [[Int]])]
make_circular x lst = filter (\z -> (mod (fst z) 100) > 9) 
                      (flatten (map (\a -> map (\b -> (b, delete a lst)) (inrange a y (y+100))) lst))
                      where y = (mod x 100) * 100
                            
prob61 = head [ [a,b,c,d,e,f] | a <- filter (\x -> (mod x 100) > 10 ) (p_i 999 9999 8),
                          (b,bl) <- make_circular a (map (p_i 999 9999) [3,4..7]),
                          (c,cl) <- make_circular b bl,
                          (d,dl) <- make_circular c cl,
                          (e,el) <- make_circular d dl,
                          let f = (mod e 100) * 100 + (div a 100),
                          elem f (head el)]

main =     putStrLn (show (sum prob61))