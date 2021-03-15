// you can use || or to set defaults

function interest(principal, rate, years) {
  rate = rate || 3.5;
  years = years || 5;
  return principal * rate / 100 * years;
}

// just like python this works
function interest2(principal, rate = 3, years = 5) {
  return principal * rate / 100 * years;
}

console.log(interest2(100000));

console.log(interest2(10000, 3.5, 50));
