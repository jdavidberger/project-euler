from eulerTools import *
import sys

def star(x,i,j):
    return x[:i] + "*" + x[i+1:j] + "*" + x[j+1:]

def starDoubles(x):
    lst = []
    for i in range(len(x)-2):
        for j in range(i+1,len(x)-1):
            if x[i] == x[j]:
                lst.append(star(x,i,j))
    return lst
    
def hash(x):
    return int(x.replace("*","9") + x.replace("*","1"))

def isPrime( x):
    for j in range(2, int(sqrt(x))+1):
        if x % j == 0:
            return False
    return True

from itertools import *
import math

if __name__=='__main__':
    bounds = (.1,1)
    last_digit = ('1','3','7','9')
    insert = 3
    while bounds[1] <= 10000000:
        bounds = (int(bounds[0] * 10), bounds[1] * 10)
        
        perms = list(combinations(range(insert+int(math.log10(bounds[1]))),insert))
        print bounds
        print bounds[0] * 10 ** (insert+1), bounds[1] * 10 ** (insert+1),perms
        for g in [ list(str(z)) for z in range(bounds[0],bounds[1])] :
            g.append('0')
            for last in last_digit:
                g[-1] = last
                for perm in perms:
                    h = list(g)
                    for rm in perm:
                        h.insert(rm, '*')
                    lb = 0 if perm[0] != 0 else 1
                    fails = 0 + lb

                    for i in range(lb,10):
                        j = list(h)
                        for rm in perm:
                            j[rm] = str(i)
#                        print h, j
                        if not isPrime(int(''.join(j))):
                            fails += 1
                            if fails > 2:
                                break
                    else:
                        for i in range(lb,10):
                            j = list(h)
                            for rm in perm:
                                j[rm] = str(i)
                            if isPrime(int(''.join(j))):
                                print int(''.join(j))
        


if __name__=='__main__2':
    primes = primes_cache()
    score = {}
    i = 0
    try:
        while True:
            i += 1
            if isPrime(i):
                lst = starDoubles(str(i))
                if lst != []:
                    for entry in lst:
                        sc = hash(entry)
                        score[sc] = score.get(sc,0) + 1
                        if score[sc] >= 7:
                            print entry,i,sc
                            sys.exit()
    except:
        print i

