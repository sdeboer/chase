ChaseApp = angular.module 'ChaseApp'

watchID = null

ws = null

watchPosition = ($scope, position)->
	ws.sendRequest
		command: 'geo'
		coords: position.coords

	$scope.$apply ->
		$scope.current = position.coords

class Display
	constructor: (@page)->
		p = @page
		p.setup "playMap"
		pv = p.view
		vw = pv.viewSize.width
		h = vw * 9 / 16
		pv.viewSize = [vw, h]

		b = pv.bounds
		vm = Math.max b.width, b.height
		@scale = vm / 4000
		c = pv.center
		@c_x = c.x
		@c_y = c.y

		tt = @transform(new p.Point(500, 500))
		console.log 'tt', tt
		c3 = new p.Path.Circle tt, 15
		c3.strokeColor = 'purple'

		@origin = new p.Path.Circle pv.center, 3
		@origin.strokeColor = 'red'

		p.view.draw()
		p.view.onFrame = @onFrame
		
	onFrame: (e)=>

	transform: (pt)->
		new @page.Point (pt.x * @scale) + @c_x, -(pt.y * @scale) + @c_y

Controller = ($scope, $window, $rp, socket)->
	$scope.game_id = $rp.game_id
	ws = socket
	ws.connect $rp.game_id
	$scope.debug = true

	display = new Display(paper)

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

ChaseApp.controller 'PlayController', ['$scope', '$window', '$routeParams', 'WebSocket', Controller]
