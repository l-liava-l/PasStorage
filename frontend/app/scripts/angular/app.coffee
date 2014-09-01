'use strict'

App = angular.module('app', [
  'ionic', 'ngResource'
]).run () ->

  App.config [
    '$stateProvider'
    '$urlRouterProvider'
    '$httpProvider'
    ($stateProvider, $urlRouterProvider, $httpProvider) ->

      headers  = $httpProvider.defaults.headers

      headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'

      $httpProvider.defaults.transformRequest.unshift (data) ->
        if angular.isObject(data) then angular.toQueryString(data) else data

      $stateProvider
      #menu
      .state 'main',
        url: '/main'
        abstract: true
        templateUrl: "templates/pages/menu.html"

      #pages
      .state 'main.keys',
        url: '/keys'
        views:
          menuContent:
            templateUrl: "templates/pages/keys.html"
            controller: "KeysCtrl"

      .state 'main.add_key',
        url: '/add-key'
        views:
          menuContent:
            templateUrl: "templates/pages/add_key.html"
            controller: "AddKeyCtrl"

      .state 'signup',
        url: '/signup'
        abstract: false
        templateUrl: "templates/pages/signup.html"


      $urlRouterProvider.otherwise "/main/keys"
  ]

