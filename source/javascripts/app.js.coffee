routes = (router, location)->
  router.when('/profile/:profileId',
    templateUrl: 'template-profile',
    controller: 'ProfileController')

  router.when('/register',
    templateUrl: 'template-register',
    controller: 'RegisterController')

  router.otherwise redirectTo: '/register'

  location.html5Mode true

ChaseApp = angular.module 'ChaseApp',
  ['chaseServices'],
  ['$routeProvider', '$locationProvider', routes]

RegisterController = ($scope)->
  # NOP
ChaseApp.controller 'RegisterController', ['$scope', RegisterController]
