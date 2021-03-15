// use streams whereever you can when using nodejs

let http = require("http");
let fs = require("fs");

http
  .createServer(function (req, res) {
    res.writeHead(200, { "content-type": "application/json" });
    let obj = {
      firstName: "john",
      lastName: "doe",
      groceries: ["test", "test2", "test3"],
    };

    res.end(JSON.stringify(obj));
  })
  .listen(8080, "127.0.0.1");
