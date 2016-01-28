if __name__=='__main__':
    curr = 0
    wanted = [ i for i in range(1,20)]
    count = 0
    ans = ''
    while len(wanted) > 0:
        count += len(str(curr))
        curr += 1
        print str(curr)
        if wanted[0] <= count:
            print count, curr, wanted, str(curr)[count - wanted[0]]
            ans += str(curr)[count - wanted[0]]
            wanted.remove(wanted[0])
    print ans
           
