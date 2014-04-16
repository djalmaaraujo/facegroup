describe 'Unit: MainCtrl', ->
  beforeEach module 'facegroupApp'

  describe "MainCtrl", ->
    m = {}

    beforeEach inject ($controller, $rootScope, $q) ->
      m.scope = $rootScope.$new()
      m.q = $q
      m.controller = $controller 'MainCtrl',
        $q: m.q
        $scope: m.scope
        $location: {}

    describe "Default Params", ->
      it 'checks for required permissions', ->
        expect(m.scope.REQUIRED_PERMISSIONS).toEqual ['user_about_me', 'user_groups', 'email', 'publish_actions']

      it 'expect to not be logged', ->
        expect(m.scope.logged).toBe false

    describe "#checkPermissions", ->
      it 'expect to return false for missing permissions', ->
        badPermissions = {'permission1': 1}

        expect(m.scope.checkPermissions(badPermissions)).toBe false

      it 'expect to true for all permissions', ->
        goodPermissions = {'user_about_me': 1, 'user_groups': 1, 'email': 1, 'publish_actions': 1}

        expect(m.scope.checkPermissions(goodPermissions)).toBe true
