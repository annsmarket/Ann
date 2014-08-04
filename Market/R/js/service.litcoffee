    define ['app', 'jquery'], (app, $) ->
        app.controller "ServiceCtrl", ["$scope", "utils", "serviceModel", "tagModel", ($scope, utils, serviceModel, tagModel) ->
            # $('body').css({'background-color': 'black'})
            $('#serviceMenu').addClass 'active'
            $('#companyMenu').removeClass 'active'
            $('#tagMenu').removeClass 'active'
            $('#homeMenu').removeClass 'active'
            utils.injectScope $scope, serviceModel, tagModel

            $scope.getList = ->
                serviceModel.find {}, (result) ->
                    console.log 'result', result
                    $scope.services = result
                    return

                return

            $scope.getList()

            $scope.register = ->

태그를 넣어준다.

                tags = []

                if $scope.tags?
                    tags = $scope.tags.split ','

                tagIds = []

                NEXT tags, [
                    (tag, next) ->
                        console.log 'tag', tag

                        tagModel.get {filter: {name: tag}},
                            success: (result) ->
                                console.log 's'
                                tagId = result.id
                                tagIds.push tagId
                                next()
                                return

                            notExists: ->
                                console.log 'n'
                                tagModel.create {name: tag}, (result) ->
                                    tagId = result.id
                                    tagIds.push tagId
                                    next()
                                    return
                                return

                            error: (message) ->
                                console.log 'error', message
                                return
                        return
                    ->
                        ->
                            console.log 'final'
                            serviceModel.create
                                name: $scope.name
                                description: $scope.description
                                tags: tagIds
                                , (result) ->
                                    $scope.showForm = false
                                    $('#result').html('Registration is completed')
                                    $scope.getList()
                                    return
                            return
                ]

                return

            return
            ]
        return
