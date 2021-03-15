// map method

const numbers = [1, 2, 3, 4, -5, 6];
const filtered = numbers.filter(n => n >= 3);
const items = filtered.map(n => '<li>' + n + '</li>');

console.log(items);
