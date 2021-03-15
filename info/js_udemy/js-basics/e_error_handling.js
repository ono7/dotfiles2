
const numbers = [1, 1, 2, 3, 4];

try {
  const count = countOccurences(null, 1);
  console.log(count);
}
catch (e) {
  console.log(e.message);
}

// checks to make sure array is an actual array
function countOccurences(array, searchElement) {
  if (!Array.isArray(array))
    throw new Error('this is not an array!!')
  return array.reduce((a, c) => {
    const occurance = (c === searchElement) ? 1 : 0;
    return a + occurance;
  }, 0)
}
