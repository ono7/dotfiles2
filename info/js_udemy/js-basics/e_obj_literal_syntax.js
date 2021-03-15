
let title = 'testing title';
let body = 'hello world';
let author = 'jose lima';
let views = 500;
let isLive = true;

let post = `
title: ${title}
body: ${body}
author: ${author}
views: ${views}
comments: (${author}, ${body})
isLive: ${isLive}
`

console.log(post);

let post2 = new Post('a', 'b', 'c')

console.log(post2);

function Post(title, body, author) {
  this.title = title;
  this.body = body;
  this.author = author;
  this.views = 0;
  this.comments = [];
  this.isLive = false;
};

let priceRanges = [
  {label: '$', tooltip: 'inexpensive', minPerPerson: 0, maxPerPerson: 10},
  {label: '$$', tooltip: 'moderate', minPerPerson: 11, maxPerPerson: 10},
  {label: '$', tooltip: 'inexpensive', minPerPerson: 0, maxPerPerson: 10},
]
