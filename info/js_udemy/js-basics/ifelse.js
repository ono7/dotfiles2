// hour
// if hour s between 6 and 12pm: good morning!
// if it is between 12pm and 6pm: good afternoon!
// other wise: good evening


let hour = 18;

if (hour >= 6 && hour < 12) {
  console.log("good morning");
}
else if (hour >= 12 && hour < 18) {
  console.log("good afternoon");
}
else
  console.log("good evening");

// or
if (hour >= 6 && hour < 12)
  console.log("good morning");
else if (hour >= 12 && hour < 18)
  console.log("good afternoon");
else
  console.log("good evening");
