def isPalindrome(x):
    return str(x)[::-1] == str(x)

def lyiterate(x):
    return x + int(str(x)[::-1])

def isLycherl(x):
    for i in range(50):
        x = lyiterate(x)
        if isPalindrome(x):
            return False
    return True

cnt = 0
for i in range(10000):
    if isLycherl(i):
        cnt = cnt + 1

print cnt
