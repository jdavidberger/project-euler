import eulerTools

def corner_i():
    i = 1
    while True:
        i += 2
        yield i, [i ** 2 - (i-1)*j for j in range(4)]

if __name__=='__main__':
    total = 1
    primes = 0.
    for cs in corner_i():
        for c in cs[1]:
            total += 1.
            primes += 1. if eulerTools.isProbPrime(int(c)) else 0.
        if(primes / total < .10):
            print cs
            break
        
        
    
