import qualified Data.Map as Map
import Data.List
import Euler
import Data.Maybe

squaresOfLength n =
  takeWhile ((10^n)>) $ dropWhile ((10^(n-1))>) squares

genMaps wrd =
  let sqr = squaresOfLength (length wrd)
  in catMaybes $ map (genMap wrd) sqr

genMap wrd n =
  let fwd = 
        Map.fromListWith (\a b -> nub (a ++ b)) $
        zip (show n) $ map (:[]) wrd
      bck = 
        Map.fromListWith (\a b -> nub (a ++ b)) $
        zip wrd $ map (:[]) (show n)
      is1to1 m =
        all ((==1).length) $ map snd $ Map.toList m
  in if is1to1 fwd && is1to1 bck then
       Just (Map.map head bck)
     else Nothing

remapWord m wrd =
  map ((Map.!) m) wrd

mapNums :: [String] -> Map.Map Char Char -> Maybe [Int]
mapNums lst m =
  let nums  = map (remapWord m) lst
      isValid n = head n /= '0' && (isSquare $ read n)
  in if all isValid nums then Just (map read nums) else Nothing

findValidNums lst =
  let maps = genMaps $ head lst
  in catMaybes $ map (mapNums lst) maps
                                              
prob98 wrds =
  let f wrd = (sort wrd, [wrd])
      anlist = 
        filter ((>1).length) $
        map snd $ Map.toList $ Map.fromListWith (++) $ map f wrds
  in maximum $ concat $ concat $ map findValidNums anlist

readWords :: String -> [String]
readWords c = read $ "[" ++ c ++ "]"
  
main = do
  contents <- readFile "p098_words.txt"
  print $ prob98 (readWords contents)

