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

console.log(john.greet());
