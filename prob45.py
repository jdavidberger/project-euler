def word_n(x):
    return sum(ord(i) - ord('A') + 1 for i in x)

def p(n):
    return (n*(3*n-1))/2
def h(n):
    return (n*(2*n-1))
def t(n):
    return (n*(n+1))/2

def p45():
    max = 193
    tn = 285
    pn = 165
    hn = 143
    print p(pn), h(hn), t(tn)
    tns = set([t(n) for n in range(tn, tn + 100000)])
    pns = set([p(n) for n in range(pn, pn + 100000)])
    hns = set([h(n) for n in range(hn, hn + 100000)])
    print tns & pns & hns
    
