let Emitter = require("events");

const events = {
  GREET: "greet",
};

let emtr = new Emitter();

emtr.on(events.GREET, function () {
  console.log("somewhere, some one said hello");
});

emtr.on(events.GREET, function () {
  console.log("A greeting occured");
});

console.log("hello");

emtr.emit(events.GREET);
