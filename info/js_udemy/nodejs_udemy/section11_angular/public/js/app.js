// empty array is a list of other dependencies
angular.module('TestApp', []);

angular.module('TestApp').controller('MainController', ctrlFunc);

function ctrlFunc() {
  this.message = 'hello!';
  this.people = [
    {
      name: 'john doe',
    },
    {
      name: 'jane doe',
    },
    {
      name: 'Jim doe',
    },
  ];
}
