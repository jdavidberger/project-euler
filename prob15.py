def paths(x,y):
    rows = [[1 for i in range(x)]]
    for i in range(1,y):
        rows.append([1 for z in range(x)])
        for j in range(1,x):

            rows[i][j] = rows[i-1][j] + rows[i][j-1]
    return rows

if __name__=='__main__':
    print paths(21,21)[-1][-1]
    
