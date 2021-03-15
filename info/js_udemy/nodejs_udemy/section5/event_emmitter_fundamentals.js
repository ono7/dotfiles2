// functions and arrays
// putting functions into arrays

let arr = [];

arr.push(function () {
  console.log("hello 1");
});

arr.push(function () {
  console.log("hello 2");
});

arr.push(function () {
  console.log("hello 3");
});

arr.forEach(function (item) {
  item();
});
