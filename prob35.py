from math import *

def factor(target):
    a = []
    for i in range(1, int(sqrt(target))+1 ):
        if target % i == 0:
            a.append(i)
            if i != target / i:
                a.append(target / i)
    return a

def isPrime(x):
    return len(factor(x)) == 2

def iter(x):
    return x[-1] + x[0:-1]

def isCircular(x):
    s = str(x)
    if not("2" in s or "4" in s or "5" in s or "6" in s or "8" in s or "0" in s) and isPrime(x):
        for i in range(len(s)):
            s = iter(s)
            if not isPrime(int(s)):
                return False
        return True
    return False

if __name__ == '__main__':
    acc = 0
    for i in xrange(2,1000000):
        if i % 100000 == 0:
            print i/1000000.0
        if isCircular(i):
            acc += 1
    print acc
