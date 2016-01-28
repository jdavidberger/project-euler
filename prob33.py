
def isCur(num,den):
    for f,s in [(0,1),(1,0),(1,1),(0,0)]:
        if num[f] == den[s] and num[f] != '0' and den[s] != '0':
            anum, aden = float(num[s]), float(den[f])
            if aden != 0 and anum / aden == float(num) / float(den):
                return True            
    return False

def p33():
    return [(n,d) for d in range(10,101) for n in range(10,d) if isCur(str(n),str(d))]

