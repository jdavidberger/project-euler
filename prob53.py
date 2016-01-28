from math import *


def c(n,r):
    return factorial(n)/factorial(r)/factorial(n-r)

def upto(n):
    return (n*(n+1))/2

def p53():
    ll = 0 #22
    cnt = 0 #upto(ll)
    r,n = 0,1#ll+1
    while n <= 100:
        if r > n: #or c(n,r) > 1000000:
#            print n, r
            r = 0
            n += 1
        else:
            if c(n,r) > 1000000:    
                cnt += 1
            r += 1
            
    print cnt,upto(100)
    return upto(100)-cnt

def gap(i):
    j = 1
    while len(str(2**j)) < i:
        j += 1
    m = str(2**j)
    print m, j
    s = j
    j += 1
    while str(2**j)[-i:] != m:
        j += 1
    return s,j
