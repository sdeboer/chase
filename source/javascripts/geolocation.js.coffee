ChaseApp = angular.module('ChaseApp')

host = 'http://localhost\\:10100'

watchPosition = ($scope, position)->
	console.log "Watching", position

GeoController = ($scope, $window)->
	geo = $window.navigator?.geolocation

	$scope.supportsGeo = geo?

	updateFn = (p)->
		$scope.$apply ->
			watchPosition $scope, p

	setupFn = (p)->
		geo.watchPosition updateFn, errorFn,
			enableHighAccuracy: true
			maximumAge: 30000
			timeout: 60000

		$scope.$apply ->
			$scope.current = p.coords

	errorFn = (e)->
		$scope.$apply ->
			console.log "Geo Error", e
			alert "This site only works with GeoLocation enabled."
			$scope.supportsGeo = false

	if geo?
		console.log "G", geo
		geo.getCurrentPosition setupFn, errorFn


ChaseApp.controller 'GeoController', ['$scope', '$window', GeoController]
