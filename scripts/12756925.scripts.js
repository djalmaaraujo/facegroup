(function(){"use strict";var a;a=angular.module("facegroupApp",["ngCookies","ngResource","ngSanitize","ngRoute","facebook","angularMoment"]).config(["FacebookProvider","$routeProvider",function(a,b){return b.when("/",{templateUrl:"views/main.html",controller:"MainCtrl"}).when("/feed",{templateUrl:"views/feed.html",controller:"GroupCtrl"}).when("/feed/:group_id?",{templateUrl:"views/feed.html",controller:"GroupCtrl"}).otherwise({redirectTo:"/feed"}),a.init("1542283212663514")}]),a.filter("nl2brLinky",["linkyFilter",function(a){return function(b){var c;return b?b?(c=b.replace(/(\r\n|\r|\n)/g,"(((BR)))"),c=a(c),c.replace(/\(\(\(BR\)\)\)/g,"<br>")):void 0:""}}]),a.directive("handleVideoEmbed",function(){return{restrict:"A",link:function(a,b){return"video"===a.message.type?b.on("click",function(c){var d;return c.preventDefault(),d='<object width="100%" height="360" show="message.type == \'video\'">\n  <param name="movie" ng-value="'+a.message.source+'" />\n  <param name="wmode" value="transparent" />\n  <embed src="'+a.message.source+'" type="application/x-shockwave-flash" wmode="transparent" width="100%" height="360" />\n</object>',angular.element(b).find(".picture").replaceWith(d)}):void 0}}})}).call(this),function(){"use strict";angular.module("facegroupApp").controller("MainCtrl",["$scope","Facebook","$location",function(a,b,c){var d;return angular.element("body").addClass("login"),a.$watch(function(){return b.isReady()},function(){return a.facebookReady=!0}),d=function(){return b.getLoginStatus(function(b){return"connected"===b.status?(a.logged=!0,c.path("/feed")):void 0})},a.logged=!1,d(),a.login=function(){return b.getLoginStatus(function(d){return"connected"===d.status?a.$apply(function(){return a.logged=!0,c.path("/feed")}):b.login(function(){return a.logged=!0,c.path("/feed")},{scope:["user_about_me","user_groups","email"]})})},a.logout=function(){return b.isReady()?b.logout(function(){return a.$apply(function(){return a.logged=!1})}):void 0}}])}.call(this),function(){"use strict";angular.module("facegroupApp").controller("GroupCtrl",["$routeParams","$timeout","$location","$scope","Facebook",function(a,b,c,d,e){return angular.element("body").addClass("feed"),angular.element("body").removeClass("login"),e.getLoginStatus(function(b){return"connected"!==b.status?c.path("/"):(d.fetchGoups(),a.group_id?(d.groupLoading="Loading group feed..",d.showFeed(a.group_id)):void 0)}),d.fetchGoups=function(){return e.api("/me/groups?fields=icon,email,name,id&icon_size=16",function(a){return d.$apply(function(){return d.groups=a.data})})},d.showFeed=function(a){return e.api("/"+a+"?fields=name,feed.limit(100).fields(message,from,comments.limit(200).fields(from,message,created_time,comment_count,message_tags,like_count,id),full_picture,picture,likes.limit(1000),description,type,status_type,message_tags,caption,link,source,place,name)&limit=100",function(a){return d.$apply(function(){return d.groupFeed={id:a.id,name:a.name,feed:a.feed.data,totalMessages:a.feed.data.length}})})}}])}.call(this);