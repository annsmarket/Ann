Angular Wrapper

    OVERRIDE Market.MODEL, (origin) ->

        Market.MODEL = CLASS

            preset: ->
                origin

            init: (inner, self, params) ->

                query = (origin, argument, callback) ->

In case cb is an object, we need to make callback branches.

                    if typeof callback is 'function'
                        origin argument, (result) ->
                            self.scope.$apply ->
                                callback result
                                return
                            return
                    else
                        newCallback = {}
                        for key, value of callback
                            ((value) ->
                                newCallback[key] = ->
                                    args = arguments
                                    self.scope.$apply ->
                                        if args.length is 0
                                            value()
                                        else
                                            value arguments[0]
                                        return
                                    return
                                )(value)

                        origin argument, newCallback

                    return

                OVERRIDE self.find, (origin) ->
                    self.find = (argument, cb) ->
                        query origin, argument, cb
                        return
                    return

                OVERRIDE self.get, (origin) ->
                    self.get = (argument, cb) ->
                        query origin, argument, cb
                        return
                    return

                OVERRIDE self.create, (origin) ->
                    self.create = (argument, cb) ->
                        query origin, argument, cb
                        return
                    return

                return

        return
