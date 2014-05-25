ChaseApp = angular.module 'ChaseApp'

watchID = null

ws = null

watchPosition = ($scope, position)->
	ws.sendRequest
		command: 'geo'
		coords: position.coords

	$scope.$apply ->
		$scope.current = position.coords

class Controller
	constructor: ($scope, $window, $route, socket, @position)->
		$scope.game_id = $route.game_id
		ws = socket
		ws.connect $route.game_id
		$scope.debug = true

		updateFn = (p)->
			watchPosition $scope, p

		errorFn = (e)->
			geo.clearWatch(watchID) if watchID

			$scope.$apply ->
				$scope.supportsGeo = false

		setupFn = (p)->
			watchID = geo.watchPosition updateFn, errorFn,
				enableHighAccuracy: true
				maximumAge: 30000
				timeout: 60000

			updateFn p

		$scope.$on 'location', @locationChange

		if geo = $window.navigator?.geolocation
			$scope.supportsGeo = true
			geo.getCurrentPosition setupFn, errorFn

	locationChange: (e, data)=>
		@position.updatePlayer data


ChaseApp.controller 'GameDisplayController', ['$scope', '$window', '$routeParams', 'WebSocket', 'PositionService', Controller]
