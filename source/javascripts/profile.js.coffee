ChaseServices = angular.module 'chaseServices', ['ngResource']

host = 'http://localhost\\:10100'

profileActions =
	get: { method: 'JSONP' }

Profile = ($resource)->
	$resource host + '/profile/:profile_id',
		{jsonp: 'JSON_CALLBACK'},
		profileActions

ChaseServices.factory 'csProfile', ['$resource', Profile]

ProfileController = ($scope, profile)->
	$scope.fields = [
		{name: 'One', value: '1 Val'},
		{name: 'Two', value: '2 Val'}
	]
	$scope.filled = 'yep'

	$scope.profile = profile.get()

deps = ['$scope', 'csProfile', ProfileController]

angular.module('ChaseApp').controller('ProfileController', deps)
