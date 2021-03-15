// call back functions allows to work and do different things with data
// in this case the call back function could do something from data from greet,
// if greet was getting data from a DB for example we can do different things
// simply by calling different callback functions

function greet(callback) {
  let data = {
    name: "John Doe",
  };
  callback(data);
}

greet(function (d) {
  console.log(`the callback was invoked! ${d}`);
});

greet(function (d) {
  console.log(`the callback was invoked 2! ${d.name}`);
});
