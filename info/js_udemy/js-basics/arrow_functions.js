const course = [
  {id: 1, name: 'a'},
  {id: 2, name: 'b'},
]


const a = course.find(function (course) {
  return course.name === 'a';
})

// single attributes
const b = course.find(course => course.name === 'a')

// defined a arrow function with no attributes, this doesnt actually work in
// this case because this is a sample only and we need a attribute here
const c = course.find(() => course.name === 'a')

console.log(a);
console.log(b);
console.log(c);
console.log(d);
