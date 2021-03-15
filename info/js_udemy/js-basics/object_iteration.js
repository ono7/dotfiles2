
const circle = {
  radius: 1,
  draw() {
    console.log('draw');
  }
}

// getting object keys
for (let key of Object.keys(circle)) {
  console.log(key);
}

// getting object entries
for (let entry of Object.entries(circle)) {
  console.log(entry);
}
