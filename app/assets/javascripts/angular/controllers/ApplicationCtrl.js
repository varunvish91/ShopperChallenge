angular.module('CodingChallenge', [])

.controller('CodingChallengeController', function($scope) {
  $scope.show = 1;
  $scope.submit = function(firstName, lastName, region, phoneNumber, over21, reason){
     var userInfo = {
      firstName: document.getElementById("firstName").value,
      lastName: document.getElementById("lastName").value,
      region: document.getElementById("region").value,
      phone: document.getElementById("phone").value,
      phoneNumber: document.getElementById("phoneNumber").value,
      over21: document.getElementById("over21").value,
      reason: document.getElementById("reason").value
    }
    console.log("userInfo: ", userInfo)
    $scope.show = 4;
    $(".apply").fadeOut(300);
    $(".confirmation").fadeIn(300);
  }
  $scope.begin = function(){
    $scope.show = 2;
    $(".start").fadeOut(300);
    $(".signup").fadeIn(300);
  }

  $scope.backgroundCheck = function(){
    $scope.show = 3;
  }

});

