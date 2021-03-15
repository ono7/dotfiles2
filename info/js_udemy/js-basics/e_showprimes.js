showPrimes(20);

// prime numbers cannot be deviced evenly into another number

// there are prime and composite numbers, a prime number can only be devided by
// one and it self

function showPrimes(limit) {
  for (let n = 2; n < limit; n++)
    if (isPrime(n)) console.log(n);
};

function isPrime(number) {
  for (let factor = 2; factor < number; factor++)
    if (number % factor === 0)
      return false;
  return true
};
