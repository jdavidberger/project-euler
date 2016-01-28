from math import *

def test(x):
    sx = str(x)
    return x == sum( factorial(int(sx[i])) for i in range(len(sx)))

acc = 0
for i in range(3, 100000):
    if test(i):
        acc += i

print acc
