def test(x):
    sx = str(x)
    return x == sum( int(sx[i]) ** 5 for i in range(len(sx)))

acc = 0
for i in range(999, 1000000):
    if test(i):
        acc += i

print acc
