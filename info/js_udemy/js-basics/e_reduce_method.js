// using spread to solve addding the numbers

function sum(...items) {
  if (Array.isArray(items) && Array.isArray(items[0]))
    return items[0].reduce((a, b) => a + b);
  else
    return items.reduce((a, b) => a + b);


}

console.log(sum([1, 2, 3, 4]));
