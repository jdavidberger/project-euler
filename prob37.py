from prob27 import *



def isSP(sp, x):
    #illegal = set(["0", "2", "4","6","5","8"])
    w = str(x)
    #if len(set(w) & illegal) > 0:
    #    return False
    
    for i in range(1,len(w)):
        if not int(w[:i]) in sp or not int(w[i:]) in sp:
            return False
    return True

def p37():
    sp = set([2,3,5,7])
    i = 10
    c = 0
    while c < 11:
        i += 1
        if isPrime(i):
            sp.add(i)
            if isSP(sp, i):
                print i
                c += 1
    print sp
