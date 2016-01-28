from prob10 import isPrime

def divlist(x):
    return [ str(x * i).rjust(3,'0') for i in range(1,1+1000/x)]

def comb(x1,x2):
    return [ y2[0] + y1 for y1 in x1 for y2 in x2 if y1[0] == y2[1] and y1[1] == y2[2] ]

def isUnique(x):
    return len(set(x)) == len(x)

def addMissing(x):
    return int(list((set('0123456789') - set(x)))[0] + x)
   

if __name__=='__main__':
    primes = [i for i in range(2,18) if isPrime(i)]
    print primes
    rules = filter(isUnique, reduce(comb, [divlist(i) for i in primes[::-1]]))
    print sum(map(addMissing,rules))


