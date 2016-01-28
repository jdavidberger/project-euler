
import Data.Map (Map)
import qualified Data.Map as Map
import Debug.Trace

squares = map (^2) [1,2..]


findXY s t =
  let y = ( s - t ) `div` 2
      x = s - y
  in (x, y)

doubleAnswersFor s =
  map (findXY s) $
  filter (\t -> (s-t) `mod` 2 == 0) $
  takeWhile (<s) squares

doubles = concat $ map doubleAnswersFor squares

triples =
  let filterDoubles (dict,_) (x,z) =
        let xMap = Map.findWithDefault Map.empty x dict
            zMap = Map.findWithDefault Map.empty z dict 
            checkEntry a =
              Map.member z $ Map.findWithDefault Map.empty a dict
            yList = 
              map fst $
              Map.toList $
              xMap              
            ySolutions =
              filter checkEntry yList
            newXMap = Map.insert z 0 xMap
            newZMap = Map.insert x 0 zMap
            newDict =
              Map.insert z newZMap $
              Map.insert x newXMap  dict
            newResults =
              (map (\y -> [x,y,z])) ySolutions
        in
          (newDict, newResults) in
  map head $
  filter (not.null) $
  map snd $ scanl filterDoubles (Map.empty, []) doubles

main = print $ sum $ head $ triples
