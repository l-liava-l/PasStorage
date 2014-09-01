App.controller 'SignUpCtrl', ($scope, storage, $location) ->


 $scope.globalpass = storage.session.globalPass

 $scope.key = {
   value: []
 }

 $scope.inputs = [0, 1, 2, 3]
 $scope.model = {}
 $scope.keyboard = [
   [1,2,3]
   [4,5,6]
   [7,8,9]
   ['0', '<', '']
 ]

 $scope.checkNum = (num) ->

   console.log num, typeof num, typeof num is 'number'
   if typeof parseInt num is 'number' then true

 $scope.checkValue = (num)->

   value = $scope.key.value
   if num is '<' then value.pop()
   else if num is '' then null
   else
    if value.length < 4
     value.push num


   $scope.showAlert = false
   if value.length is 4
     if storage.session.globalPass
       if value.join('') is storage.session.globalPass
         storage.session.masterPassword = true
         $location.path('default')
       else
         $scope.showAlert = true
     else
       storage.session.masterPassword = true
       storage.saveToLocal('globalPass',value.join(''))
       $location.path('default')






