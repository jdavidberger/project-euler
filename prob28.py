
def corners(x):
    acc = []
    while x > 1:
        acc += [(x ** 2 - (x-1)*i for i in range(4))]
        x -= 2
    return acc
