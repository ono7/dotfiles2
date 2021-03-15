let arr = [];

arr.push(function () {
  console.log("hello from function 1");
});

arr.push(function () {
  console.log("hello from function 2");
});

arr.push(function () {
  console.log("hello from function 3");
});

arr.forEach(function (item) {
  item();
});
