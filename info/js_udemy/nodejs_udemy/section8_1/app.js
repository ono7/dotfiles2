let fs = require("fs");
let http = require("http");

http
  .createServer(function (req, res) {
    if (req.url === "/api") {
      let person = { firstName: "Emma", lastName: "Lima" };
      res.end(JSON.stringify(person));
    } else {
      res.writeHead(200, { "content-type": "text/html" });
      fs.createReadStream(__dirname + "/index.html").pipe(res);
    }
  })
  .listen(8080, "127.0.0.1");
