let person = {
  firstName: 'jose',
  lastName: 'lima',
  firstLast() {
    console.log('hello ' + this.firstName + ' ' + this.lastName);
  }
};

person.firstLast();

// we have access to properties directy using [] format
console.log(person['lastName']);
