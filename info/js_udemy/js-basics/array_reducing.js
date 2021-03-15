// regular
const numbers = [1, 2, 3, 4, 5, 6];

let sum = 0;

for (let n of numbers)
  sum += n;

console.log(sum);

// reduce method

// takes a function and initial value for the accumulator (first value)
// accumulator is an initializer
const sum1 = numbers.reduce((accumulator, currentValue) => {
  return accumulator += currentValue;
}, 0);

console.log(sum1);


// smaller version
const sum2 = numbers.reduce(
  (accumulator, currentValue) => accumulator += currentValue
);

console.log(sum2);
