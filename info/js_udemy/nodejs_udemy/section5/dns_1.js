const dns = require("dns");

dns.lookup("google.com", (err, address, family) => {
  console.log(address, family);
});

let person = {
  firstName: "",
  lastName: "",
  greet: function () {
    console.log(`hello!, ${this.firstName} ${this.lastName}`);
  },
};

let jose = Object.create(person);
jose.firstName = "jose";
jose.lastName = "lima";
jose.greet();

let emma = Object.create(jose);
emma.firstName = "emma";
emma.greet();
