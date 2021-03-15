// create new obect that has: street, city zipcode,
// need function clled showAddress(address) that prints all the k,v of the
// object

const address = {
  street: '111 pine hills',
  city: 'carrolton',
  zipcode: '76227'
}

function get_address(address) {
  for (let k in address)
    console.log(k, address[k]);
}

get_address(address)
