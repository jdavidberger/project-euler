thirtyonedays = [0,2,4,6,7,9,11]
thirtydays = [3,5,8,10]
months = ["Jan","Feb","Mar","April","May","June","July","August","September", "Oct", "Nov", "Dec"]
days = ["Monday","Tuesday","Wednesday","Thursday","Friday", "Saturday", "Sunday"]

def isLeapYear(year):
    if year % 4 == 0 and year % 100 != 0:
        return True
    return False

def daysIn(month,year):
    if month in thirtyonedays:
        return 31
    elif month in thirtydays:
        return 30
    elif isLeapYear(year):
        return 29
    return 28

if __name__=='__main__':
    day = 1
    acc = 0

    for year in range(1,101):
        for month in range(12):
            print days[day] + ", " + months[month] + " " + str(year + 1900)
            if day == 6:
                acc += 1
            day = (day + daysIn(month,year)) % 7
    print acc

      
