import prob35
from itertools import permutations

class primes_cache:
    def isPrime(self, x):
        if x <= self.upper_bound:
            return x in self.primes
        else:
            for i in range(self.upper_bound, x+1):
                if prob35.isPrime(i):
                    self.primes.add(i)
                    self.upper_bound = x
            return x in self.primes
    
    def __init__(self):
        self.primes = set([])
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
        while True:
            self.upper_bound += 1
            if prob35.isPrime(self.upper_bound):
                self.primes.add(self.upper_bound)
                yield self.upper_bound
        
def check(x,primes):
    if x % 2 == 0:
        return True
    for s in range(x):
        if 2*s**2 <= x:
            t = x - (2*s ** 2)
            if t==0 or primes.isPrime(t):
                return True
        else:
            return False
    return False

def p46():
    primes = primes_cache()
    i = 1
    while True:
        i += 2
        if not primes.isPrime(i):
            if not check(i, primes):
                return i
        
if __name__=='__main__':
    print p46()
