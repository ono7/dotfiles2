// create a function and invoke it immediately
// scoping protects the variable inside the function and outside

let firstName = "Emma";

(function () {
  let firstName = "jose";
  console.log(firstName);
})();

console.log(firstName);
