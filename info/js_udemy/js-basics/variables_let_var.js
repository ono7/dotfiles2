// prior to ES62015 only var was avaliable
// to defined variables

// let keeps scope correctly assigned to the variable
// this was a problem before ES6
function start() {
  for (let i = 0; i < 5; i++) {
    console.log(i);
  }
}

// var allows the variable scope to creep outside
// of the code block from where it is defined
function start1() {
  for (var i = 0; i < 5; i++) {
    console.log(i);
  }
  console.log(i);
}

start();

console.log('second function start1()');
start1();

var color = 'red';
let age = '30';
