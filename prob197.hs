
pwer = 30.403243784

divisor = log 1000000000 / log 2

f :: Double -> Double
f x = (fromIntegral $ floor $ 2.0 ** (pwer-x*x)) / 1000000000

log_f x = ((fromIntegral.floor) (pwer - (x*x))) - divisor


lu = 0 : map log_f lu
u = 1.0 : map f u

