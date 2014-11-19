describe "Layers", ->

  beforeEach (done) ->
    document.addEventListener "deviceready", ->
      setTimeout done, 500
      # to solve iOS issue of trying to push when previous push is still under way

  it "should be defined", ->
    steroids.layers.should.be.defined

  describe "pop & push", ->
    it "should push and pop a view", (done) ->
      googleView = new steroids.views.WebView "http://www.google.com"

      steroids.layers.push {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.layers.pop {},
              onSuccess: ->
                done()
              onFailure: (error) ->
                done new Error "could not pop view: " + error.message
          , 500
        onFailure: (error) ->
          done new Error "could not push view: " + error.message
      }

  describe "layers.on", ->
    it "should log 4 layer events in total when pushing and popping a layer", (done)->

      eventsCount = 0

      steroids.layers.on "willchange", ->
        eventsCount++

      steroids.layers.on "didchange", ->
        eventsCount++

      googleView = new steroids.views.WebView "http://www.google.com"

      steroids.layers.push {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.layers.pop {},
              onSuccess: ->
                eventsCount.should.equal 4
                done()
              onFailure: (error) ->
                done new Error "could not pop view: " + error.message
          , 500
        onFailure: (error) ->
          done new Error "could not push view: " + error.message
      }