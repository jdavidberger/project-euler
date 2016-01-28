from math import *
def isPrime(x):
    s = sqrt(x)
    for i in range(2,int(s)+1):
        if x % i == 0:
            return False
    return True


primes = [i for i in xrange(2,10000) if isPrime(i)]

def pFactors(x):
    if x == 1:
        return []
    for p in primes:
        if x % p == 0:
            return pFactors(x/p) + [p]
    print x, '<---'

def isAnswer(x):
    f1 = set(pFactors(x))
    f2 = set(pFactors(x+1))
    f1_2 = f1 ^ f2
    print f1_2,f1,f2
    if len(f1_2) > 0:
        f3 = set(pFactors(x+2))
        f1_3 = f1_2 ^ f3
        print f1_3, f3
        if len(f1_3) > 0:
            f4 = set(pFactors(x+3))
            f1_4 = f1_3 ^ f4
            print f1_4, f4
            return len(f1_4) > 0
    return False

def p47():
    i = 644
    while not isAnswer(i):
        i += 1
    print i
