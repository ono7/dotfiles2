// split string into a list
const message = 'this is my    first program';

console.log(message.split(/(\s+)/));

// use filter to achive better results
// filter takes a function in this case which trims each item in the array
// filter returns only the words that are length > 0!! nice
const split = message.split(/(\s+)/).filter(w => w.trim().length > 0);

console.log(split);

// join this back together
const joined = split.join('-');
console.log(joined);

// URL Slug is a exact address of specific page or collection item on your site
