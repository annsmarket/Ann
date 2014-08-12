    define ['app', 'jquery'], (app, $) ->
        app.controller "CreatorCtrl", ($scope, creatorModel) ->
            $scope.getList = ->
                creatorModel.findDataSet {filter: {}}, (result) ->
                    if result.hasError is false
                        $scope.creators = result.savedDataSet
                        $scope.$apply()
                    return
                return
            return
        return
