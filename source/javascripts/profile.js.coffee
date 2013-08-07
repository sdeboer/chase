class ProfileController
  constructor: ($resource)->
    @profile_id = '122'
    @Activity = $resource('/profile/:profile_id',
      {alt: 'json', callback: 'JSON_CALLBACK'},
      {
        get: {
          method: 'JSONP'
          params: {visibility: '@self'}
        }
        replies: {
          method: 'JSONP'
          params: {visibility: '@self', comments: '@comments'}
        }
      }
    )

  fetch: ->
    @activities = @Activity.get(profile_id: @profile_id)

  expandReplies: ->
    
    Profile = $resource '/profile/:profile_id',
      tsProfile = angular.module 'tsProfile', ['ngResource']

      tsProfile.factory 'Profile', ($resource)->
        $resource('profile/;profile_id', {}, {
          query: {method: 'GET', params: {profile_id: 'profiles'}}
        })

