// should count the number of occurences of a given searchElement

const number = [1, 2, 3, 3, 1, 4, 5, 5, 5, 5];

const countOccurances = (a, searchElement) => {
  let counter = 0;
  for (let e of a)
    if (e === searchElement)
      counter++;
  return counter;
};

console.log(countOccurances(number, 5));
