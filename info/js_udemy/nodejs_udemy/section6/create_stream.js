let fs = require("fs");

let writeable = fs.createWriteStream(__dirname + "/greetcopy.junk");

let readable = fs.createReadStream(__dirname + "/greet.junk");

// // reads in chunks defined
// // also writes a copy of the chunks to a new file
// readable.on("data", function (chunk) {
//   console.log(chunk.length);
//   writeable.write(chunk);
// });

readable.pipe(writeable);
