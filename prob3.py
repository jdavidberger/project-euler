from math import *

def f(target):
    i = floor(sqrt(target))
    while True:
        if target % i == 0:
            return i
        i=i+1

def factor(target):
    s = f(target)
    if s == target or s == 2:
        return [s]
    elif s == 1:
        return []
    else:
        return factor(s) + factor(target/s)

t = 600851475143
#t = 1396755360
print max(factor(t))
