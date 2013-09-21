routes = (router, location)->
  router.when('/profile/:profileId',
    templateUrl: '/templates/profile.html',
    controller: 'ProfileController')

  router.when('/register',
    templateUrl: '/templates/register.html',
    controller: 'RegisterController')

  router.when('/welcome',
    templateUrl: '/templates/welcome.html',
    controller: 'RegisterController')

  router.otherwise redirectTo: '/welcome'

  location.html5Mode false

ChaseApp = angular.module 'ChaseApp',
  ['chaseServices'],
  ['$routeProvider', '$locationProvider', routes]

RegisterController = ($scope)->
  # NOP
ChaseApp.controller 'RegisterController', ['$scope', RegisterController]
