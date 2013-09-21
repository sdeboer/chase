routes = (router, location)->
  router.when('/profile/:profileId',
    templateUrl: 'template-profile',
    controller: 'ProfileController')

  router.when('/register',
    templateUrl: 'template-register',
    controller: 'RegisterController')

  router.when('/welcome',
    templateUrl: '/templates/welcome',
    controller: 'RegisterController')

  router.otherwise redirectTo: '/welcome'

  location.html5Mode false

ChaseApp = angular.module 'ChaseApp',
  ['chaseServices'],
  ['$routeProvider', '$locationProvider', routes]

RegisterController = ($scope)->
  # NOP
ChaseApp.controller 'RegisterController', ['$scope', RegisterController]
