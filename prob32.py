from math import *

def isPandigital2(x,y):
    z = x * y
    s = str(x) + str(y) + str(z)
    return len(s) == 9 and len(set(s))==9 and not "0" in s

def isPandigital(z):
    for i in range(1,int(sqrt(z))+1):
        if z % i == 0:
            if isPandigital2(i, z / i):
                return True
    return False

def p32s():
    return sum(set(x*y for x in range(1,5000) for y in range(1,10000/x) if isPandigital2(x,y)))

def p32():
    return sum(z for z in range(1000, 10001) if isPandigital(z))
