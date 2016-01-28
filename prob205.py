import random


def round(dice, sides):
    total = 0
    for i in range(dice):
        total += random.randrange(1,sides+1)
    return total

def prob205():
    sm = 1
    tot = 1
    while True:
        try:
            sample_size = 100000
#        tot += sample_size
            pete = map( (lambda x: round(9,4)), range(sample_size))
            cole = map( (lambda x: round(4,6)), range(sample_size))
            for ps in pete:
                for cs in cole:
                    tot += 1
                    if ps > cs:
                        sm += 1
        #       sm += len( filter( (lambda (x,y): x > y), games)
            print str(sm / float(tot))
        except:
            print str(sm / float(tot))
    return sm
    

if __name__=="__main__":
    print str(prob205())
