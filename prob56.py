def digi(x):
    return sum([ int(y) for y in str(x) ])

def p56():
    return max(digi(a**b) for a in range(100) for b in range(100))
