// methods , every and some
const numbers = [1, 2, -3, 4];

const allPositive = numbers.every(value => value >= 0);
console.log(allPositive);

const atLeastOneNegative = numbers.some(value => value < 0);
console.log(atLeastOneNegative);
