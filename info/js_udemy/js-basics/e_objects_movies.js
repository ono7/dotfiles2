const movies = [
  {title: "movie1", year: 2017, rating: 8.7},
  {title: "movie2", year: 2017, rating: 5.4},
  {title: "movie3", year: 2017, rating: 6.5},
  {title: "movie4", year: 2020, rating: 4.2},
];

// write code to get all movies in 2017 rating > 4
// sort them in decending order, higher rating first
// only pick their title property to display on console

console.log(movies.filter(m => m.year === 2017 && m.rating >= 6).sort((a, b) => a < b ? 0 : -1))
