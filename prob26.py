def tail(x):
    rem = x
    num = 1
    rems = {}
    i = 0
    while rem > 0:
        if num in rems:
            return i - rems[num]
        rems[num] = i
        i += 1
        num *= 10
        if num / x > 0:
            num = num % x
            rem = num
    return 0

if __name__=='__main__':
    best = (0,0)
    for i in range(1001):
        l = tail(i)
        if l > best[0]:
            best = (l,i)
    print best[1]
    
