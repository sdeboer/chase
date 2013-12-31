ChaseApp = angular.module 'ChaseApp'

watchID = null

ws = null

watchPosition = ($scope, position)->
	console.log "Watching", position
	ws.sendRequest
		command: 'geo'
		coords: position.coords

	$scope.$apply ->
		$scope.current = position.coords

GameController = ($scope, $window, socket)->
	console.log 'sock', socket
	ws = socket
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

	if geo = $window.navigator?.geolocation
		$scope.supportsGeo = true
		geo.getCurrentPosition setupFn, errorFn


ChaseApp.controller 'GameController', ['$scope', '$window', 'WebsocketService', GameController]
