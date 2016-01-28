#!/usr/bin/python

import math
import eulerTools

eps = .000000000001

def cycle(lst):
    while True:
        for l in lst:
            yield l

def minXOf(d):
    sd = math.sqrt(d)
    a = math.floor(sd)
    
    if (a == sd):
        return (-1,-1,-1)
    af = sd
    

    hn1,hn2 = (1L,0L)
    kn1,kn2 = (0L,1L)
    hn = a * hn1 + hn2
    kn = a * kn1 + kn2
    p = hn**2 - d * (kn**2)
    
    a_list = []

    while af-a > eps and (math.floor(sd)*2 - a) > eps :
        af = 1. / (af - a)
        a = int(af)
        a_list.append( (a,af) )

#    print a_list
   # print a_list
    iter = cycle(a_list)
    
    i = 0
    while abs(p-1) > eps and i < len(a_list)+1:
        (a,af) = iter.next()
        i += 1
        hn1,hn2 = (hn, hn1)
        kn1,kn2 = (kn, kn1)

        hn = a * hn1 + hn2
        kn = a * kn1 + kn2
        p = (hn**2) - ((d) * (kn**2))
        print hn,kn,p
    return hn, kn, d
        

if __name__=='__main__':
    bst = (0,0,0)
    y = 0
#    print minXOf(103)
    for d in range(2,1001):
        print d
        i = minXOf(d)
        if bst[0] <= i[0]:
            bst = i
            print i
print bst
