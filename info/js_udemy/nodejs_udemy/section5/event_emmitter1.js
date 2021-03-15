let EventEmitter = require("events");

let util = require("util");

function Greeting() {
  this.greeting = "hello world";
}

// util.inherits allows you to inherit from other classes/objects
// Greeting will inherit from EventEmitter in this case

util.inherits(Greeting, EventEmitter);

Greeting.prototype.greet = function () {
  console.log(this.greeting);
  this.emit("greet");
};

var greeting1 = new Greeting();

greeting1.on("greet", function () {
  console.log("some one greeted!");
});

greeting1.greet();
