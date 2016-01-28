from math import *


if __name__=='__main__':
    bins = [0 for i in range(1000)]
    for a in range(1000):
        for b in range(a):
            c = sqrt(a**2 + b**2)
            if c == int(c):
                length = a + b + int(c)
                if length < 1000:
                    bins[length] += 1
                else:
                    break
    best = (0,0)
    for i in range(1000):
        if bins[i] > best[0]:
            best = (bins[i], i)
    print best[1]
