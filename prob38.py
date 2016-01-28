def isPandigital(x):
    digits = set(str(i) for i in range(1,10))
    w = x
    return len(w) == 9 and set(w) == digits

def isFixedPandigital(x):
    w = ''
    i = 1
    while len(w) < 9:
        w += str( x * i )
        i += 1
    return int(w) if isPandigital(w) and i > 2 else 0

if __name__=="__main__":
    best = (1,-1)
    for i in range(1,10000):
        score = isFixedPandigital(i)
        if score > best[0]:
            best = (score, i)
            print best
    print best
    
