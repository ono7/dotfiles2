# nodemon

- monitors nodejs directory for changes and restarts nodemon

e.g `nodemon app.js`

# express (simplistic web framework)

- useful documentation can be viewed on the website specially around routing

- examples

```javascript
let express = require('express');

let app = express();

// get desired server port using an env variable set outside of this app
let port = process.env.PORT || 8080;

app.get('/', function (req, res) {
  res.send('<html><head></head><body><h1>hello world!!</h1></body></html>');
});

// use variables for routing
app.get('/person/:id', function (req, res) {
  let person1 = {
    firstName: 'jose',
    lastName: 'Lima',
  };
  // takes care of JSON.stringify etc
  if (id === 'person1') {
    res.json(person1);
  } else {
    res.json({});
  }
});

app.get('/api', function (req, res) {
  let person = {
    firstName: 'jose',
    lastName: 'Lima',
  };
  // takes care of JSON.stringify etc
  res.json(person);
});
app.listen(port);
```

# mongoose

deals with MongoDB
