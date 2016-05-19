var app = angular.module(
  'customers',
  [
    'ngRoute',
    'ngResource',
    'templates'
  ]
);

app.controller("CustomerSearchController", [
  "$scope","$http","$location",
  function($scope, $http, $location){
    var page = 0;
    $scope.customers = [];
    $scope.search = function(searchTerm){
      if(searchTerm.length < 3){
        return;
      }
      $http.get("/customers.json",
                {"params": {"keywords": searchTerm, "page": page}}
      ).then(function(response){
        $scope.customers = response.data;
      }, function(response){
        alert("There was a problem: "+ data.status);
        }
      );
    }
    $scope.previousPage = function(){
      //alert(page);
      if(page > 0){
        page = page - 1;
        $scope.search($scope.keywords);
      }
    }
    $scope.nextPage = function(){
      page = page + 1;
      //alert(page);
      $scope.search($scope.keywords);
    }
    $scope.viewDetails = function(customer){
      $location.path("/"+customer.id);
    }
  }
]);

app.config(["$routeProvider",
  function($routeProvider){
    $routeProvider.when("/",{
      controller: "CustomerSearchController",
      templateUrl: "customer_search.html"
    }).when("/:id",{
      controller: "CustomerDetailController",
      templateUrl: "customer_detail.html"
    });
  }
]);

app.controller("CustomerDetailController", [
  "$scope","$routeParams","$resource",
  function($scope, $routeParams, $resource){
    $scope.customerId = $routeParams.id;

    var Customer = $resource('/customers/:customerId.json');
    $scope.customer = Customer.get({"customerId": $scope.customerId});

  }
]);

app.controller("CustomerCreditcardController",[
  "$scope", "$routeParams","$resource",
  function($scope, $routeParams, $resource){
    var CrediteCardInfo = $resource("/faking_billing.json");
    $scope.setCardhoderId = function(cardholderId){
      $scope.creditCard = CrediteCardInfo.get({"cardholder_id": cardholderId});
    }
  }
]);
