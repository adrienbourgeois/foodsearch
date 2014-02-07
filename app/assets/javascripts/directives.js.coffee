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
