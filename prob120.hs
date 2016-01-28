
period a = (head plist) : (takeWhile (/= head plist) (tail plist))
    where
      plist = filter (/=2) $ r a


r a = map (\n -> (as1^n + ap1^n) `mod` a2) [0..]
    where as1 = a - 1
          ap1 = a + 1
          a2 = a^2

prob120 = sum (map (maxlist.period) [3..1000])
          where maxlist = foldl1 max

    
main = putStrLn $ show $ prob120