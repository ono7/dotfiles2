let fs = require("fs");
let zlib = require("zlib");

let writeable = fs.createWriteStream(__dirname + "/greetcopy.junk");

let readable = fs.createReadStream(__dirname + "/greet.junk");

// // reads in chunks defined
// // also writes a copy of the chunks to a new file
// readable.on("data", function (chunk) {
//   console.log(chunk.length);
//   writeable.write(chunk);
// });

let compressed = fs.createWriteStream(__dirname + "/greetcopy.gzip.junk");

let gzip = zlib.createGzip();

// pipe returns the value, so we get back the writable stream
// this is done using pipes, or method chaining, this only works when the
// previous method returns an object

readable.pipe(writeable);
readable.pipe(gzip).pipe(compressed);
