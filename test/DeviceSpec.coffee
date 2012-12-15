buster.spec.expose()

describe "Device API", ->

  it "should exist", ->

    expect( typeof Steroids.device ).toBe "object"

  describe "Ping", ->

    it "should pong", (done)->

      Steroids.device.ping {
        data: "hih"
      }, {
        onSuccess: (parameters, options)->
          expect( parameters.message ).toBe "pong"
          done()
        onFailure: ->
          assert false
          done()
      }
