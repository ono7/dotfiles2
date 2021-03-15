const numbers = [1, 2, 3, 4, 5, 6, 7]
console.log(numbers);

// middle
numbers.splice(3, 1);
console.log(numbers);

// end
const last = numbers.pop();
console.log(numbers);

// first
const first = numbers.shift();
console.log(numbers);
