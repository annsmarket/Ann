# 브라우저

    define ['app', 'jquery'], (app, $) ->
        app.controller "HomeCtrl", ["$scope", "utils", "serviceModel", ($scope, utils, serviceModel) ->
            $('#homeMenu').addClass 'active'
            $('#tagMenu').removeClass 'active'
            $('#companyMenu').removeClass 'active'
            $('#serviceMenu').removeClass 'active'

            utils.injectScope $scope, serviceModel

            serviceModel.find
                start: 0
                count: 4
                , (result) ->
                    $scope.todayTopServices = result
                    return

            return
        ]
        return
