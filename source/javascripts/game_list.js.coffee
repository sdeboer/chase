console.log "reading"
ChaseApp = angular.module 'ChaseApp'

host = 'http://localhost\\:10100'

gameActions =
	get: { method: 'JSONP', params: {jsonp: 'JSON_CALLBACK'} }
	save: { method: 'PATCH', withCredentials: true }
	create: { method: 'POST', withCredentials: true }
	list:
		method: 'JSONP'
		isArray: true
		params:
			jsonp: 'JSON_CALLBACK'
			mine: true

gameTypes = [ { id: 0, name: "robot"},
	{ id: 1, name: "just another"} ]

Game = ($resource)->
	$resource host + '/game/:game_id',
		null,
		gameActions

ChaseApp.factory 'csGame', ['$resource', Game]

Controller = ($scope, $location, game)->
	$scope.games = game.list()
	$scope.types = gameTypes
	$scope.currentType = 0
	#$scope.game = game.get game_id: 12

	$scope.playGame = (id)-> $location.path '/play'

	$scope.createGame = ->
		game.create {game_type: $scope.currentType}, (game)->
			console.log 'GC', game.id, game
			$location.path '/play/' + game.id

deps = ['$scope', '$location', 'csGame', Controller]

console.log 'blag'
ChaseApp.controller 'GameListController', deps
