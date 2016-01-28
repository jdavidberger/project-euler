from math import *

def isPrime(x):
    i = sqrt(x)
    if int(i+1) == i:
        return False
    for s in xrange(2,int(i+1)):
        if x % s == 0:
            return False
    return True

if __name__=='__main__':
    acc = 0
    for t in range(2,2000000):
        if isPrime(t):
            acc = acc + t
    print acc
