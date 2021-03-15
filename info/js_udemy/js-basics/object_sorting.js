const courses = [
  {id: 1, name: 'Node.js'},
  {id: 2, name: 'Javascript'},
];

// this works if all the characters are the same case
// the reason is that each character compares against the ASCII table
// ASCII table uses decimal numbers to compare, so we can use < > === here to do
// this operation to sort, however, J and j are different numbers, so sorting
// will fail if using different case!  we can normalize with upper or lower?
courses.sort((a, b) => {
  // a < b => -1
  // a < b => 1
  // a === b => 0
  if (a.name < b.name) return -1;
  if (a.name > b.name) return 1;
  return 0;
});

console.log(courses);
