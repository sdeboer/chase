Resources = angular.module 'chase.resources'
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

Resources.factory 'csGame', ['$resource', Game]

Controller = ($scope, $location, game)->
	$scope.games = game.list()
	$scope.types = gameTypes
	$scope.currentType = 0
	#$scope.game = game.get game_id: 12

	$scope.playGame = -> $location.path '/play'

	$scope.createGame = ->
		console.log 'CG', $scope.currentType, $scope.gameList.game_type, @, arguments...

deps = ['$scope', '$location', 'csGame', Controller]

ChaseApp.controller 'GameListController', deps
