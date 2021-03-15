// throw has a message property we can catch for cleaner
// error handling

const person = {
  firstName: "jose",
  lastName: "lima",
  get fullName() {
    return `${person.firstName} ${person.lastName}`
  },
  set fullName(v) {
    if (typeof v !== 'string')
      throw new Error('value is not a string')

    const parts = v.split(' ');

    this.firstName = parts[0];
    this.lastName = parts[1];
  }
};

console.log(person.fullName);
try {
  person.fullName = true;
}
// catch the error and display the message only
catch (e) {
  console.log(e.message);
}
