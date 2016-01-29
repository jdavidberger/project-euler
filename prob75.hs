isEven n = (n `mod` 2) == 0

fib = 1 : 1 : zipWith (+) fib (tail fib)


limit = 2000000

prob75 = ans --map ans [1..10]

sqrs = map (\x -> [x,x^2]) [1..]

ans :: [[Integer]]
ans = [ [a,b,c] |  [c,cs] <- takeWhile ((<=limit`div`2).head) sqrs,
                   [a,as] <- takeWhile ((<=c).head) sqrs,
                   [b,bs] <- dropWhile ((<=c-a).head) (takeWhile ((<=a).head) sqrs),
                   cs == as + bs]
                 
main = print prob75
