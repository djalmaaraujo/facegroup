'use strict'

app = angular.module('facegroupApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'facebook',
  'angularMoment'
])
  .config ['FacebookProvider', '$routeProvider', (FacebookProvider, $routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'

      .when '/feed',
        templateUrl: 'views/feed.html',
        controller: 'GroupCtrl'

      .when '/feed/:group_id?',
        templateUrl: 'views/feed.html',
        controller: 'GroupCtrl'

      .otherwise
        redirectTo: '/feed'

    # FacebookProvider.init('1424334571147017') # Dev
    FacebookProvider.init('1542283212663514') # Production
  ]

app.directive "noEmbed", ['$http', ($http) ->
  restrict: "A"

  link: (scope, element, attrs) ->
    if attrs.source
      $http(method: 'GET', url: "http://noembed.com/embed?url=#{attrs.source}").
        success (data, status, headers, config) ->
          console.log data

        .error (data, status, headers, config) ->
          console.log data
]
