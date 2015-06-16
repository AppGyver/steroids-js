describe "Layers", ->

  @timeout 2500

  beforeEach (done) ->
    document.addEventListener "deviceready", ->
      setTimeout done, 750
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
                done new Error "could not pop view: " + error.errorDescription
          , 600
        onFailure: (error) ->
          done new Error "could not push view: " + error.errorDescription
      }


  describe "willchange & didchange events", ->

    @timeout 2500

    it "should log 2 'willchange' events when pushing & popping a layer", (done)->
      eventsCount = 0

      steroids.layers.on "willchange", ->
        eventsCount++

      googleView = new steroids.views.WebView "http://www.google.com"

      steroids.layers.push {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.layers.pop {},
              onSuccess: ->
                setTimeout ->
                  eventsCount.should.equal 2
                  done()
                , 500
              onFailure: (error) ->
                done new Error "could not pop view: " + error.errorDescription
          , 1000
        onFailure: (error) ->
          done new Error "could not push view: " + error.errorDescription
      }


    it "should log 2 'didchange' events when pushing & popping a layer", (done)->

      eventsCount = 0

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
                setTimeout ->
                  eventsCount.should.equal 2
                  done()
                , 750
              onFailure: (error) ->
                done new Error "could not pop view: " + error.errorDescription
          , 600
        onFailure: (error) ->
          done new Error "could not push view: " + error.errorDescription
      }
