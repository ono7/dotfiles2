// use streams whereever you can when using nodejs

let http = require("http");
let fs = require("fs");

http
  .createServer(function (req, res) {
    if (req.url === "/api") {
      res.writeHead(200, { "content-type": "text/html" });
      let person = {
        userName: "lima",
        level: "110",
      };
      res.end(JSON.stringify(person));
    } else {
      res.writeHead(404);
      res.end();
    }
    // fs.createReadStream(__dirname + "/index.html").pipe(res);
    // fs reads a file, and pipes it to the response object
  })
  .listen(8080, "127.0.0.1");
