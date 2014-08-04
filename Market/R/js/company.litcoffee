    define ['app', 'jquery'], (app, $) ->
        app.controller "CompanyCtrl", ["$scope", "companyModel", ($scope, companyModel) ->
            $('#companyMenu').addClass 'active'
            $('#serviceMenu').removeClass 'active'
            $('#tagMenu').removeClass 'active'
            $('#homeMenu').removeClass 'active'
            $scope.getList = ->
                companyModel.findDataSet {filter: {}}, (result) ->
                    if result.hasError is false
                        $scope.companies = result.savedDataSet
                        $scope.$apply()
                    return
                return

            $scope.register = ->
                await companyModel.create
                    name: $scope.name
                    , defer result

                if result.hasError is false
                    $('#result').html('Registration is completed')
                    $scope.getList()

                return
            return
            ]
        return
