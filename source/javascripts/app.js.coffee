ProfileController = ($scope)->
  $scope.fields = [
    {name: 'One', value: '1 Val'},
    {name: 'Two', value: '2 Val'}
  ]
  $scope.filled = 'yep'

  #$scope.profile = Profile.query()

RegisterController = ($scope)->
  # NOP

routes = (router, location)->
  router.when('/profile/:profileId',
    templateUrl: 'template-profile',
    controller: ProfileController)
  
  router.when('/register',
    templateUrl: 'template-register',
    controller: RegisterController)

  router.otherwise(redirectTo: '/register')

  location.html5Mode true

ChaseApp = angular.module 'ChaseApp', [], ['$routeProvider', '$locationProvider', routes]

ChaseApp.controller 'ProfileController', ['$scope', ProfileController]
ChaseApp.controller 'RegisterController', ['$scope', RegisterController]
