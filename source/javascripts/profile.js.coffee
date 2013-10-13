ChaseServices = angular.module 'chaseServices', ['ngResource']
ChaseApp = angular.module('ChaseApp')

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
		if oldValue? and newValue isnt oldValue

			profile.save $scope.profile, (newProfile, httpResponse)->
				if newProfile.$resolved
					$scope.profileForm.$setPristine()

deps = ['$scope', 'csProfile', ProfileController]

ChaseApp.controller 'ProfileController', deps
