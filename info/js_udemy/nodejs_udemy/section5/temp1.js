let person = {
  firstName: "",
  lastName: "",
  greet: function () {
    return this.firstName + " " + this.lastName;
  },
};

let john = Object.create(person);
john.firstName = "john";
john.lastName = "doe";

let jane = Object.create(person);
jane.firstName = "jane";
jane.lastName = "doe";

console.log(john.greet());
console.log(jane.greet());
