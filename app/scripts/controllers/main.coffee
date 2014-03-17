'use strict'

REQUIRED_PERMISSIONS = ['user_about_me', 'user_groups', 'email', 'publish_actions']

angular.module('facegroupApp')
  .controller 'MainCtrl', ['$scope', 'Facebook', '$location', ($scope, Facebook, $location) ->
    angular.element('body').addClass('login')

    $scope.REQUIRED_PERMISSIONS = REQUIRED_PERMISSIONS

    $scope.$watch ->
      Facebook.isReady()
    , (newVal) ->
      $scope.facebookReady = true

    $scope.checkLogin = ->
      Facebook.getLoginStatus (response) ->
        if response.status == 'connected'
          $scope.fetchUser (user) =>
            $scope.$apply =>
              $scope.user = user
              $scope.logged = true
              $location.path('/feed')

    $scope.logged = false

    $scope.login() unless $scope.checkLogin()

    $scope.login = ->
      Facebook.login (response) ->
        $scope.logged = true
        $scope.checkLogin()

      , {scope: REQUIRED_PERMISSIONS}

    $scope.logout = (cb) ->
      if Facebook.isReady()
        Facebook.logout ->
          $scope.$apply ->
            $scope.logged = false
            $location.path('/')

    $scope.fetchUser = (cb) ->
      Facebook.api '/me?fields=permissions,about,email,name', (response) ->
        if $scope.checkPermissions(response.permissions.data[0])
          cb(response)
        else
          $scope.logout()

    $scope.checkPermissions = (permissions) ->
      hasAll = true

      _.forEach REQUIRED_PERMISSIONS, (p) ->
        unless _.has(permissions, p)
          hasAll = false
          false

      hasAll

  ]
