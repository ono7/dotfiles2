// filter out array using another array to provide filter elements

const numbers = [1, 2, 3, 4, 5];

const filterOut = (arrayToFilter, filterArray) => {
  let newArray = [];
  for (let e of arrayToFilter)
    if (!filterArray.includes(e))
      newArray.push(e)
  return newArray
};

console.log(filterOut(numbers, [3, 4]));
