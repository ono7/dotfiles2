// store 8 bytes, or 64 bits of data
// this is from v8 engine not Nodejs
let buffer = new ArrayBuffer(8);

let view = new Int32Array(buffer);

view[0] = 5;
view[2] = 15;
view[3] = 15;

console.log(view);
