'use strict'

REQUIRED_PERMISSIONS = ['user_about_me', 'user_groups', 'email', 'publish_actions']

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

app.directive "handleVideoEmbed", ->
  restrict: "A"

  link: ($scope, $element, $attrs) ->
    if $scope.message.type == "video"
      $element.on 'click', (e) ->
        e.preventDefault()

        template = """
          <object width="100%" height="360" show="message.type == 'video'">
            <param name="movie" ng-value="#{$scope.message.source}" />
            <param name="wmode" value="transparent" />
            <embed src="#{$scope.message.source}" type="application/x-shockwave-flash" wmode="transparent" width="100%" height="360" />
          </object>
        """

        angular.element($element).find(".picture").replaceWith(template)

app.directive "ngEnter", ->
  ($scope, $element, $attrs) ->
    $element.bind "keydown keypress", (event) ->

      if event.which is 13
        $scope.$apply ->
          $scope.$eval($attrs.ngEnter)

        event.preventDefault()
