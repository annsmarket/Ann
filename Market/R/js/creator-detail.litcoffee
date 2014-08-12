    define ['app', 'jquery'], (app, $) ->
        app.controller "CreatorDetailCtrl", ($scope, $routeParams, $window, utils, creatorModel, commentModel) ->
            console.log $window.sessionStorage.me
            utils.injectScope $scope, commentModel, creatorModel
            getList = ->
                commentModel.find {filter: {creator: $scope.creator.id}}, (result) ->
                    console.log result
                    $scope.comments = result
                    return
                return

            creatorModel.get $routeParams['id'], (result) ->
                $scope.creator = result
                getList()
                return

            $scope.register = ->
                commentModel.create
                    authorId: $window.sessionStorage.me.id
                    authorName: $window.sessionStorage.me.name
                    content: $scope.content
                    creator: $scope.creator.id
                    , (result) ->
                        $scope.result = 'Registration is completed'
                        $scope.author = $scope.content = ''
                        getList()
                        return
                return

            return
        return
