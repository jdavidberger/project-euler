from math import *

for a in range(1000):
    for b in range(1000):
        c = sqrt(a * a + b * b)
        if c == floor(c) and a + b + c == 1000:
            print a, b, c
            break
