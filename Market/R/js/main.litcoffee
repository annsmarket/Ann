    require.config
        baseUrl: "js"
        paths:
            'angular': 'https://ajax.googleapis.com/ajax/libs/angularjs/1.2.21/angular.min'
            'angular-route': 'https://ajax.googleapis.com/ajax/libs/angularjs/1.2.21/angular-route.min'
            'angularAMD': 'http://cdn.jsdelivr.net/angular.amd/0.2/angularAMD.min'
            'jquery': 'http://code.jquery.com/jquery-1.11.1.min'
            'bootstrap': 'http://netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min'
            'ezfb': 'http://pc035860.github.io/angular-easyfb/angular-easyfb.min'

            'HomeCtrl': 'home'
            'CreatorCtrl': 'creator'
            'CreatorDetailCtrl': 'creator-detail'
            'ServiceCtrl': 'service'
            'ServiceDetailCtrl': 'service-detail'
            'TagCtrl': 'tag'

        shim:
            'angularAMD': ['angular']
            'angular-route': ['angular']
            'ezfb': ['angular']

        deps: ['app']
