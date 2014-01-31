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

      it "should be updated with title", ->

        updated= false

        steroids.view.navigationBar.update {title: "Title"},
          onSuccess: ->
            updated = true

        waitsFor -> updated

        runs ->
          expect(updated).toBeTruthy()

      it "should be updated with title image", ->

        updated= false

        steroids.view.navigationBar.update {titleImagePath: "/icons/pill@2x.png"},
          onSuccess: ->
            updated = true

        waitsFor -> updated

        runs ->
          expect(updated).toBeTruthy()

      it "should be updated with buttons", ->

        updated= false

        button = new steroids.buttons.NavigationBarButton
        button.title = "Button"
        button.onTap = => alert "RIGHT BUTTON TAPPED"

        steroids.view.navigationBar.update {
          buttons: {
            right: [button]
          }
        },
          onSuccess: ->
            updated = true

        waitsFor -> updated

        runs ->
          expect(updated).toBeTruthy()

      it "should be hided", ->

        hided = false

        steroids.view.navigationBar.hide {},
          onSuccess: ->
            hided = true

        waitsFor -> hided

        runs ->
          expect(hided).toBeTruthy()

