// color is now a global variable
// avoid having global variables if possible

const color = 'red';


function start() {
  // message can only exist here and not outside of this function
  const message = 'hi';
  // local variables take precedence over global
  const color = 'blue'
  console.log(color);
}

start();
