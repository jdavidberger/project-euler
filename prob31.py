denoms=range(1,100)
denoms.reverse()

def ways(target,den):
    if target == 0:
        return 1
    acc = 0
    for i in range(len(den)):
        x = den[i]
        if x <= target:
            acc += ways(target-x,den[i:])
    return acc

if __name__=='__main__':
    print ways(100,denoms)
