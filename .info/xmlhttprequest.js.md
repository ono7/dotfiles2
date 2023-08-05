# send json post request

```javascript
var xmlhttp = new XMLHttpRequest(); // new HttpRequest instance
var theUrl = '/json-handler';
xmlhttp.open('POST', theUrl);
xmlhttp.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
xmlhttp.send(
  JSON.stringify({ email: 'hello@user.com', response: { name: 'Tester' } })
);
```
