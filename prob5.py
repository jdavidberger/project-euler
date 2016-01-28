def check(a):
    for i in range(1,21):
        if a % i != 0:
            return i
    return None

#a = 20
#while(check(a) != None):
#    a = a * check(a)
#print a
a = 1
for i in range(21,1,-1):
    if check(a) != None:
        a = a * i
print a


