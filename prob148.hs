
import Debug.Trace

pascal = [1] : 
         ( map (\row -> zipWith (+) (row++[0]) (0:row) ) pascal )

scnt n = n * (n+1) `div` 2

p_count2 rows divby = length $ filter ((/=0).(`mod` divby)) $concat $ take rows pascal

p_count rows divby = 
    let total = scnt rows
        inper = scnt $ divby - 1 
        tris  = (rows `div` (divby)) 
        overlap = rows `mod` divby
        onendp = inper - (scnt  (divby-overlap))
        ndivby = inper * tris + onendp in
    trace (show (total, inper, tris, ndivby,  onendp, overlap)) $
          total - ndivby
        
test rows divby = (p_count rows divby, p_count2 rows divby)

main = print ":("
