from io import *


def value(name):
    return sum([ord(c)-ord('A')+1 for c in name])


if __name__ == '__main__':
    lines = sum([[ word.strip('"') for word in line.split(',')] for line in open('names.txt','r') ],[])
    lines.sort()
    acc = 0
    print(value("COLIN"))
    for i in range(len(lines)):
        if lines[i] == u"COLIN":
            print ((i+1) * value(lines[i])), i
        acc += (i+1) * value(lines[i])
    print acc
