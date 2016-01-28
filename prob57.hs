
prob57 = 
    ( [ if tst then '_' else '.'  | i <- [1..100],
                   let num = h i,
                   let den = k i,
                   let tst = length (show num) > length (show den),
                   True])
        where
          a n = (1 : [2,2..]) !! n
          h (-1) = 1
          h (-2) = 0
          h n = (a n) * h (n-1) + h (n-2)
          k (-1) = 0
          k (-2) = 1
          k n = (a n) * k (n-1) + k (n-2)

    