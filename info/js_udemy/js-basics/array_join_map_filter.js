const numbers = [1, 2, 3, 4, 5];

const filtered = numbers.filter(n => n > 2);

const mapped = filtered.map(n => '<li>' + n + '</li>');

const joined = mapped.join();

const html = '<ul>' + mapped.join() + '</ul>';


const chained = numbers.filter(n => n > 2).map(n => '<li>' + n + '</li>').join();


console.log(filtered);
console.log(mapped);
console.log(joined);
console.log(html);
console.log(chained)
