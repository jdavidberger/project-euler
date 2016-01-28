
import Data.List

perm :: [Int] -> [[Int]]
perm [a] = [[a]]
perm x = 
    concat $ map (\y -> map (y:) (perm (y `delete` x )) ) x


prob68 f = 
    [(a,b,c,
      d,e,
       g,h,i,
        j) | [a,b,c,d,g,h,i,j] <- perms,
             let sm = a + g + h,
             let e = 10,
          --   let f = 2,
             b + h + i == c + i + j,
             c + i + j == d + j + f,
             d + j + f == e + f + g, 
             a + g + h == b + h + i ]
    where perms = perm (delete f [1..9])
             
