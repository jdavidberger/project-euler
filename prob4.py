import sys

def palindrome(a):
    return str(a)[::-1] == str(a)

ans = []

for i in range(999,99,-1):
    for j in range(i,99,-1):
        if palindrome(i*j):
            ans = ans + [i * j]

print max(ans)
