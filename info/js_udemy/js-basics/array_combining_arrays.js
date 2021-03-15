// ways to concatenate an array

const first = [1, 2, 3]
const second = [4, 5, 6]

const newa = first.concat(second)

console.log(newa)

const slice = newa.slice(3, newa.length)


// slice can be used to copy the original array
console.log(slice);


// if the objects are reference type, they are copied by reference
const third = [{id: 1}];
const fourth = [4, 5, 6]

const combined = third.concat(fourth)
third[0].id = 2 // this will be two, because we changed the reference value used
console.log(combined);
