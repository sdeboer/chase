#host = 'http://localhost\\:10100'
host = 'http://tag.psiinteractive.com'

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

Game = ($resource)->
	$resource host + '/game/:game_id',
		null,
		gameActions

angular.module('ChaseApp').factory 'GameResource', ['$resource', Game]
