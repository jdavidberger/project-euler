base = ["one","two","three","four","five","six","seven","eight","nine"]
tens = ["","","twenty","thirty","forty","fifty","sixty","seventy","eighty","ninety"]
teens = ["ten","eleven","twelve","thirteen", "fourteen","fifteen","sixteen","seventeen","eighteen","nineteen"]
def wordify(num):
    if num == 1000:
        return "onethousand"
    h = num / 100
    t = (num / 10) % 10
    o = num % 10 
    word = ""
    if h > 0:
        word = base[h-1] + "hundred"
        if t > 0 or o > 0:
            word += "and"
    if t > 1:
        word += tens[t]
    if t == 1:
        word += teens[o]
    elif o > 0:
        word += base[o-1]
    print num, h,t,o,word
    return word

if __name__=='__main__':
    acc = 0
    for i in range(1,1001):
        acc += len(wordify(i))
    print acc 
