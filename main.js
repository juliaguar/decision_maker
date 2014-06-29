var app = angular.module('decisionMaker', [])

app.controller('OptionsController', function($scope) {
  $scope.options = [];
  $scope.addOption = function () {
    $scope.options.push($scope.optionInput);
    $scope.optionInput = '';
  };

  $scope.decide = function () {
    $scope.result = $scope.options[Math.floor(Math.random()*$scope.options.length)];
  }
})

// var choose = function (sometext) {
//   alert(sometext);
// }
//
// $(document).ready(function(){
//
//   $("#optionSubmit").click(function(e) {
//     e.preventDefault();
//     $("#options").append(
//       $('#optionInput').val() + ' <br>'
//     );
//   });
//
//   $('#chooseOption').click(function() {
//     choose($('#options').text());
//   })
// })
