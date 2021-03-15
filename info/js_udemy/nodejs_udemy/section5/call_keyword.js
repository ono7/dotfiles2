"use strict";

let obj = {
  name: "jose lima",
  greet: function () {
    console.log(`hello ${this.name}`);
  },
};

obj.greet();

// you can pass parameters using .call
// whatever is passed to call becomes "this" keyword
// in this case we overwrite this.name in obj
obj.greet.call({ name: "jane doe" });

// for apply you can pass an array of parameters
// not showing here

obj.greet.apply({ name: "jane doe" });
