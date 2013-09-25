app = (router, location, http)->
	http.defaults.useXDomain = true
	http.defaults.withCredentials = true
	delete http.defaults.headers.common['X-Requested-With']

	console.log 'def', http.defaults

	router.when('/profile/:profileId',
		templateUrl: '/templates/profile.html')

	router.when('/welcome',
		templateUrl: '/templates/welcome.html')

	router.otherwise redirectTo: '/welcome'

	location.html5Mode false

angular.module 'ChaseApp',
	['chaseServices'],
	['$routeProvider', '$locationProvider', '$httpProvider', app]
