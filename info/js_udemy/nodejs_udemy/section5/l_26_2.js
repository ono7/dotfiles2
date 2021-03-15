function Greetr() {
  this.greeting = "hello there!";
  this.greet = function () {
    console.log(this.greeting);
  };
}

module.exports = Greetr;
