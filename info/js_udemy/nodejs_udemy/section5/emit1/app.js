let Emitter = require("./emitter");

let emtr = new Emitter();

emtr.on("greet", function () {
  console.log("this is emiter on");
});

emtr.on("greet", function () {
  console.log("this is emiter on 2");
});

console.log("greet");

emtr.emit("greet");
