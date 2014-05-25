ChaseApp = angular.module 'ChaseApp'

class PositionService
	constructor: (@profiles)->
		@page = paper
		@page.setup "playMap"
		pv = @page.view
		vw = pv.viewSize.width
		h = vw * 9 / 16
		pv.viewSize = [vw, h]

		b = pv.bounds
		vm = Math.max b.width, b.height
		@scale = vm / 4000
		c = pv.center
		@c_x = c.x
		@c_y = c.y

		tt = @transform(new @page.Point(500, 500))
		console.log 'tt', tt
		@players = {}
		c3 = new @page.Path.Circle tt, 15
		c3.strokeColor = 'purple'
		@players.me = c3

		@origin = new @page.Path.Circle pv.center, 3
		@origin.strokeColor = 'red'

		@page.view.draw()
		@page.view.onFrame = @onFrame
		
	updatePlayer: (d)=>
		pid = d.playerID
		xy = @transform(new @page.Point(d))
		@profiles.add pid

		if circ = @players[pid]
			circ.position = xy
		else
			console.log 'making', pid
			circ = new @page.Path.Circle xy, 10
			color = if @profiles.isObserver pid
				'yellow'
			else
				'red'

			circ.strokeColor = color
			@players[pid] = circ

	onFrame: (e)=>

	transform: (pt)->
		new @page.Point (pt.x * @scale) + @c_x, -(pt.y * @scale) + @c_y

ChaseApp.service 'PositionService', ['ProfileList', PositionService]
