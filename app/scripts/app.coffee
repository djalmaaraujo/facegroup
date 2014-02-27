'use strict'

angular.module('facegroupApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'facebook',
])
  .config ['FacebookProvider', '$routeProvider', (FacebookProvider, $routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'

      .when '/feed',
        templateUrl: 'views/feed.html',
        controller: 'GroupCtrl'

      .otherwise
        redirectTo: '/feed'

    FacebookProvider.init('1542283212663514')
  ]
