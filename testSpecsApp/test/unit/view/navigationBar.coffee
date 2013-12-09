describe "steroids", ->

  describe "view", ->

    describe "navigationBar", ->

      it "should be defined", ->
        expect(steroids.view.navigationBar).toBeDefined()

      it "should be shown", ->

        shown = false

        steroids.view.navigationBar.show {},
          onSuccess: ->
            shown = true

        waitsFor -> shown

        runs ->
          expect(shown).toBeTruthy()

      it "should be hided", ->

        hided = false

        steroids.view.navigationBar.hide {},
          onSuccess: ->
            hided = true

        waitsFor -> hided

        runs ->
          expect(hided).toBeTruthy()

