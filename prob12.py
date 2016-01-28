from math import *

def factor(target):
    a = []
    for i in range(1,int(sqrt(target) + 1 )):
        if target % i == 0:
            a.append(i)
            if i != target / i:
                a.append(target / i)
    return a

def p12(x):
    i = 0
    t = 0
    while True:
        i = i + 1
        t = i + t
        if i % 10000 == 0:
            print t, len(factor(t))
        if len(factor(t)) > x:
            return t

print p12(5)
print p12(500)

