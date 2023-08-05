# Javascript

- when looking at help, if a parameter has a question mark, it means it
  optional. e.g. join(separator?: string)

- look at developer tools in mozilla.org for useful references and examples on
  how to use built in methods etc

- JS has a garbage collector like python

### ternary operations

let points = 110;
let type = points > 100 ? "gold" : "silver"
console.log(type); // gold

### strict comparision

- use for accuracy (type and value must match)
  1 === 1

### lose comparision

- lose operators will convert type on rigth with type on left for comparison
  '1' == 1

### logical operators

AND ( && )
OR ( || )
NOT (!)

- results of a logical expression is based on the values being copared
- if the operand is not equal true or false, it will try to interprete it as
  **truthy or falsy**

- falsy

  undefined, null, 0, '' and NaN (not a number)

- truthy

  anything not falsy is truthy

### bitwise operators

### typeof

typeof, same is type() in python

### primitives/value types

type of data that represent a single value, not an object

string, number, boolean, undefined, null

- new in ES6 = symbol

### reference types

arrays, functions, objects

### dicitonary

let person = { name: "jose", age: "42" }

# functions

```javascript
function square(number) {
  return number * number;
}
```

## if else

```javascript
// or
if (hour >= 6 && hour < 12) console.log("good morning");
else if (hour >= 12 && hour < 18) console.log("good afternoon");
else console.log("good evening");
```

## case/switch

```javascript
let role;

switch (role) {
  case "guest":
    console.log("guest user");
    break;

  case "moderator":
    console.log("moderator role");
    break;

  case "other":
    console.log("other user type");
  // no break is needed on the last one
}

// else if is cleaner... case/switch are outdated
```

### contructor functions

- uses pascal naming convention ThisFunction vs thisFunction for factory
  functions

- pick one pattern between factory and constructor and stick to it

```javascript
// CONSTRUCTOR

// constructors are like like the init method in python classes
// this is like self in a class when used in the constructors

function Circle(radius) {
  this.radius = radius;
  this.draw = function () {
    console.log("draw");
  };
  this.test1 = "two";
}

// new keyword create an empty object
// when passed a constructor it populates the object with the attributes of the
// constructor

const circle = new Circle(1);

console.log(circle);

//FACTORY FUNCTION

function createAddress(street, city, zipCode) {
  return {
    street,
    city,
    zipCode,
  };
}

let address1 = createAddress("1112 telephone", "telephone", "777");
console.log(address1);
```

### objects

- delete, used to remove properties from an object

```javascript
const circle = {
  radius: 1,
};

circle.color = "yellow";

delete circle.radius;
```

### iterate over object keys/function/class

```javascript
// getting object keys, using Object.keys()
for (let key of Object.keys(circle)) {
  console.log(key);
}
```

### iterate over k,v pairs

```javascript
// getting object entries, k,v pairs in to an array []
for (let entry of Object.entries(circle)) {
  console.log(entry);
}
```

### check if object has key

```javascript

if ('i' in obj)

```

### copy object to another/shallow

```javascript
const circle = {
  radius: 1,
};
```

### string template literals, string interpolation

```javascript
const name = "jose";

const message = `this is my
first 'message' to ${name}

nice!!
`;
console.log(message);
```

### object equality

### arrow functions

```javascript
// arrow functions can be defined like this if they have a single parameter
numbers.forEach((number) => console.log(number));

// arrow functions that have multiple parameters can be defined with ()
numbers.forEach((number, numb) => console.log(number));
```

### arrays

```javascript
// concatenate two arrays

const first = [1, 2, 3];
const two = [4, 5, 6];

const combined = first.concat(two);
```

### array iteration

```javascript
// array iteration with foreach

const numbers = [1, 2, 3];

// foreach can optionally take a second parameter as an index
numbers.forEach((number, index) => console.log(index, number));
```

### string split, url slug

```javascript
// split string into a list
const message = "this is my    first program";

console.log(message.split(/(\s+)/));

// use filter to achive better results
// filter takes a function in this case which trims each item in the array
// filter returns only the words that are length > 0!! nice
const split = message.split(/(\s+)/).filter((w) => w.trim().length > 0);

console.log(split);

// join this back together const joined = split.join("-"); console.log(joined);

// URL Slug is a exact address of specific page or collection item on your site
// e.g:
//  http://slashdot.org/this-is-my-first-program
```

### pass by value
