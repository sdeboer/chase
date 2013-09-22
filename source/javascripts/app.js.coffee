routes = (router, location)->
	router.when('/profile/:profileId',
		templateUrl: '/templates/profile.html')

	router.when('/welcome',
		templateUrl: '/templates/welcome.html')

	router.otherwise redirectTo: '/welcome'

	location.html5Mode false

angular.module 'ChaseApp',
	['chaseServices'],
	['$routeProvider', '$locationProvider', routes]
