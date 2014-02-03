app = angular.module("SearchFood",[])

app.controller "PhotoListCtrl", ["$scope", "$http", "$q", ($scope, $http, $q) ->

  latitude_user = 0
  longitude_user = 0
  defer = $q.defer()

  defer.promise.then ->
    $http.get("/photos?latitude=#{latitude_user}&longitude=#{longitude_user}").success (data) ->
      $scope.photos = data
      $scope.setCurrentPhoto(data[0])
      $scope.tags = JSON.parse $scope.currentPhoto.tags

  navigator.geolocation.getCurrentPosition (position) ->
    latitude_user = position.coords.latitude
    longitude_user = position.coords.longitude
    defer.resolve()

  $scope.setCurrentPhoto = (photo) ->
    $scope.currentPhoto = photo
    myLatlng = new google.maps.LatLng(photo.latitude, photo.longitude)
    mapOptions =
      center: myLatlng
      zoom: 16
      mapTypeId: google.maps.MapTypeId.ROADMAP
    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)
    marker = new google.maps.Marker(
      position: myLatlng
      map: map
    )
    google.maps.event.addDomListener window, "load", initialize_map()

  $scope.photosMax = 32

  $scope.morePhotos = ->
    $scope.photosMax += 32

  $scope.restartMaxPhotos = ->
    $scope.photosMax = 32

]

