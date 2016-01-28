
eex = ns 
      where
        atail = 1 : 2 : 1 : (map (\x -> if x > 1 then x+2 else 1) atail)
        as = 2 : atail
        ns = zipWith3 (\x y a -> a*x + y) (1:ns) (0:1:ns) (as)

adddigits 0 = 0
adddigits x = (mod x 10) + (adddigits (div x 10))


target = 100
prob65 = 
    adddigits (eex !! (target - 1))

main = print prob65
