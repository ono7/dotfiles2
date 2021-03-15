// function declaration syntax
// this syntax allows for function to be called before it is defined
// JavaScript moves the functions to the top,  **hoisting** is the process of moving function declaration to the
// top of the file

walk();

function walk() {
  console.log('walk')
}

// function expression syntax
// you cannot call this function until it is defined

const run = function () {
  console.log('run');
};

run();
