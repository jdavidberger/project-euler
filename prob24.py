from math import *

def getPermutation(nth, rem):
    if len(rem) == 0:
        return ''
    i = 0
    z = factorial(len(rem)-1)
    i = nth / z
    rtn = rem[i]
    rem.remove(rtn)
    return rtn + getPermutation(nth % z, rem)

def perm(r):
    return [getPermutation(i,list(r)) for i in range(factorial(len(r)))]

from itertools import *
def test(r):
    return perm(r) ==[''.join(word) for word in list(permutations(r))]


if __name__ == '__main__':
    print getPermutation(1000000-1, list('0123456789'))
