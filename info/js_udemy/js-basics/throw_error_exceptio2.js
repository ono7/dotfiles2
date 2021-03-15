// lines after throw statement are not executed

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
    if (parts.length !== 2)
      throw new Error('enter first and last name')

    this.firstName = parts[0];
    this.lastName = parts[1];
  }
};



try {
  person.fullName = '';
}
catch (e) {
  console.log(e);
}

console.log(person.fullName);
