from prob35 import isPrime
from itertools import permutations

primes = set(i for i in range(1000,10000) if isPrime(i)) - set([1487, 4817, 8147])



def listDiffs(l):
    l.sort()
    return [ (i,j,k,i - j) for i in l for j in l for k in l if i > j > k and i -j == j - k]

def primePerms(x):
    return list(set(int(''.join(w)) for w in permutations(str(x)) if int(''.join(w)) in primes))

def isSpecial(x):
    l = listDiffs(primePerms(x))
    return len(l) > 0

if __name__=='__main__':
    for i in primes:
        if isSpecial(i):
            print i, listDiffs(primePerms(i))
