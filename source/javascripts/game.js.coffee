Resources = angular.module 'chase.resources'
ChaseApp = angular.module 'ChaseApp'

host = 'http://localhost\\:10100'

gameActions =
	get: { method: 'JSONP', params: {jsonp: 'JSON_CALLBACK'} }
	save: { method: 'PATCH', withCredentials: true }
	create: { method: 'POST', withCredentials: true }
	list: { method: 'JSONP', params: {jsonp: 'JSON_CALLBACK'}, isArray: true }

Game = ($resource)->
	$resource host + '/game/:game_id',
		null,
		gameActions

Resources.factory 'csGame', ['$resource', Game]

GameController = ($scope, $location, game)->
	$scope.games = game.list()
	#$scope.game = game.get()

	$scope.playGame = -> $location.path '/play'

deps = ['$scope', '$location', 'csGame', GameController]

ChaseApp.controller 'GameController', deps
