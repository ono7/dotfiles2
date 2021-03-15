let express = require("express");
let app = express();

let bodyParser = require("body-parser");

let urlencodedParser = bodyParser.urlencoded({ extended: false });

// get desired server port using an env variable set outside of this app
let port = process.env.PORT || 8080;

app.use("/assets", express.static(__dirname + "/public"));

app.set("view engine", "ejs");

app.use("/", function (req, res, next) {
  console.log("Request Url: " + req.url);
  next();
});

app.get("/", function (req, res) {
  // render allows us to pass additional parameters to the page
  // this is useful for templating
  res.render("index");
});

app.get("/api/:id", function (req, res, get_q) {
  res.render("person", { ID: req.params.id, Qstr: get_q(req.query.qstr) });
});

app.post("/api", urlencodedParser, function (req, res, get_q) {
  res.send("thank you!");
  console.log(req.body.firstName);
  console.log(req.body.lastName);
});

const get_q = function (q) {
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

  return people[q] || "not found";
};

// app.get("/api/:id", function (req, res) {
//   let people = {
//     person1: {
//       firstName: "jose",
//       lastName: "Lima",
//     },
//     person2: {
//       firstName: "Emma",
//       lastName: "Lima",
//     },
//     person3: {
//       firstName: "Shiloh",
//       lastName: "Lima",
//     },
//     person4: {
//       firstName: "Colby",
//       lastName: "Davenport",
//     },
//   };
//   if (people[req.params.id]) {
//     res.json(people[req.params.id]);
//   } else {
//     res.json({});
//   }
// });

app.listen(port);
