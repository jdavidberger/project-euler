import qualified Data.Set as Set
import Data.Char
import Debug.Trace
import Euler
import Data.Choose
import Data.Maybe

maybeNext Nothing = Nothing
maybeNext (Just a) = next a

digs 0 = []
digs x = digs (x `div` 10) ++ [x `mod` 10]

digs' x n =
  let ds = digs x
  in if length ds == n then ds
     else (take (n - length ds) $ repeat 0) ++ ds

getLists n k =
  map elems $ catMaybes $ takeWhile (/=Nothing) $ iterate maybeNext $ Just $ choose n k 

dies = map (map (\d -> toInteger (if d == 9 then 6 else d))) $ getLists 10 6 

combos = [ [a,b] |
           a <- dies,
           b <- dies ]

canForm' diePair digs =
  all id $ zipWith elem digs diePair

canForm diePair n =
  canForm' diePair ds || canForm' (reverse diePair) ds where ds = digs' n 2

relSquares = [1,4,6,16,25,36,46,64,81]

prob90_filter diePair =
  all (canForm diePair) relSquares

prob90 =
  div (length $ filter prob90_filter combos) 2
  
main = print $ prob90
