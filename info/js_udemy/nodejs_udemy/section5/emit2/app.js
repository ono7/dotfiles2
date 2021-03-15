let EventEmmitter = require("events");

let util = require("util");

function Greetr() {
  this.greeting = "hello world!";
}

util.inherits(Greetr, EventEmmitter);

Greetr.prototype.greet = function (data) {
  console.log(this.greeting + ": " + data);
  this.emit("greet", data);
};

let greeter1 = new Greetr();

greeter1.on("greet", function (data) {
  console.log("someone greeted: " + data);
});

greeter1.greet("tony");
