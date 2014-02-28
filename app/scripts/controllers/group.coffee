'use strict'

angular.module('facegroupApp')
  .controller 'GroupCtrl', ['$timeout','$location', '$scope', 'Facebook', ($timeout, $location, $scope, Facebook) ->

    angular.element('body').addClass('feed')
    angular.element('body').removeClass('login')

    Facebook.getLoginStatus (response) ->
      if response.status == 'connected'
        $scope.fetchGoups()
      else
        $location.path('/')

    $scope.fetchGoups = ->
      Facebook.api '/me/groups?fields=icon,email,name,id&icon_size=16', (response) ->
        $scope.$apply ->
          $scope.groups = response.data

    $scope.showFeed = (group) ->
      Facebook.api "/#{group.id}?fields=feed.limit(100).fields(message,from,comments.limit(200).fields(from,message,created_time,comment_count,message_tags,like_count,id),full_picture,picture,likes.limit(1000),description,type,status_type,message_tags,caption,link,place,name)&limit=100", (response) ->

        $scope.$apply ->
          $scope.groupFeed =
            id: response.id
            name: group.name
            feed: response.feed.data
            totalMessages: response.feed.data.length
  ]

