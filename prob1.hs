
test x = (mod x 3 == 0) || (mod x 5 == 0)

range 0 = [0]
range n = n : (range (n-1))

prob1 =
    (sum( filter test (range 1000) )) - (sum ( filter (\x -> mod x 15 == 0) (range 1000)))