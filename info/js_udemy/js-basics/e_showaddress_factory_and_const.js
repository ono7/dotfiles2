function Address(street, city, zipCode) {
  this.zipCode = zipCode,
    this.city = city,
    this.street = street
};


address = new Address('111 pine hill', 'carrolton', '7777')

console.log(address);


//factory function
function createAddress(street, city, zipCode) {
  return {
    street,
    city,
    zipCode
  }
};

let address1 = createAddress('1112 telephone', 'telephone2', '777')
let address2 = createAddress('1113 telephone', 'telephone', '778')
let address3 = createAddress('1113 telephone', 'telephone', '778')
console.log(address1);

function areEqual(addr1, addr2) {
  return addr1.city === addr2.city &&
    addr1.address === addr2.address
};

console.log(areEqual(address1, address2))
console.log(areEqual(address2, address3))
