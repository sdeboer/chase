profileActions = {
        get: {
          method: 'JSONP'
        }
      }

Profile = ($resource)->
  $resource 'http://localhost\\:10100/profile/:profile_id',
    {jsonp: 'JSON_CALLBACK'},
    profileActions

ChaseServices = angular.module 'chaseServices', ['ngResource']
ChaseServices.factory 'Profile', ['$resource', Profile]
