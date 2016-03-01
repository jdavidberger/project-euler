const Graph = require('node-dijkstra')
const fs = require('fs')

var mat = fs.readFileSync("p083_matrix.txt", 'utf8');

var rows = mat.split("\n");

var matrix = []; 
for(var i = 0;i < rows.length;i++) {
  var row = rows[i].split(",").map(Number);
  if(row.length > 1)
    matrix.push(row);
}

var graph = {};

for(var i = 0;i < matrix.length;i++) {
  for(var j = 0;j < matrix[i].length;j++) {
    graph[i + ", " + j] = {}; 
  }
}

function addEdge(i,j, ti, tj) {
  var cost = matrix[ti] == undefined ? undefined : matrix[ti][tj]; 
  if(cost == undefined)
    return;
  graph[i + ", " + j][ti + ", " + tj] = cost; 
}

for(var i = 0;i < matrix.length;i++) {
  for(var j = 0;j < matrix[i].length;j++) {
    addEdge(i,j,i-1,j);
    addEdge(i,j,i+1,j);
    addEdge(i,j,i,j+1);
    addEdge(i,j,i,j-1);    
  }
}

var G = new Graph(graph);

var ans = G.path("0, 0", "79, 79", { cost: true }); 
console.log(ans.cost + matrix[0][0]);
