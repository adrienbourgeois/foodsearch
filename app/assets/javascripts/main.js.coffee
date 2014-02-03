app = angular.module("SearchFood",[])

app.controller "PhotoListCtrl", ["$scope", "$http", "$q", ($scope, $http, $q) ->

  latitude_user = 0
  longitude_user = 0
  defer = $q.defer()

  defer.promise.then ->
    $http.get("/photos?latitude=#{latitude_user}&longitude=#{longitude_user}").success (data) ->
      console.log "#{latitude_user},#{longitude_user}"
      $scope.photos = data
      $scope.currentPhoto = data[0]

  navigator.geolocation.getCurrentPosition (position) ->
    latitude_user = position.coords.latitude
    longitude_user = position.coords.longitude
    defer.resolve()

  $scope.setCurrentPhoto = (photo) ->
    $scope.currentPhoto = photo

  $scope.photosMax = 32

  $scope.morePhotos = ->
    $scope.photosMax += 32

  $scope.restartMaxPhotos = ->
    $scope.photosMax = 32

]

