from math import * 
import random 

def modexp_rl(a, b, n):
    r = 1
    while 1:
        if b % 2 == 1:
            r = r * a % n
        b /= 2
        if b == 0:
            break
        a = a * a % n

    return r


def isPrime(x):
    for j in range(2, int(sqrt(x))+1 ):
        if x % j == 0:
            return False
    return True

import MillerRabin

def isProbSmallPrime(n):
    pass

def isProbPrime(n):
    
    if n < 62:
        return isPrime(n)
    if n % 2 == 0:
        return False
#    return MillerRabin.miller_rabin(n,5)

    s = 0
    n1 = n - 1
    while n1 % 2 == 0:
        s += 1
        n1 = n1 / 2
    d = n1

    for a in [ 2, 7, 61]:
        x = modexp_rl(a,d,n)
        if x == 1 or x == n - 1:
            continue
        else:
            for r in range(1,s):
                x = x ** 2 % n
                if x == 1:
                    return False
                if x == n - 1:
                    break
            else:                
                return False
    return True



class primes_cache:
    def baseIsPrime(self, x):
        ub = self.upper_bound
        self.upper_bound = max(self.upper_bound,x)
        for i in range(ub, x+1):
            for j in self.upto(ceil(sqrt(i))):
                if x % j == 0:
                    return False
        self.primes.add(i)
        return True

    def isPrime(self, x):
        if x <= self.upper_bound:
            return x in self.primes
        else:
            return self.baseIsPrime(x)
    
    def __init__(self):
        self.primes = set([2,3])
        self.upper_bound = 1

    def __iter__(self):
        return self                 # simplest iterator creation

    def upto(self,x):
        i = 0
        while i <=x:
            i += 1
            if self.isPrime(i):
                yield i
            

    def next(self):
        yield 2
        yield 3
        while True:
            self.upper_bound += 1
            p = self.upper_bound
            if self.baseIsPrime(p):
                self.primes.add(p)
                yield p
