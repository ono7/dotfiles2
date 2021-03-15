// first angular app

let express = require('express');
let app = express();
let port = process.env.PORT || 8080;

// setup ejs as view engine
app.set('view engine', 'ejs');
app.use('/assets', express.static(__dirname + '/public'));

app.get('/', function (req, res) {
  res.render('index');
});

app.listen(port);
