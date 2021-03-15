function max(a, b) {
  return (a > b) ? a : b;
};

let number = max(1, 2)

console.log(number);


// no need to do ternary here, just return the value based on the expression
// (width > height) should return true or false
function isLandScape(width, height) {
  return (width > height)
};


let w = 40
let h = 20

console.log(isLandScape(w, h))
