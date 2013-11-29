ChaseResources = angular.module 'chase.resources', ['ngResource']

app = (router, location, http)->
	http.defaults.useXDomain = true
	http.defaults.withCredentials = true
	delete http.defaults.headers.common['X-Requested-With']

	console.log 'def', http.defaults

	router.when('/profile/:profile_id',
		templateUrl: '/templates/profile.html')

	router.when('/profile',
		templateUrl: '/templates/profile.html')

	router.when('/welcome',
		templateUrl: '/templates/welcome.html')

	router.when('/game/:game_id',
		templateUrl: '/templates/game.html')

	router.when('/game_list',
		templateUrl: '/templates/game_list.html')

	router.otherwise redirectTo: '/welcome'

	location.html5Mode false

angular.module 'ChaseApp',
	['chase.resources'],
	['$routeProvider', '$locationProvider', '$httpProvider', app]
