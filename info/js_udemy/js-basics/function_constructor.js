// constructors are like like the init method in python classes
// this is like self in a class when used in the constructors
// constructor functions start with capital letter


function Circle(radius) {
  this.radius = radius;
  this.draw = function () {
    console.log('draw');
  }
  this.test1 = 'two'
}


// new keyword create an empty object
// when passed a constructor it populates the object with the attributes of the
// constructor

const circle = new Circle(1);

console.log(Circle.constructor);
