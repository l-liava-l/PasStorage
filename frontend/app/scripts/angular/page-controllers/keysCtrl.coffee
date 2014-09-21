App.controller 'KeysCtrl', ($scope, storage, $ionicSideMenuDelegate, $location ) ->

  if !storage.session.masterPassword  $location.path('signup')
  else storage.session.masterPassword = false

  $scope.keyStorage = storage.session.keyStorage ?= []
  $scope.AccountModel = {}

  $scope.show = (name) ->
    $scope.showed = name

  $scope.showPass = (index) ->
    $scope.AccountModel[index] = true

  $scope.hidePass = (index) ->
    $scope.AccountModel[index] = false

  $scope.setEditing = () ->
    $scope.editing = !$scope.editing

  $scope.new = () ->
    $scope.reset()
    $ionicSideMenuDelegate.toggleRight()














