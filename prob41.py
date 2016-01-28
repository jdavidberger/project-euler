import prob10
from itertools import *

def numify(x):
    return int(''.join(x))

def numifya(x):
    print numify(x)
    return numify(x)

if __name__=='__main__':
    a= list([ numifya(z) for z in permutations('7654321') if prob10.isPrime(numify(z)) ])
    a.sort()
    print a

