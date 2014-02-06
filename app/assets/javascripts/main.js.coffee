app = angular.module("SearchFood",['ngRoute','controllers','directives'])

app.config ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: "dashboard.html"
      controller: "PhotoListCtrl"
      resolve:
        app: ($q, $http) ->
          defer = $q.defer()
          console.log "helloooo"
          photos = null

          navigator.geolocation.getCurrentPosition (position) ->
            location =
              latitude:  position.coords.latitude
              longitude: position.coords.longitude
            $http.get("/photos?latitude=#{location.latitude}&longitude=#{location.longitude}").success (data) ->
              photos = data
              defer.resolve()
          defer.promise.then ->
            return photos

