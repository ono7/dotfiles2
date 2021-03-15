// check if a given element is in the array
const numbers = [1, 2, 3, 4];


const checkArrray = (array, searchElement) => {
  for (let e of array)
    if (e === searchElement)
      return true
  return false
};

console.log(checkArrray(numbers, 1));
