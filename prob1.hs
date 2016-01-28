
test x = (mod x 3 == 0) || (mod x 5 == 0)

range 0 = [0]
range n = n : (range (n-1))

upper_limit = 999

prob1 = sum( filter test (range upper_limit) )

main = print prob1