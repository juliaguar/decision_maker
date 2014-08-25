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
    $scope.deleteItem(item);
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

  $scope.decrementRate = function(option) {
    if ($scope.countOccurrences(option).length > 1) {
      var index = $scope.ratedOptions.indexOf(option);
      $scope.ratedOptions.splice(index, 1)
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
  var answers = [
      'Of course!', 'Yeah!', 'sure', 'Do it!', "I think you should",
      'yep', 'yes :)', '*nods*', "clearly a yes",
      'Why do you even ask?', 'maybe', 'not sure', 'depends...', 'Why not?',
      'certainly not', 'nope', "I don't think so.", "I wouldn't do it, if I were you.", '*shakes head*',
      'seriously?', "please don't", 'naaa', "not at all", "clearly a no"];

  $scope.submitQuestion = function () {
    $scope.answer = answers[$scope.calcMD5($scope.question)];
  }

  $scope.calcMD5 = function(str) {
    var hash = str.split('').reduce(function(acc, current){return acc + current.charCodeAt(0);},0);
    var result = hash % answers.length;
    return result;
  }

  $scope.deleteAnswer = function () {
    $scope.answer = '';
    $scope.question = '';
  }

  $scope.editQuestion = function () {
    $scope.answer = '';
    document.getElementById("question").focus()
  }

})

app.controller('proConController', function($scope) {
  $scope.options = [];
  $scope.pros = {};
  $scope.cons = {};

  $scope.submitQuestion = function() {
    $scope.hideForm = true;
    document.getElementById('option').focus()
  }

  $scope.editQuestion = function() {
    $scope.hideForm = false;
    document.getElementById('question').focus()
  }

  $scope.addOption = function () {
    $scope.options.push($scope.option)
    $scope.option = ''
    document.getElementById('option').focus()
  }

  $scope.submitPro = function (option, pro) {
    if(!$scope.pros[option]) {
        $scope.pros[option] = []
    }
    $scope.pros[option].push(pro)
  }

  $scope.submitCon = function (option, con) {
    if(!$scope.cons[option]) {
        $scope.cons[option] = []
    }
    $scope.cons[option].push(con)
  }

  $scope.deletePro = function(option, index) {
    $scope.pros[option].splice(index, 1)
  }

  $scope.deleteCon = function(option, index) {
    $scope.cons[option].splice(index, 1)
  }

  $scope.deleteOption = function (option) {
    index = $scope.options.indexOf(option)
    $scope.options.splice(index, 1)
  }

  $scope.decide = function () {
    var bestOption = ''
    var bestScore = 0
    $scope.options.forEach(function(option, index) {
      var numberOfPros = 0
      var numberOfCons = 0

      if($scope.pros[option]) {numberOfPros = $scope.pros[option].length}
      if($scope.cons[option]) {numberOfCons = $scope.cons[option].length}

      score =  numberOfPros - numberOfCons

      if(score > bestScore) {
        bestScore = score
        bestOption = option
      }
      else if (bestOption === '') {
        bestScore = score
        bestOption = option
      }
    })
    $scope.bestOption = bestOption
  }
})
