from math import *

def factor(target):
    a = []
    for i in range(1, int(sqrt(target))+1 ):
        if target % i == 0:
            a.append(i)
            if i != target / i:
                a.append(target / i)
    return a

def d(n):
    return sum(factor(n))-n

acc = 0
for i in range(1,10000):
    dn = d(i)
    if i == d(dn) and i != dn:
        print i
        acc += i

print acc

