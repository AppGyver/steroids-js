describe "steroids", ->

  describe "layers", ->

    it "should be defined", ->
      expect( steroids.layers ).toBeDefined()

    describe "push and pop", ->

      it "should push and pop a view", ->

        pushed = false
        popped = false
        animationFinished = false

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
          window.setTimeout =>
            animationFinished = true
          , 1000

          waitsFor -> animationFinished

          runs ->
            expect( popped ).toBeTruthy()

    describe "visibilitychange", ->

      it "should log two visibilitychange events", ->
        visibilityChangeCount = 0
        hidden = false
        visible = false

        document.addEventListener "visibilitychange", ->
          visibilityChangeCount += 1
          if document.visibilityState is "hidden"
            hidden = true
          if document.visibilityState is "visible"
            visible = true

        pushed = false
        popped = false
        animationFinished = false

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
          window.setTimeout =>
            animationFinished = true
          , 1000

          waitsFor -> animationFinished

          runs ->
            expect(visibilityChangeCount).toEqual(2)
            expect(hidden).toBeTruthy()
            expect(visible).toBeTruthy()