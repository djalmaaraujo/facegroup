'use strict'

angular.module('facegroupApp')
  .controller 'MainCtrl', ['$scope', 'Facebook', '$location', ($scope, Facebook, $location) ->
    angular.element('body').addClass('login')

    $scope.$watch ->
      Facebook.isReady()
    , (newVal) ->
      $scope.facebookReady = true

    checkLogin = ->
      Facebook.getLoginStatus (response) ->
        if response.status == 'connected'
          $scope.logged = true
          $location.path('/feed')

    $scope.logged = false

    checkLogin()

    $scope.login = ->
      Facebook.getLoginStatus (response) ->
        if response.status == 'connected'
          $scope.$apply ->
            $scope.logged = true
            $location.path('/feed')

        else
          Facebook.login (response) ->
            $scope.logged = true
            $location.path('/feed')

          , {scope: ['user_about_me', 'user_groups', 'email']}

    $scope.logout = ->
      if Facebook.isReady()
        Facebook.logout ->
          $scope.$apply ->
            $scope.logged = false
  ]
