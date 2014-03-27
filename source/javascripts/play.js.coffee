ChaseApp = angular.module 'ChaseApp'

watchID = null

ws = null

watchPosition = ($scope, position)->
	ws.sendRequest
		command: 'geo'
		coords: position.coords

	$scope.$apply ->
		$scope.current = position.coords

Controller = ($scope, $window, $rp, jsInjector, socket)->
	jsInjector.add "/libs/paper-full.js"
	$scope.game_id = $rp.game_id
	ws = socket
	ws.connect $rp.game_id
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


ChaseApp.controller 'PlayController', ['$scope', '$window', '$routeParams', 'jsInjector', 'WebSocket', Controller]
