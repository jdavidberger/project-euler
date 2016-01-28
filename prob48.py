def p48(x):
    acc = 0
    for i in range(1,x+1):
        acc = acc + i ** i
    return acc

print p48(1000)
