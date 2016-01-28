
squares = map (^2) [1,2..]

isSquare x = let sx = sqrt $ fromIntegral x in floor sx == ceiling sx

doubles = map (\y -> (y, reverse [ z | z <- [1..y],
                           isSquare (y+z),
                           isSquare (y-z) ])) [1..]

prob142 = [(x,lst) | (x,lst) <- doubles,
                     length lst > 1,
                     snd (doubles !! ((head lst)-1)) == (tail lst)]
                            