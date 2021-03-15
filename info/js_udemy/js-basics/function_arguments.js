// every function in java has a special argument called arguments

function sum(a, b) {
  console.log(arguments)
  return a + b;
}


console.log(sum(1, 2, 3, 4, 5));
