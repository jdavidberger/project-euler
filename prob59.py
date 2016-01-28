#!/usr/bin/python

def bin(x):
    r={}
    for c in x:
        r[c] = r.get(c,0) + 1
    return [(r[k],k) for k in r]
        
if __name__=='__main__':
    msg = map(int, open('cipher1.txt','r').read().split(','))
    c = [ list(( msg[i] for i in range(len(msg)) if (i-j) % 3 == 0 ))
          for j in range(3) ]
    
    pss = [  ord(' ') ^ o[1] for o in list([max(bin(c2)) for c2 in c])]
    print map(chr,pss)

    decode = [(pss[i % 3] ^ msg[i]) for i in range(len(msg))]
    print ''.join(map(chr,decode))
    print sum(decode)
    
