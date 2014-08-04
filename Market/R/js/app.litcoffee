    define [
        'angularAMD'
        'jquery'
        'angular-route'
        'ngStorage'
        'ezfb'
    ], (angularAMD, $) ->
        app = angular.module("ngreq-app", ["ngRoute", 'ezfb'])

        app.factory 'utils', ->
            injectScope: () ->
                scope = arguments[0]
                for i in [1...arguments.length]
                    arguments[i].scope = scope

                return

        app.factory 'companyModel', ->
            Market.CompanyModel

        app.factory 'serviceModel', ->
            Market.ServiceModel

        app.factory 'commentModel', ->
            Market.CommentModel

        app.factory 'tagModel', ->
            Market.TagModel

        app.config (ezfbProvider) ->
            ezfbProvider.setInitParams
                appId: '217817081761575'

            return

        app.config [
            "$routeProvider"
            ($routeProvider) ->
                $routeProvider.when("/home", angularAMD.route(
                    templateUrl: "home.html"
                    controller: "HomeCtrl"
                )).when("/tag", angularAMD.route(
                    templateUrl: "tag.html"
                    controller: "TagCtrl"
                )).when("/company", angularAMD.route(
                    templateUrl: "company.html"
                    controller: "CompanyCtrl"
                )).when("/service", angularAMD.route(
                    templateUrl: "service.html"
                    controller: "ServiceCtrl"
                )).when("/service/:id", angularAMD.route(
                    templateUrl: "service-detail.html"
                    controller: "ServiceDetailCtrl"
                )).otherwise redirectTo: "/home"
            ]

        app.controller "MenuCtrl", ($scope, $window, ezfb) ->
            $scope.safeApply = (fn) ->
                phase = @$root.$$phase
                if phase is "$apply" or phase is "$digest"
                    console.log 'in'
                    @$eval fn
                else
                    console.log 'out'
                    @$apply fn

                console.log $scope.loginStatus

                return

            updateLoginStatus = (more) ->
                ezfb.getLoginStatus (res) ->
                    console.log res
                    $scope.loginStatus = res
                    if res.status is 'connected'
                        $('#loginButton').hide()
                        $('#logoutButton').show()
                    else
                        $('#logoutButton').hide()
                        $('#loginButton').show()

                    (more || angular.noop)()
                    return
                return

            updateApiMe = ->
                ezfb.api '/me', (res) ->
                    console.log 'me', res
                    $window.sessionStorage.me = res
                    $scope.me = res
                    return
                return

            updateLoginStatus updateApiMe

            $scope.login = ->
                ezfb.login (res) ->
                    if res.authResponse
                        updateLoginStatus updateApiMe
                    return
                return

            $scope.logout = ->
                ezfb.logout ->
                    updateLoginStatus updateApiMe
                    console.log 'out'
                    return
                return

            return

      # Define constant to be used by Google Analytics
        # app.constant "SiteName", "/angularAMD"

      # Create function to link to GitHub
      # Bootstrap Angular when DOM is ready
        angularAMD.bootstrap app
