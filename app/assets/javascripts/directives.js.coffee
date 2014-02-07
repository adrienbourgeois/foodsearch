directives = angular.module('directives', [])

directives.directive 'ngEnter', ->
  return (scope, element, attrs) ->
    element.bind "keypress", (event) ->
      if event.which is 13
        scope.$apply ->
          scope.$eval(attrs.ngEnter, {'event': event})
        event.preventDefault()

directives.directive 'keyword', ->
  return {
    restrict: "E"
    transclude: true
    template: '<a href="#"><span class="keyword" ng-transclude></span></a>&nbsp;'
    link: (scope, element, attrs) ->
      element.on "click", (event)  ->
        event.preventDefault()
        id = scope.keywords.indexOf element.text().slice(0,-1)
        scope.keywords.splice id,1
        scope.$apply()
  }

directives.directive 'showmap', ->
  return {
    restrict: "E"
    scope:
      createMap: "&"
      photo: "="
    template: '<div><a href="" ng-click="showMap()" ' +
              'ng-show="showMapLinkVisibility">View on the map</a>' +
              '<a href="" ng-click="showMap()" ng-show="!showMapLinkVisibility">' +
              'Hide map</a></div>' +
              '<div class="mapcanvas" id="mapdiv{{photo.instagram_url}}" ng-show="!showMapLinkVisibility"></div>'
    controller: ($scope,$timeout) ->
      $scope.showMapLinkVisibility = true
      $scope.showMap = ->
        console.log !$scope.showMapLinkVisibility
        $scope.showMapLinkVisibility = !$scope.showMapLinkVisibility
        $timeout (->
          $scope.createMap({latitude:$scope.photo.latitude,longitude:$scope.photo.longitude,mapDiv:"mapdiv#{$scope.photo.instagram_url}"})
        ), 10
  }

directives.directive 'buttonpannel', ->
  return {
    restrict: "E"
    scope:
      glyphclass1: "@"
      actionfunction1: "&"
      glyphclass2: "@"
      actionfunction2: "&"
    controller: ($scope) ->
      $scope.visibility1 = true
      $scope.go1 = ->
        $scope.visibility1 = !$scope.visibility1
        $scope.actionfunction1()
      $scope.go2 = ->
        $scope.visibility1 = !$scope.visibility1
        $scope.actionfunction2()
    template: '<button class="btn btn-default btn-lg" type="submit" ' +
              'ng-click="go1()" ng-show="visibility1">' +
              '<span class="glyphicon {{glyphclass1}}"></span></button>' +
              '<button class="btn btn-default btn-lg" type="submit" ' +
              'ng-click="go2()" ng-hide="visibility1">' +
              '<span class="glyphicon {{glyphclass2}}"></span></button>'

  }
