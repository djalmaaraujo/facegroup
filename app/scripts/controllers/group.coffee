'use strict'

angular.module('facegroupApp')
  .controller 'GroupCtrl', ['$routeParams', '$timeout','$location', '$scope', 'Facebook', ($routeParams, $timeout, $location, $scope, Facebook) ->

    angular.element('body').addClass('feed')
    angular.element('body').removeClass('login')

    Facebook.getLoginStatus (response) ->
      if response.status == 'connected'
        $scope.fetchGoups()

        if ($routeParams.group_id)
          $scope.groupLoading = "Loading group feed.."
          $scope.showFeed($routeParams.group_id)
      else
        $location.path('/')

    $scope.fetchGoups = ->
      Facebook.api '/me/groups?fields=icon,email,name,id&icon_size=16', (response) ->
        $scope.$apply ->
          $scope.groups = response.data

    $scope.showFeed = (groupId) ->
      Facebook.api "/#{groupId}?fields=name,feed.limit(100).fields(message,from,comments.limit(200).fields(from,message,created_time,comment_count,message_tags,like_count,id),full_picture,picture,likes.limit(1000),description,type,status_type,message_tags,caption,link,source,place,name)&limit=100", (response) ->

        $scope.$apply ->
          $scope.groupFeed =
            id: response.id
            name: response.name
            feed: response.feed.data
            totalMessages: response.feed.data.length
  ]
