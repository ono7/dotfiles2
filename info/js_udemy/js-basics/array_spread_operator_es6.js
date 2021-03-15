// spread opeartor ...  , all the elements of the first array
// spread is more flexible
const first = [1, 2, 3];
const second = [4, 5, 6];

const combined = [...first, ...second];
console.log(combined);

// you can add to the arrays
const combined1 = [...first, 'b', ...second];
console.log(combined1);

// you can use spread to copy elements to new array
const copy = [...combined];
console.log(copy);
