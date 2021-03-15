let fs = require("fs");

let greet = fs.readFileSync(__dirname + "/greet.junk");

// displays binary data in buffer
console.log(greet);
console.log(greet.toString());

// async call to read file contents
// nodejs event look puts this in the queue and continues to console.log the
// next line! this is why this will first print "done!" then then print the file
// contents, always do async vs sync when you can but avoid raise conditions and
// only perform atomic changes
let greet2 = fs.readFile(__dirname + "/greet.junk", function (err, data) {
  console.log(data.toString());
});

console.log("done!");
