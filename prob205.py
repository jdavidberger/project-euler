def combos(ls,n):
    if n == 0:
        return [[]]
    rtn = []
    for it in ls:
        for ls2 in combos(ls, n-1):
            ls2.append(it)
            rtn.append(ls2)
    return rtn

def histogram(perm):
    rtn = {}
    for p in perm:
        sp = sum(p)
        rtn[sp] = 1 + rtn.get(sp, 0)
    return rtn

pete = histogram(combos(range(1,5), 9))
cole = histogram(combos(range(1,7), 6))

played = 0
wins = 0
for pk in pete:
    for ck in cole:
        played += pete[pk] * cole[ck] 
        if pk > ck:
            wins += pete[pk] * cole[ck]

print round(wins / float(played),7)
