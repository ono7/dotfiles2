function Person(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
}

let john = new Person("jose", "lima");

console.log(john.firstName);

// adds a new greet method to this object
// or attaches this greet method to the function constructor
Person.prototype.greet = function () {
  console.log("hello, " + this.firstName + " greet func");
};

console.log(john);

john.greet();

console.log(john.__proto__);

let jane = new Person("jane", "doe");

jane.greet();

console.log(john.__proto__ === jane.__proto__);
