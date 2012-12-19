buster.spec.expose()

describe "NavigationBar", ->

  it "should exist", ->

    expect( typeof Steroids.navigationBar ).toBe "object"

  describe "navigationBar", ->

    it "should appear", (done)->

      Steroids.navigationBar.show {title: "Steroids!"}
      assert true
      done()

    it "should show right button", (done)->
      Steroids.navigationBar.rightButton.show {title: "nabbula"}
        onSuccess: (parameters)->
          assert true
          done()
        onFailure: ->
          assert false
          done()