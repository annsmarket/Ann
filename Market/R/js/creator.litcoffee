    define ['app', 'jquery'], (app, $) ->
        app.controller "CreatorCtrl", ($scope, utils, creatorModel) ->
            utils.injectScope $scope, creatorModel
            creatorModel.find {}, (result) ->
                $scope.creators = result
                return
            return
        return
