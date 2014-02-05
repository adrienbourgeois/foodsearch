controllers = angular.module('controllers', []);

controllers.controller "PhotoListCtrl", ["$scope", "$http", "$q", "$timeout", "$location", "app", ($scope, $http, $q, $timeout, $location, app) ->
  console.log "location: #{$location.path()}"
  map = null
  photos = app

  $scope.setCurrentPhoto = (photo) ->
    $scope.currentPhoto = photo
    $scope.tags = JSON.parse photo.tags
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

  $scope.photos = photos
  $scope.setCurrentPhoto(photos[0])
  $scope.tags = JSON.parse photos[0].tags
  $scope.photosMax = 32
  $scope.bourgeois = 'Adrien'

  $scope.morePhotos = ->
    $scope.photosMax += 32

  $scope.restartMaxPhotos = ->
    $scope.photosMax = 32

  $scope.heightMap = { "height": '100px' }


  $scope.setHeightMap = (value) ->
    $scope.heightMap = { "height": value }
    $timeout (->
      $scope.setCurrentPhoto($scope.currentPhoto)
    ), 50
]