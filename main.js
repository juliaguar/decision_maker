var app = angular.module('decisionMaker', [])

app.controller('OptionsController', function($scope) {

  $scope.init = function() {
    try {
      var opts = JSON.parse(localStorage.getItem('list'));

      if(opts.length > 0) {
        $scope.options = opts;
      } else {
        $scope.options = [];
      }
    } catch (e) {
      $scope.options = [];
    }
  }

  $scope.addOption = function () {
    $scope.options.push($scope.optionInput);
    $scope.optionInput = '';
  };

  $scope.decide = function () {
    $scope.result = $scope.options[Math.floor(Math.random()*$scope.options.length)];
  }

  $scope.clearAll = function () {
    $scope.options = [];
    localStorage.setItem ('list', '')
  }

  $scope.saveList = function () {
    localStorage.setItem ('list', JSON.stringify($scope.options))
  }

  $scope.editItem = function (item) {
    $scope.optionInput = $scope.options[item];
    $scope.options.splice(item, 1);
    document.getElementById("optionInput").focus()
  }

  $scope.deleteItem = function (item) {
    $scope.options.splice(item, 1);
  }
})
