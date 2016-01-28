#!/usr/bin/python
import sys

sys.setrecursionlimit(5000)

class memoize:
  def __init__(self, function):
    self.function = function
    self.memoized = {}

  def __call__(self, *args):
    try:
      return self.memoized[args]
    except KeyError:
      self.memoized[args] = self.function(*args)
      return self.memoized[args]

def iter(x):
    if x % 2 == 0:
        return x / 2
    return 3 * x + 1

@memoize
def collLength(x):
    if x == 1:
        return 1
    return 1 + collLength(iter(x))

def ncollLength(x):
    cnt = 1
    while x != 1:
        cnt = cnt + 1
        print x
        x = iter(x)
    return cnt

ans = 0
winner = 0

for i in range(1,1000000):
    if i % 100000 == 0:
        print i
    o, ans = ans, max(ans, collLength(i))
    if ans != o:
        winner = i
        print ans, i
        

print winner
