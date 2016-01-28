def s(x):
    return set(str(x))

def test(x):
    return len(s(6*x) & s(5*x) & s(4*x) & s(3*x) & s(2*x) & s(x)) == len(s(x)) == len(s(6*x))

def p52():
    i = 1
    while not test(i):
        i += 1
    print [z * i for z in range(1,7)]
    return i
