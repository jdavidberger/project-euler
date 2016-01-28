
a = 0
b = 1

def fib():
    global a,b
    a,b = b, a + b
    return b

def p25(x):    
    c = 0
    i = 1

    while len(str(c)) != x:
        c = fib()
        i = i + 1
    return i

print p25(1000)

