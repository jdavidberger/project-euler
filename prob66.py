#!/usr/bin/python

import math
import eulerTools
from fractions import gcd

eps = .00001

def cycle(lst):
    while True:
        for l in lst:
            yield l


def from_root(n):
    '''
    Construct a continued fraction from a square root. The argument
    `n` should be an integer representing the radicand of the root:
        >>> from_root(2)
        (1, [2])
        >>> from_root(4)
        (2,)
        >>> from_root(97)
        (9, [1, 5, 1, 1, 1, 1, 1, 1, 5, 1, 18])
    '''
    a0 = int(math.floor(math.sqrt(n)))
    r = (a0, [])
    a, b, c = 1, 2 * a0, a0 ** 2 - n
    delta = math.sqrt(4*n)
    
    while True:
        try:
            d = int((b + delta) / (2 * c))
        except ZeroDivisionError: # a perfect square
            return (r[0],)
        a, b, c = c, -b + 2*c*d, a - b*d + c*d ** 2
        r[1].append(abs(d))
        if abs(a) == 1:
            break
    return r

def minXOf(d):
    sd = math.sqrt(d)
    a = int(math.floor(sd))
    if (a == sd):
        return (-1,-1,-1)
    
    a_list = from_root(d)[1]
    af = sd

    hn1,hn2 = (1L,0L)
    kn1,kn2 = (0L,1L)
    hn = a * hn1 + hn2
    kn = a * kn1 + kn2

    iter = cycle(a_list)    

    rtn = (-1,-1,-1)
    i = 0
    while True:
        a = iter.next()

        i += 1
        hn1,hn2 = (hn, hn1)
        kn1,kn2 = (kn, kn1)

        hn = a * hn1 + hn2
        kn = a * kn1 + kn2
        p = pow(hn,2) - (d * pow(kn,2))
        if abs(p - 1.0) < eps:
            g = gcd(hn,kn)
            return (d, hn,kn)
    return rtn

if __name__=='__main__':
    bst = (0,0,0)
    y = 0
    for d in range(2,1001):
        i = minXOf(d)
        #print i
        if bst[1] <= i[1]:
            bst = i
            #print i
    print bst
