const numbers = [1, 2, 3];;

for (let number of numbers)
  console.log(number);


// arrow functions can be defined like this if they have a single parameter
numbers.forEach(number => console.log(number));

numbers.forEach(number => console.log(number));

// foreach can take a second optional parameter as an index
numbers.forEach((number, index) => console.log(index, number));
