for (let i = 0; i < 20; i++) {
  console.log('hello world ' + i);
}

// no curly brackets needed if single expression

for (let i = 1; i < 10; i++) {
  if (i % 2 !== 0) console.log('odd: ', i)
}


const person = {
  name: "Emma",
  age: "2"
};

// looping over dictionary/object
for (let k in person)
  console.log(k, person[k]);

// for-of , ES6 (ecmascript v6)
