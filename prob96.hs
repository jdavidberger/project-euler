module Main where

import Data.Char
import Data.List
import Debug.Trace

ablock = [0..2] ++ [9..11] ++ [18..20]
bblock = map (+3) ablock
cblock = map (+3) bblock

dblock = map (+27) ablock
eblock = map (+27) bblock
fblock = map (+27) cblock

gblock = map (+27) dblock
hblock = map (+27) eblock
iblock = map (+27) fblock

blocks = ablock : bblock : cblock : dblock : eblock : fblock : gblock : hblock : iblock : []

block x = head (filter (elem x) blocks)

row x = [s..s+8] 
        where s =  9 * (x `div` 9)

col x = take 9 $ filter (\y -> mod x 9 == mod y 9) [0..81]

prettyPrint [] = []
prettyPrint puzzle = trace (show $ take 9 puzzle) (prettyPrint $ drop 9 puzzle)

solve puzzle 81 = puzzle
solve puzzle indx = 
--    trace (show puzzle) $
    if (puzzle !! indx) > 0 then 
        solve puzzle (indx + 1) 
    else
        if possibles == [] then [] else
            if answer == [] then [] else head answer
                                    where 
                                      answer = filter (/=[]) (map (\x -> solve (nextpuzzle x) (indx+1)) possibles)
                                      possibles = [1,2,3,4,5,6,7,8,9] \\ (myblock ++ mycol ++ myrow)
                                      nextpuzzle x = (take indx puzzle) ++ (x : (drop (indx+1) puzzle))
                                      myblock  = map (puzzle !!) (block indx)
                                      mycol = map (puzzle !!) (col indx)
                                      myrow = map (puzzle !!) (row indx)


test_puzzle = [0,0,3,0,2,0,6,0,0,9,0,0,3,0,5,0,0,1,0,0,1,8,0,6,4,0,0,0,0,8,1,0,2,9,0,0,7,0,0,0,0,0,0,0,8,0,0,6,7,0,8,2,0,0,0,0,2,6,0,9,5,0,0,8,0,0,2,0,3,0,0,9,0,0,5,0,1,0,3,0,0]                                          

soduku puzzle = solve puzzle 0

prob96code puzzle = foldl (\x a -> x * 10 + a) 0 $ take 3 $ soduku puzzle

prob96 :: String -> String
prob96 input = show $ sum $ map prob96code puzzles
    where
      mylines :: [String]
      mylines = map (take 9) (filter ((>=9).length) (lines input))
      str_puzzles :: [String]
      str_puzzles = map (\i -> take 81 $ drop ((i)*81) puzzleline ) [0..49]
      puzzles = map (map digitToInt) str_puzzles
      puzzleline = (foldl (++) "" mylines)


main = putStrLn (prob96)