
def palindrone(a):
    return str(a)[::-1] == str(a)

def isABPalin(a):
    return palindrone(a) and palindrone(bin(a)[2:].lstrip("0"))

acc = 0
for i in range(1000000):
    if isABPalin(i):
        acc += i
print acc
