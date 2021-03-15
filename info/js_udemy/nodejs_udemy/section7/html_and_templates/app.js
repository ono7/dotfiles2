let http = require("http");
let fs = require("fs");

http
  .createServer(function (req, res) {
    res.writeHead(200, { "content-type": "text/html" });
    let html = fs.readFileSync(__dirname + "/index.html");
    res.end(html);
    debugger;
  })
  .listen(8080, "127.0.0.1");
