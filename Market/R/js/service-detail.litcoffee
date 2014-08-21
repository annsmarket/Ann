    define ['app', 'jquery'], (app, $) ->
        app.controller "ServiceDetailCtrl", ($scope, $routeParams, $window, utils, serviceModel, commentModel) ->
            utils.injectScope $scope, commentModel, serviceModel
            getList = ->
                commentModel.find {filter: {service: $scope.service.id}}, (result) ->
                    console.log result
                    $scope.comments = result
                    return
                return

            serviceModel.get $routeParams['id'], (result) ->
                $scope.service = result
                getList()
                return

            $scope.register = ->
                commentModel.create
                    authorId: $window.sessionStorage.getItem 'fbId'
                    authorName: $window.sessionStorage.getItem 'name'
                    content: $scope.content
                    service: $scope.service.id
                    , (result) ->
                        $scope.result = 'Registration is completed'
                        $scope.author = $scope.content = ''
                        getList()
                        return
                return

            return
        return
