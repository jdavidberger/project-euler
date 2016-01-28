from math import *

def isPrime(x):
    x = abs(x)
    for i in range(2,int(sqrt(x))+1):
            if x % i == 0:
                return False
    return True


def primes(bound):
    x = [1]
    for i in range(3,bound):
        if isPrime(i):
            x.append(i)
    return x

def p27(ub):
    best = (0,0,0)
    ps = sum([[x,-x]for x in primes(ub)],[])
    for p1 in ps:
        for p2 in ps:
            n = 0
            while isPrime(n*n + p1*n + p2):
                n += 1
            if(best[0] <= n):
                best = (n, p1, p2)
                print best
    print best
