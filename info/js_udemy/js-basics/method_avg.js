const marks = [80, 50, 80]

console.log((calculateGrade(marks)));

function grade(avg) {
  if (avg <= 60) return 'F';
  if (avg < 70) return 'D';
  if (avg < 80) return 'C';
  if (avg < 90) return 'B';
  return 'A';

};

function calculateGrade(marks) {
  let sum = 0;
  for (let n of marks)
    sum += n
  return grade(sum / marks.length)
};
