let numbers = [1, 2, 3, 4, 5, 6]

let another = numbers;

// solution 1, if not constant, just assign it an empty array
// does not work if there are multiple references to the array
// numbers = [];

// solution 2, setting length to 0 truncates the array, elegant
// numbers.length = 0;
// console.log(numbers);

// solution 3, use splice method
// numbers.splice(0, numbers.length)

// solution 4, not recommended for big arrays
// while (numbers.length > 0) {
//   console.log(numbers)
//   numbers.pop();
// };

// solution 5
console.log(numbers);
