buster.spec.expose()

describe "Flash API", ->
  before ->
    @timeout = 3000

  it "should exist", ->

    expect( typeof Steroids.Camera.flash ).toBe "object"

  describe "Toggle", ->

    it "should toggle on and off", (done)->

      Steroids.Camera.flash.toggle {},
        onSuccess: ->
          Steroids.Camera.flash.toggle {},
            onSuccess: ->
              assert true
              done()
            onFailure: ->
              assert false
              done()
        onFailure: ->
          assert false
          done()
