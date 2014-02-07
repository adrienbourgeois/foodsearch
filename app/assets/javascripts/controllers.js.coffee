controllers = angular.module('controllers', []);

controllers.controller "PhotoListCtrl", ["$scope", "$http", "$q", "$timeout", "$location", "app", ($scope, $http, $q, $timeout, $location, app) ->
  console.log "location: #{$location.path()}"
  map = null
  photos = app

  $scope.createMap = ({latitude:latitude,longitude:longitude,mapDiv:mapDiv}) ->
    console.log "gooo"
    myLatlng = new google.maps.LatLng(latitude, longitude)
    mapOptions =
      center: myLatlng
      zoom: 16
      mapTypeId: google.maps.MapTypeId.ROADMAP
    map = new google.maps.Map(document.getElementById(mapDiv), mapOptions)
    marker = new google.maps.Marker(
      position: myLatlng
      map: map
    )

  $scope.setCurrentPhoto = (photo) ->
    $scope.currentPhoto = photo
    $scope.tags = JSON.parse photo.tags
    $scope.createMap {latitude:photo.latitude,longitude:photo.longitude,mapDiv:"map-canvas"}

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
  $scope.listDisplay = { "display": "none" }
  $scope.gridDisplay = { "display": "block" }
  $scope.changeViewOrganization = (type) ->
    if type is "grid"
      $scope.listDisplay = { "display": "none" }
      $scope.gridDisplay = { "display": "block" }
    else
      $scope.listDisplay = { "display": "block" }
      $scope.gridDisplay = { "display": "none" }

  $scope.keywords = []

  $scope.myFilter = (o) ->
    for keyword in $scope.keywords
      if o.tags.search(keyword) is -1
        return false
    if $scope.foodType != undefined and o.tags.search($scope.foodType.tags) is -1
      return false
    return true


  $scope.helloworld = (value) ->
    $scope.keywords.push value
    console.log $scope.keywords
    $scope.foodType.tags = ""

  $scope.test = ({value:value}) ->
    console.log value


  $scope.setHeightMap = (value) ->
    $scope.heightMap = { "height": value }
    $timeout (->
      $scope.setCurrentPhoto($scope.currentPhoto)
    ), 50
]
