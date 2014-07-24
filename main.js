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
    localStorage.setItem ('list', JSON.stringify($scope.options));
    $scope.saved = 'true';
    $scope.hideAlert();
  }

  $scope.editItem = function (item) {
    $scope.optionInput = $scope.options[item];
    $scope.options.splice(item, 1);
    document.getElementById("optionInput").focus()
  }

  $scope.deleteItem = function (index) {
    $scope.ratedOptions = $scope.ratedOptions.filter(function (value) {return value !== $scope.options[index]});
    $scope.options.splice(index, 1);
  }

  $scope.deleteResult = function(result) {
    var index = $scope.options.indexOf(result);
    if (index >= 0) {
        $scope.ratedOptions = $scope.ratedOptions.filter(function (value) {return value !== $scope.options[index]});
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
    if ($scope.countOccurrences(item).length <= 5) {
        $scope.ratedOptions.push(item);
    }
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

  $scope.hideAlert = function () {
    setTimeout(function () {
      $scope.$apply(function() {
        $scope.saved = false;
      });
    }, 2000);
  }
})

app.controller('ShouldIController', function($scope) {
  var answers = ['sure', 'yep','Why do you even ask?','maybe','certainly not', 'nope']

  $scope.submitQuestion = function () {
    $scope.answer = answers[3];
  }

  $scope.deleteAnswer = function () {
    $scope.answer = '';
    $scope.question = '';
  }
})
