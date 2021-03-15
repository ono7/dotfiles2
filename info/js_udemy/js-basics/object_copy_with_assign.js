const circle = {
  radius: 1,
  draw() {
    console.log('draw');

  }
};

// copy object with assign method
const anotherObj = Object.assign({}, circle)
console.log(anotherObj)

// copy object with assign method, and add new properties
const anotherObj2 = Object.assign({color: 'yellow'}, circle)
console.log(anotherObj2)


// spread operator to clone object (...)
const another3 = {...circle};

console.log(another3)
