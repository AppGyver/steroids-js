describe "steroids", ->

  describe "modal", ->

    it "should be defined", ->
      expect( steroids.modal ).toBeDefined()

    describe "show", ->

      it "should be defined", ->
        expect( steroids.modal.show ).toBeDefined()

      it "should present and hide a modal", ->

        presented = false
        dismissed = false

        waits(500)

        runs ->
          googleView = new steroids.views.WebView("http://www.google.com")

          steroids.modal.show { view: googleView },
            onSuccess: -> presented = true

          waitsFor -> presented

          runs ->
            expect( presented ).toBeTruthy()

            waits(500)

            runs ->
              steroids.modal.hide {},
                onSuccess: -> dismissed = true
                onFailure: (msg) -> alert(JSON.stringify(msg))

              waitsFor -> dismissed

              runs ->

                expect( dismissed ).toBeTruthy()