let express = require("express");

let app = express();

// get desired server port using an env variable set outside of this app
let port = process.env.PORT || 8080;

app.use("/assets", express.static(__dirname + "/public"));

app.use("/", function (req, res, next) {
  console.log("Request Url: " + req.url);
  next();
});

app.get("/", function (req, res) {
  res.send(
    "<html><head><link href='assets/style.css' type='text/css' rel='stylesheet'/></head><body><h1>hello world!!</h1></body></html>"
  );
});

app.get("/api/:id", function (req, res) {
  let people = {
    person1: {
      firstName: "jose",
      lastName: "Lima",
    },
    person2: {
      firstName: "Emma",
      lastName: "Lima",
    },
    person3: {
      firstName: "Shiloh",
      lastName: "Lima",
    },
    person4: {
      firstName: "Colby",
      lastName: "Davenport",
    },
  };
  if (people[req.params.id]) {
    res.json(people[req.params.id]);
  } else {
    res.json({});
  }
});

app.listen(port);
