const person = {
  firstName: "jose",
  lastName: "lima",
  get fullName() {
    return `${person.firstName} ${person.lastName}`
  },
  set fullName(v) {
    const parts = v.split(' ')
    this.firstName = parts[0]
    this.lastName = parts[1]
  }
};

person.fullName = 'Emma Lima'

// getters => access properties
// setters => change (mutable) set properties from the outside
// getters allow to call with out () person.fullName

console.log(person.fullName);
