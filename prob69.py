
def prob69():
    cm = 1
    for i in range(1,10000):
        cm = cm * i
        if cm > 1000000:
            return cm / i
        
