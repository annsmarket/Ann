    define ['app', 'jquery'], (app, $) ->
        app.controller "CreatorCtrl", ($scope, utils, creatorModel) ->
            utils.injectScope $scope, creatorModel
            $scope.getList = ->
                creatorModel.find {}, (result) ->
                    if result.hasError is false
                        $scope.creators = result
                    return
                return
            return
        return
