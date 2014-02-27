'use strict'

angular.module('facegroupApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'facebook'
])
  .config ['FacebookProvider', '$routeProvider', (FacebookProvider, $routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .otherwise
        redirectTo: '/'

    FacebookProvider.init('1542283212663514')
  ]
