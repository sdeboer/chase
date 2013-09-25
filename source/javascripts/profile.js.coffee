ChaseServices = angular.module 'chaseServices', ['ngResource']

host = 'http://localhost\\:10100'

profileActions =
	get: { method: 'JSONP', params: {jsonp: 'JSON_CALLBACK'} }
	save: { method: 'PATCH', withCredentials: true}

Profile = ($resource)->
	$resource host + '/profile/:profile_id',
		null,
		profileActions

ChaseServices.factory 'csProfile', ['$resource', Profile]

ProfileController = ($scope, profile)->
	$scope.profile = profile.get()
	$scope.$watch 'profile.handle', (newValue, oldValue)->
		profile.save($scope.profile) unless newValue is oldValue

deps = ['$scope', 'csProfile', ProfileController]

angular.module('ChaseApp').controller('ProfileController', deps)
