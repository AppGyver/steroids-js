buster.spec.expose()

describe "UI", ->

  it "should exist", ->

    expect( typeof Steroids.UI ).toBe "object"

  describe "navigationBar", ->

    it "should appear", (done)->

      Steroids.UI.navigationBar.show {title: "Nebu"}
      assert true
      done()

    it "should show right button", (done)->
      Steroids.UI.navigationBar.rightButton.show {title: "Nibu"}
        onSuccess: (parameters)->
          console.log parameters
          assert true
          done()
        onFailure: ->
          assert false
          done()