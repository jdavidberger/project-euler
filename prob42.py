def word_n(x):
    return sum(ord(i) - ord('A') + 1 for i in x)

def t(n):
    return (n*(n+1))/2

def p42():
    max = 193
    triangles = ([t(n) for n in range(1,21)])
    print triangles
    words = [ word.strip('"') for word in open('words.txt','r').read().split(',') ]
    return len([ x for x in words if word_n(x) in triangles])
