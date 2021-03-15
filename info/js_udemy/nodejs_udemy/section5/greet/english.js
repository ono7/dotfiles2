var greetings = require("./greetings.json");

const greet = function () {
  console.log(greetings.en);
};

module.exports = greet;
