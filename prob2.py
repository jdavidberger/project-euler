i = 1
j = 1
answer = 0
while True:
    i, j = j, i + j
    if j > 4000000:
        break
    if j % 2 == 0:
        answer += j
print answer
