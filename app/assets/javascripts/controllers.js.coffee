controllers = angular.module('controllers', []);

controllers.controller "PhotoListCtrl", ["$scope", "$http", "$q", "$timeout", "$location", "app", ($scope, $http, $q, $timeout, $location, app) ->
  map = null
  photos = app
  $scope.distanceArray = [0.3,0.5,1.0,1.5,2.0,3.0,5.0,7.0,10.0,15.0,20.0,30.0,40.0,50.0]

  $scope.createMap = ({latitude:latitude,longitude:longitude,mapDiv:mapDiv}) ->
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
  $scope.changeViewOrganization = ({type:type}) ->
    if type is "grid"
      $scope.listDisplay = { "display": "none" }
      $scope.gridDisplay = { "display": "block" }
    else
      $scope.listDisplay = { "display": "block" }
      $scope.gridDisplay = { "display": "none" }

  $scope.keywords = []
  $scope.distanceArrayIndex = 13

  $scope.myFilter = (o) ->
    for keyword in $scope.keywords
      if o.tags.search(keyword) is -1 or o.distance > $scope.distanceArray[$scope.distanceArrayIndex]
        return false
    if ($scope.foodType != undefined and o.tags.search($scope.foodType.tags) is -1) or o.distance > $scope.distanceArray[$scope.distanceArrayIndex]
      return false
    return true


  $scope.pushKeyWord = (value) ->
    $scope.keywords.push value
    $scope.foodType.tags = ""

  $scope.test = ({value:value}) ->
    console.log value


  $scope.setHeightMap = ({value:value}) ->
    $scope.heightMap = { "height": value }
    $timeout (->
      $scope.setCurrentPhoto($scope.currentPhoto)
    ), 50

  $scope.increaseDistance = ->
    if $scope.distanceArrayIndex < $scope.distanceArray.length - 1
      $scope.distanceArrayIndex += 1

  $scope.decreaseDistance = ->
    if $scope.distanceArrayIndex > 0
      $scope.distanceArrayIndex -= 1
]
