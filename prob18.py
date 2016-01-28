ex_tri = [[3],
          [7, 5],
          [2, 4, 6],
          [8, 5, 9, 3]]

tri =  [[75],
       [95,64],
       [17,47,82],
       [18,35,87,10],
       [20,04,82,47,65],
       [19,01,23,75,03,34],
       [88,02,77,73,07,63,67],
       [99,65,04,28,06,16,70,92],
       [41,41,26,56,83,40,80,70,33],
       [41,48,72,33,47,32,37,16,94,29],
       [53,71,44,65,25,43,91,52,97,51,14],
       [70,11,33,28,77,73,17,78,39,68,17,57],
       [91,71,52,38,17,14,91,43,58,50,27,29,48],
       [63,66,04,68,89,53,67,30,73,16,69,87,40,31],
       [04,62,98,27,23, 9,70,98,73,93,38,53,60,04,23]]



def reduce(row):
    return [ max(row[i], row[i+1]) for i in range(len(row)-1)]

def eadd(v1, v2):
    return [v1[i] + v2[i] for i in range(len(v1))]

def solve(triangle):
    if(len(triangle) == 1):
        return triangle
    triangle[-2] = eadd(triangle[-2], reduce(triangle[-1]))
    return solve(triangle[0:-1])

#print solve(tri)