describe "Device", ->

  describe "platform", ->
    it "should be an object", ->
      steroids.device.platform.should.be.an "object"
      
    describe "getName", ->
      it "should be a string", (done) ->
        steroids.device.platform.getName {},
          onSuccess: (name) ->
            name.should.be.a "string"
            done()
          onFailure: (error) ->
            done new Error error

      it "should match the platform used", (done) ->
        steroids.device.platform.getName {},
          onSuccess: (name) ->
            if navigator.userAgent.match(/(iPod|iPhone|iPad)/)
              name.should.equal "ios"
              done()
            else if navigator.userAgent.match(/(Android)/)
              name.should.equal "android"
              done()
            else
              done new Error "did not match"

  describe "torch", ->
    it "should be an object", ->
      steroids.device.torch.should.be.an "object"

    describe "toggle", ->
      it "should toggle torch", (done) ->
        steroids.device.torch.toggle {},
          onSuccess: ->
            steroids.device.torch.turnOff()
            done()
          onFailure: (error) ->
            done new Error error

    describe "turnOn", ->
      it "should turn on", (done) ->
        steroids.device.torch.turnOn {},
          onSuccess: ->
            done()
          onFailure: (error) ->
            done new Error error

    describe "turnOff", ->
      it "should turn off", (done) ->
        steroids.device.torch.turnOff {},
          onSuccess: -> 
            done()
          onFailure: (error) ->
            done new Error error

  describe "ping", ->
    it "should pong", (done) ->
      steroids.device.ping {},
        onSuccess: ->
          done()
        onFailure: (error) ->
          done new Error error

  describe "getIPAddress", ->
    it "should receive message with ipAddress property", (done) ->
      steroids.device.getIPAddress {},
        onSuccess: (message) ->
          message.should.have.property("ipAddress").that.is.a "string"
          done()
        onFailure: (error) ->
          done new Error error

    it "property should be formatted like an ip address", (done) ->
      steroids.device.getIPAddress {},
        onSuccess: (message) ->
          message.ipAddress.should.match(/\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/)
          done()
        onFailure: (error) ->
          done new Error error

  describe "disableSleep", ->
    it "should disable", (done) ->
      steroids.device.disableSleep {},
        onSuccess: ->
          done()
        onFailure: (error) ->
          done new Error error

  describe "enableSleep", ->
    it "should enable", (done) ->
      steroids.device.enableSleep {},
        onSuccess: ->
          done()
        onFailure: (error) ->
          done new Error error
