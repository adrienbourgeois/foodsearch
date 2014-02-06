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
        id = scope.keywords.indexOf(element.text())
        scope.keywords.splice id,1
        scope.$apply()


  }
