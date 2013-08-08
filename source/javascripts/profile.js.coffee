ChaseApp = angular.module 'ChaseApp'

host = 'http://localhost\\:10100'

profileActions = {
        get: { method: 'JSONP' }
      }

Profile = ($resource)->
  $resource host + '/profile/:profile_id',
    {jsonp: 'JSON_CALLBACK'},
    profileActions

ChaseServices = angular.module 'chaseServices', ['ngResource']
ChaseServices.factory 'csProfile', ['$resource', Profile]

ProfileController = ($scope, Profile)->
  $scope.fields = [
    {name: 'One', value: '1 Val'},
    {name: 'Two', value: '2 Val'}
  ]
  $scope.filled = 'yep'

  $scope.profile = Profile.get(profile_id: 10)

ChaseApp.controller 'ProfileController', ['$scope', 'csProfile', ProfileController]
