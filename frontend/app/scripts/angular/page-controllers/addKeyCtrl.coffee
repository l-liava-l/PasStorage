App.controller 'AddKeyCtrl', ($scope, storage, $ionicSideMenuDelegate) ->

  $scope.keyStorage = storage.session.keyStorage ?= []

  $scope.editGroup = storage.session.editGroup ?= {
    name: null
    accs: []
  }

  $scope.addAccount = () ->
    $scope.editGroup.accs.push {
      alias: null
      password: null
    }

  $scope.del = (id) ->
    $scope.editGroup.accs.splice(id , 1)

  $scope.reset = () ->
    $scope.editGroup = {
      name: null
      accs: [{
        alias: null
        password: null
      }]
    }

  $scope.edit = (group, index) ->
    $ionicSideMenuDelegate.toggleRight()
    console.log index
    group.id = index + ''
    $scope.editGroup = angular.copy group


  $scope.save = ->
    $scope.editGroup.name ?= "Password group " + ($scope.keyStorage.length + 1)



    for i of angular.copy $scope.editGroup.accs
      if !$scope.editGroup.accs[i].alias
        $scope.editGroup.accs[i].alias = 'No name' + (parseInt(i) + 1)

      if !$scope.editGroup.accs[i].password
        $scope.editGroup.accs[i].password = 'no password'


    if $scope.editGroup.accs.length is 0
      if $scope.editGroup.id
        $scope.keyStorage.splice($scope.editGroup.id, 1)
    else

      console.log $scope.editGroup.id
      if $scope.editGroup.id
        $scope.keyStorage[$scope.editGroup.id] = angular.copy $scope.editGroup
      else
        $scope.keyStorage.push angular.copy($scope.editGroup)


    storage.saveToLocal('keyStorage', $scope.keyStorage)
    $ionicSideMenuDelegate.toggleRight()

  randomWord = (n) ->
    Math.random().toString(36).slice(2, 2 + Math.max(1, Math.min(n, 10)) )

  $scope.newPass = (account) ->
    encrypted = CryptoJS.SHA256(randomWord(9))
    account.password = encrypted.toString(CryptoJS.enc.Base64).slice(0, 12)
    $scope.checkPass(account)

  $scope.checkPass = (account) ->

    pass = account.password

    diffBall = 0

    if pass.length > 8 then diffBall += 1
    if pass.length > 5
      if /[0-9]/.test(pass) and /[A-Za-z]/.test(pass) then diffBall += 1
      if /[A-Z]/.test(pass) and /[a-z]/.test(pass)  then diffBall += 1

    if diffBall is 0
      color = 'assertive'
      icon = 'ion-minus-round'
    if diffBall is 1
      icon = "ion-arrow-swap"
      color = 'energized'
    if diffBall >= 2
      icon = "ion-checkmark"
      color = 'balanced'

    account.passDifcolor = color
    account.passDificon = icon












