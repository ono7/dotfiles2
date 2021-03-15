// pass by value

function change(b) {
  b = 2;
}

var a = 1;

change(a);

console.log(a);
console.log(a);

// pass by reference
// when you pass a obj as a parameter, the object is used by reference (pointer)
// the objects properties can be modified since the object is in memory and we
// are directly modifying the objects properties directly

function changeObj(d) {
  d.prop1 = function () {};
  d.prop2 = { name: "changeOjc" };
}

var c = {};
c.prop3 = {};

changeObj(c);
console.log(c);
