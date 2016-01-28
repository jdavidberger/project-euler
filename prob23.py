from math import *

def prop_factors(x):
    r = [1]
    for i in range(2,int(sqrt(x))+1):
        if x % i == 0:
            r.append(i)
            if(i != x / i):
                r.append(x/i)
                
    return r

def isAbun(x):
    return x < sum(prop_factors(x))



def abun(ub):
    return set(sum([ [x] if isAbun(x) else [] for x in range(1,ub) ],[]))

def p23():
    ub = 28123
    ab = abun(ub)
    print(len(ab))
    tar = set(range(ub))
    for i in range(len(ab)):
        for j in range(i,len(ab)):
            if ab[i] + ab[j] in tar:
                 tar.remove(ab[i]+ab[j])
    return sum(tar)

def p23o():
    ub = 28123
    ab = abun(ub)
    return sum(i for i in range(ub) if not any(i-a in ab for a in ab))
