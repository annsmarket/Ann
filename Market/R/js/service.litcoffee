    define ['app', 'jquery'], (app, $) ->
        app.controller "ServiceCtrl", ($scope, $window, utils, serviceModel, tagModel, creatorModel) ->
            # $('body').css({'background-color': 'black'})
            # $('#serviceMenu').addClass 'active'
            # $('#companyMenu').removeClass 'active'
            # $('#tagMenu').removeClass 'active'
            # $('#homeMenu').removeClass 'active'
            utils.injectScope $scope, serviceModel, tagModel, creatorModel

            $scope.getList = ->
                serviceModel.find {}, (result) ->
                    console.log 'result', result
                    $scope.services = result
                    return

                return

            $scope.getList()

            createService = (tagIds, creatorId) ->
                serviceModel.create
                        creatorId: creatorId
                        name: $scope.name
                        description: $scope.description
                        tags: tagIds
                    , (result) ->
                        $scope.showForm = false
                        $('#result').html('Registration is completed')
                        $scope.getList()
                        return
                return

            $scope.register = ->

Add tags.

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
                            creatorId = $window.sessionStorage.getItem 'creatorId'
                            console.log 'c', creatorId

                            if creatorId?
                                console.log 'cc'
                                createService tagIds, creatorId
                            else
                                creatorModel.create
                                        fbId: $window.sessionStorage.getItem 'fbId'
                                        name: $window.sessionStorage.getItem 'name'
                                    , (result) ->
                                        creatorId = result.id
                                        console.log 'ccc', creatorId
                                        $window.sessionStorage.setItem 'creatorId', creatorId
                                        createService tagIds, creatorId
                                        return

                            return
                ]

                return

            return
        return
