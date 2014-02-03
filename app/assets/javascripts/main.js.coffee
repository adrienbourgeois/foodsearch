app = angular.module("SearchFood",["ngResource"])

app.factory "Photo", ["$resource", ($resource) ->
  $resource("/photos/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.controller "PhotoListCtrl", ["$scope", "Photo", ($scope, Photo) ->

  $scope.photos = Photo.query( (photos) ->
    $scope.currentPhoto =  photos[0]
  )

  $scope.setCurrentPhoto = (photo) ->
    $scope.currentPhoto = photo

  $scope.photosMax = 32

  $scope.morePhotos = ->
    $scope.photosMax += 32

  $scope.restartMaxPhotos = ->
    $scope.photosMax = 32

]

