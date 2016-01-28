def hcf(a,b):
    c = 0
    while a > 0:
        c = b % a
        b = a
        a = c
    return b

def prob73():
    ans = 0
    for i in range(1,1000000):
        for c in range(2, i):
            if hcf(i,c) == 1:
                ans += 1
    return ans

print prob73()
