@ left off at lesson 39 part 2

**always try to use streams and async methods where ever you can when building nodejs apps**

# nodejs install local (no sudo)

download LTS binary from nodjes.io, add to ~/local/node
add PATH in .zshrc

npm install -g yarn

# nodejs in udemy

https://conseto.udemy.com/course/understand-nodejs/learn/lecture/3453120#content

## nodejs api reference guide

https://nodejs.org/api/

## important NODEJS built in modules

events = event emitter module
util = used to inherit util.inherite(my_module, source_module)

#### better ways to organize code

modules, using module.exports and require
build and architect software in reusable components, interfaces

## nodejs uses events to operate

- system events are handled by C++ core using libuv
- it also handles custom events, javascript (event emitter)
  - events are faked when using javascript event emitter, we can create our own
    library

## modules, ES6

exists in ES6 and beyond

## cli debugging

node inspect temp1.js

```javascript
const test = [1, 2, 3];

debugger; //creates breakpoint to use with inspect

console.log(test);
```

## prototype - a base model of an object

typically used for inheritance

## functions constructors

- normal function used to create objects

## imediately invoked function expressions (IIFE)

code written inside a module should not impact code in side the code where its
being imported

- scope where in the code you have access to a particular variable or function

## revealing module pattern

expose only the properties and methods you want via a returned object
using require and module.exports

## requiring natives

## callback functions

error-first callback, callbacks take two parameters,
the first one is an error parameter

```javascript
function (error, data) {
  console.log(data)
}
```

## abstract class (or base class)

a type of constructor you never work directly with, but in inherit from

## MIME types

- Multipurpose Internet Mail Extensions (MIME)

- examples
  - application/json, text/html, image/jpeg

#### HTTP STATUS CODES

100: continue
101: switching protocols
102: processing (obsolete)
200: ok
201: created
202: accepted
203: non-authorative
301: redirects
401: auth

## http server routing (nodejs)

mapping http requests to content

## symantec software versioning

major.minor.patches
1.7.2

## NPM register https://www.npmjs.com

you can view package details at https://www.npmjs.com

npm uses package.json

## package.json

- package.json used by npm not nodejs

^ = update minor and patches
~ = update minor only

```javascript
{
  "dependencies": {
    "@yarnpkg/pnpify": "^2.1.0",
    "moment": "^2.27.0"
  }
}
```

## middleware

- code that sits between two layers of software
- 'express', node module, sits between the request and the response

## MEAN Stack

Mongo, Express, AngularJS, NodeJS

## DOM

collection of C++ objects,
Document Object Model
DOM does not live inside JS engines in browsers

DOM handles html code
