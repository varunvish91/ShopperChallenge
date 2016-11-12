angular.module('CodingChallenge', [])

.controller('CodingChallengeController', function($scope) {
  $scope.show = 1;
  
	$scope.begin = function(){
    $scope.show = 2;
    $(".start").fadeOut(300);
    $(".signup").fadeIn(300);
  }

  $scope.backgroundCheck = function(){
    $scope.show = 3;
  }

});

