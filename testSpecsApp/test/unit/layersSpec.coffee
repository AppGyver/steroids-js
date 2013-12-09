describe "steroids", ->

  describe "layers", ->

    it "should be defined", ->
      expect( steroids.layers ).toBeDefined()

    describe "push and pop", ->

      it "should push and pop a view", ->

        pushed = false
        popped = false

        googleView = new steroids.views.WebView "http://www.google.com"

        steroids.layers.push googleView,
          onSuccess: ->
            pushed = true

        waitsFor -> pushed

        runs ->
          expect( pushed ).toBeTruthy()

        window.setTimeout =>
          steroids.layers.pop {},
            onSuccess: ->
              popped = true
        , 1000

        waitsFor -> popped

        runs ->
          expect( popped ).toBeTruthy()

