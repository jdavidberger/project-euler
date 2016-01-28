from math import *

#import psycho 
#psyco.full()

class memoize:
  def __init__(self, function):
    self.function = function
    self.memoized = {}
    
  def __call__(self, *args):
    try:
      return self.memoized[args]
    except KeyError:
      if(len(self.memoized) > 100000):
        return self.function(*args)
      self.memoized[args] = self.function(*args)
      return self.memoized[args]


@memoize
def factor(target):
    a = []
    for i in range(2, int(sqrt(target))+1 ):
        if target % i == 0:
            return [i, target / i] + factor(i) + factor(target/i)
    return []

old = -1
acc = 0
for i in xrange(10000000,0,-1):
    if i % 10000 == 0:
        print i / 10. ** 7, acc
    new = len(factor(i))
    if old == new:
        acc += 1
    old = new


print acc
