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
		if newValue isnt oldValue and oldValue?
			profile.save $scope.profile

deps = ['$scope', 'csProfile', ProfileController]

angular.module('ChaseApp').controller('ProfileController', deps)
