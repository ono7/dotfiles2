// factory function
// if key and value are the same, in JS you can just return the name
// radius: radius, -> radius,

// inside of objects, you can drop the function keyword if you are returning a function

function createCircle(radius) {
  return {
    radius,
    draw() {
      console.log('draw');
    }
  };
}

const circle1 = createCircle(1)
const circle2 = createCircle(2)
console.log(circle1);
console.log(circle2);
