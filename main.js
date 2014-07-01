var getAllOccurrences = function (arr, word) {
  var indices = []
  for (i in arr) {
    if(word === arr[i]) {
      indices.push(i);
    }
  }
  return indices;
}

var deleteAllOccurrences = function (arr, word) {
  var indices = getAllOccurrences(arr, word);
  for (i in indices) {
    arr.splice(indices[i], 1);
  }
}

var app = angular.module('decisionMaker', [])

app.controller('OptionsController', function($scope) {

  $scope.init = function() {
    try {
      var opts = JSON.parse(localStorage.getItem('list'));

      if(opts.length > 0) {
        $scope.options = opts;
        $scope.ratedOptions = opts;
      } else {
        $scope.options = [];
        $scope.ratedOptions = [];
      }
    } catch (e) {
      $scope.options = [];
      $scope.ratedOptions = [];
    }
  }

  $scope.addOption = function () {
    $scope.options.push($scope.optionInput);
    $scope.ratedOptions.push($scope.optionInput);
    $scope.optionInput = '';
  };

  $scope.decide = function () {
    $scope.result = $scope.options[Math.floor(Math.random()*$scope.options.length)];
  }

  $scope.decideRated = function () {
    $scope.result = $scope.ratedOptions[Math.floor(Math.random()*$scope.ratedOptions.length)];
  }

  $scope.clearAll = function () {
    $scope.options = [];
    $scope.ratedOptions = [];
    localStorage.setItem ('list', '')
    $scope.result = '';
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
    deleteAllOccurrences($scope.ratedOptions, $scope.ratedOptions[item]);
  }

  $scope.deleteResult = function(result) {
    var index = $scope.options.indexOf(result);
    if (index >= 0) {
        $scope.options.splice(index, 1);
        $scope.result = '';
    }
  }

  $scope.showRating = function () {
    $scope.rate = true;
  }

  $scope.noRating = function () {
    $scope.rate = false;
  }

  $scope.incrementRate = function (item) {
    $scope.ratedOptions.push(item);
  }

  $scope.countOccurrences = function (item) {
    var items = [];
    for(var i = 0; i < $scope.ratedOptions.length; i++) {
      if(item === $scope.ratedOptions[i]) {
        items.push(item);
      }
    }
    return items;
  }
})
