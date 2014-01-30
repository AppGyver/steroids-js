
describe "steroids", ->

  describe "splashscreen", ->

    it "should be defined", ->

      expect(steroids.splashscreen).toBeDefined()

    describe "show", ->

      it "should be defined", ->
        expect(steroids.splashscreen.show).toBeDefined()

      it "should show", ->

        shown = false

        steroids.splashscreen.show {},
          onSuccess: ->
            shown = true

        waitsFor -> shown

        runs ->
          expect(shown).toBeTruthy()


    describe "hide", ->

      it "should be defined", ->
        expect(steroids.splashscreen.hide).toBeDefined()

      it "should hide", ->

        hidden = false

        steroids.splashscreen.hide {},
          onSuccess: ->
            hidden = true

        waitsFor -> hidden

        runs ->
          expect(hidden).toBeTruthy()