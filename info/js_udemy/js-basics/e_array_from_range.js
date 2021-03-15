// excercise array from range

const arrayFromRange = (start, end) => {
  const x = [];
  for (let i = start; i <= end; i++)
    x.push(i)
  return x;
};

const numbers = arrayFromRange(1, 4);

console.log(numbers);
