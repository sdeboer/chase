ChaseApp = angular.module 'ChaseApp'

host = 'http://localhost\\:10100'

profileActions =
	get: { method: 'JSONP', params: {jsonp: 'JSON_CALLBACK'} }
	save: { method: 'PATCH', withCredentials: true}

Profile = ($resource)->
	$resource host + '/profile/:profile_id',
		null,
		profileActions

ChaseApp.factory 'ProfileResource', ['$resource', Profile]
