describe "steroids", ->

  describe "view", ->

    describe "navigationBar", ->

      it "should be defined", ->
        expect(steroids.view.navigationBar).toBeDefined()

      describe "show", ->

        describe "with title text", ->

          it "should appear with text", ->

            shown = false

            steroids.view.navigationBar.show {
              title: "title"
            }, {
              onSuccess: ->
                shown = true
            }

            runs ->
              expect(shown).toBeTruthy()

        describe "with title image", ->

          # TODO: how to test with karma?
          xit "should appear title image", ->

            shown = false

            steroids.view.navigationBar.show {
              titleImage: "dolan.png"
            }, {
              onSuccess: ->
                shown = true
            }

            waitsFor -> shown

            runs ->
              expect(shown).toBeTruthy()

        describe "without title text or title image", ->

          it "should become visible", ->

            shown = false

            steroids.view.navigationBar.show {},
              onSuccess: ->
                shown = true

            waitsFor -> shown

            runs ->
              expect(shown).toBeTruthy()

          it "should become visible with animation", ->

            shownWithAnimation = false

            steroids.view.navigationBar.show {
              animated: true
            }, {
              onSuccess: ->
                shownWithAnimation = true
            }

            waitsFor -> shownWithAnimation

            runs ->
              expect(shownWithAnimation ).toBeTruthy()

      describe "update", ->

        it "should be updated with title", ->

          updated= false

          steroids.view.navigationBar.update {title: "Title"},
            onSuccess: ->
              updated = true

          waitsFor -> updated

          runs ->
            expect(updated).toBeTruthy()

        it "should be updated with title image", ->

          imageUpdated= false

          steroids.view.navigationBar.update {titleImagePath: "/icons/pill@2x.png"},
            onSuccess: ->
              imageUpdated= true

          waitsFor -> imageUpdated

          runs ->
            expect(imageUpdated).toBeTruthy()

        it "should be updated with buttons", ->

          buttonsUpdated = false

          button = new steroids.buttons.NavigationBarButton
          button.title = "Button"
          button.onTap = => alert "RIGHT BUTTON TAPPED"

          steroids.view.navigationBar.update {
            buttons: {
              right: [button]
            }
          },
            onSuccess: ->
              buttonsUpdated = true

          waitsFor -> buttonsUpdated

          runs ->
            expect(buttonsUpdated).toBeTruthy()

      describe "hide", ->

        it "should be hided", ->

          hided = false

          steroids.view.navigationBar.hide {},
            onSuccess: ->
              hided = true

          waitsFor -> hided

          runs ->
            expect(hided).toBeTruthy()

        it "should be hided with animation", ->

          hidedWithAnimation = false

          steroids.view.navigationBar.hide {
            animated: true
          }, {
            onSuccess: ->
              hidedWithAnimation = true
          }

          waitsFor -> hidedWithAnimation

          runs ->
            expect(hidedWithAnimation ).toBeTruthy()
