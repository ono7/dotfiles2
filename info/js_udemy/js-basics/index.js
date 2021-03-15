console.log("hello world from other file!!")

let firstName = 'jose';

console.log(firstName);

let person = {
  name: "jose", age: "42"
};

console.log(typeof person);
console.log(person.name);
console.log(person["age"]);

let selectedColors = ['red', 'blue'];


console.log(selectedColors[1]);
console.log(selectedColors[0]);

selectedColors[2] = 'gray';

console.log(selectedColors[2]);
console.log(selectedColors.length);

// perform task

function square(number) {
  return number * number;
};

console.log(square(4));

let x = 10;
let y = 20;


// ternary operations
let points = 110;
let type = points > 100 ? "gold" : "silver"
console.log(type); // gold

// logica operators AND OR NOT ( && || ! )

let highIncome = false;
let goodCreditScore = false;
let eligibleForLoan = highIncome || goodCreditScore;

// NOT (!)

let applicationRefused = !eligibleForLoan;

console.log('Application reused: ', applicationRefused);


// truthy or falsy

let userColor = 'red';
let defaultColor = 'blue';
let currentColor = userColor || defaultColor;

console.log(currentColor);


// bitwise operators  single '|' = bitwise OR,  '&' bitwise AND

// 1  = 00000001
// 2  = 00000010
// 3  = 00000100

console.log(1 & 2);
console.log(1 & 1);


let role;

switch (role) {
  case 'guest':
    console.log('guest user');
    break;

  case 'moderator':
    console.log('moderator role');

  case 'other':
    console.log('other user type');
}
