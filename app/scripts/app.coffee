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

    FacebookProvider.init('1424334571147017') # Dev
    # FacebookProvider.init('1542283212663514') # Production
  ]

app.filter "nl2brLinky", ["linkyFilter", (linky) -> (text) ->
  return "" unless text

  if text
    replaced = text.replace(/(\r\n|\r|\n)/g, "(((BR)))")
    replaced = linky(replaced)

    replaced.replace(/\(\(\(BR\)\)\)/g, "<br>")
]
