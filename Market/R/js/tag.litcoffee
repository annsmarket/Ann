    define ['app', 'jquery'], (app, $) ->
        app.controller "TagCtrl", ["$scope", 'utils', "serviceModel", "tagModel", ($scope, utils, serviceModel, tagModel) ->
            $('#tagMenu').addClass 'active'
            $('#homeMenu').removeClass 'active'
            $('#companyMenu').removeClass 'active'
            $('#serviceMenu').removeClass 'active'
            # $('body').css({'background-color': 'black'})

인기있는 태그들은 더 크게 나오게도 할 수 있다.(또는 우선 순위) 인기도를 조작할 수 있다.

            utils.injectScope $scope, serviceModel, tagModel

            chosenTags = []

            $scope.getList = ->
                tagModel.find {sort: {popularity: -1}}, (result) ->
                    $scope.tags = result
                    return
                return

            $scope.chooseTag = ($event, tag) ->
                $event.preventDefault()
                targetButton = $($event.target)
                console.log targetButton
                if targetButton.hasClass 'badge-default'
                    targetButton.removeClass 'badge-default'
                    targetButton.addClass 'badge-primary'
                    chosenTags.push tag.id
                else
                    targetButton.removeClass 'badge-primary'
                    targetButton.addClass 'badge-default'
                    for chosenTag, i in chosenTags
                        console.log i, chosenTag
                        if chosenTag is tag.id
                            chosenTags.splice(i, 1)
                            break

태그를 넣어준다. 태그를 여러개 체크할 수 있게 한다.

                console.log chosenTags

                serviceModel.find
                    filter:
                        tags: {$all: chosenTags}
                    , (result) ->
                        $scope.services = result
                        return

                return

            return
            ]
        return
