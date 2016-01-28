
cardvalue = { 'T': 10, 'J': 11, 'Q': 12, 'K': 13, 'A': 14 }
cardvalue.update(dict([ (str(i),i) for i in range(1,10)]))

def hasFlush(cards):
    return len(set([card[1] for card in cards])) == 1

def mults(cards):
    lst = {}
    for i in range(len(cards)):
        for j in range(i):
            if cards[i] == cards[j]:
                lst[cards[i]] = lst.get(cards[i],set([])) | set([i,j])
    return lst

def setOf(cards,n):
    m = mults(cards)
    return list(filter(lambda k: len(m[k]) == n, m))

def pairs(cards): return setOf(cards, 2)

def triples(cards): return setOf(cards, 3)

def quads(cards): return setOf(cards, 4)

vranks = [ 'High Card', 'Pair', 'Two pair', 'Three of a kind', 'Straight', 'Flush', 'Full House', 'Four of a kind', 'Straight Flush', 'Royal Flush' ]

ranks = [  10 ** i for i in range(0, 20,2) ] 
print ranks
def verbose(v):
    for i in range(len(vranks)-1)[::-1]:
        lv = (v[0] / ranks[i]) % 100
        if lv > 0:
            return str(v[1]) + " " + vranks[i] + " with " + str(lv) + " high"
    print v

def value(cards):
    values = [cardvalue[c[0]] for c in cards]
    ace_low = map(lambda x: 1 if x == 14 else x, values)
    rtn = max(values)

    pairs = setOf(values,2)
    trips = setOf(values,3)
    quads = setOf(values,4)

    mny_map = [ (ranks[1], pairs), (ranks[3], trips), (ranks[7], quads) ]
    rtn += sum( map(lambda (v,f): max(f) * v if len(f) > 0 else 0, mny_map) )
    rtn += ranks[2] * (max(pairs) if len(pairs) > 1 else 0)

    straight = max([(max(values) if max(values) - min(values) == 4 and len(set(values))==5 else 0), 
                    (max(ace_low) if max(ace_low) - min(ace_low) == 4 and len(set(values))==5 else 0)])

    rtn += ranks[4] * straight

    rtn += ranks[5] * (max(values) if hasFlush(cards) else 0)
    rtn += ranks[6] * (max(trips) if len(pairs) > 0 and len(trips) > 0 else 0)
    
    rtn += ranks[8] * (straight if hasFlush(cards) else 0)

    return rtn,cards

if __name__=='__main__':
    print verbose(value(["1C", "2C", "3C", "4C", "AS"]))
    round = map( lambda l : l.split(), open('poker.txt','r'))
    outcomes = map( lambda c : (value(c[:5]), value(c[5:])), round)
    for o in outcomes:
        if o[0][0] > ranks[3] or o[1][0] > ranks[3]:
            print verbose(o[0]) + " versus " + verbose(o[1])
    print ranks[3]
    print len(filter(lambda o: o[0][0] >= o[1][0], outcomes))
    print len(filter(lambda o: o[0][0] < o[1][0], outcomes))
