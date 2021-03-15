let express = require('express');
let app = express();

let port = process.env.PORT || 8080;

app.use('/assets', express.static(__dirname + '/public'));

app.set('view engine', 'ejs');

app.listen(port);
