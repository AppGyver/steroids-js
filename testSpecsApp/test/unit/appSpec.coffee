describe "steroids", ->

  describe "app", ->

    it "should be defined", ->
      expect( steroids.app ).toBeDefined()

    describe "app mode", ->

      it "should return the mode", ->
        mode = null

        steroids.app.getMode {},
          onSuccess: (gotMode) -> mode = gotMode

        waitsFor -> mode?

        runs ->
          expect( mode ).toBe("scanner")

    describe "host", ->

      it "should be defined", ->
        expect( steroids.app.host ).toBeDefined()

      describe "getURL", ->

        it "should be defined", ->
          expect( steroids.app.host.getURL ).toBeDefined()

        it "should return an URL", ->

          @gotURL = undefined

          steroids.app.host.getURL {},
            onSuccess: (url) =>
              @gotURL = url

          waitsFor -> @gotURL

          runs ->
            expect( @gotURL ).toMatch(/http:\/\/(\d+)\.(\d+)\.(\d+)\.(\d+)\:4567$/)

