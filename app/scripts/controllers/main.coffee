'use strict'

angular.module('facegroupApp')
  .controller 'MainCtrl', ['$scope', 'Facebook', ($scope, Facebook) ->
    $scope.$watch ->
      Facebook.isReady()
    , (newVal) ->
      $scope.facebookReady = true

    $scope.logged = false

    $scope.login = ->
      console.log 'Loging?'
      Facebook.getLoginStatus (response) ->
        console.log response

        if response.status == 'connected'
          console.log 'Connected?'
          $scope.logged = true
          $scope.aboutMe()
          console.log 'Already connected'

        else
          console.log 'ELSE?'
          Facebook.login (response) ->
            $scope.logged = true
            $scope.aboutMe()

            console.log 'Connected by login'

    $scope.logout = ->
      if Facebook.isReady()
        Facebook.logout ->
          $scope.$apply ->
            $scope.user = {}
            $scope.logged = false

    $scope.aboutMe = ->
      Facebook.api '/me', (response) ->
        $scope.$apply ->
          $scope.user = response
  ]
