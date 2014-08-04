    describe 'CompanyCtrl', ->
        beforeEach module('marketApp')

        it('contains spec with an expectation', inject ($controller) ->
            scope = {}
            ctrl = $controller('CompanyCtrl', {$scope:scope})
            scope.name = 'test'
            scope.register()
            scope.getList()
            expect(scope.companies.length).toBeGreaterThan(1)
            return
            )
        return
