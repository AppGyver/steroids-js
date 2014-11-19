describe "visibilitychange", ->

  beforeEach (done) ->
    document.addEventListener "deviceready", ->
      setTimeout done, 750
      # to solve iOS issue of trying to push when previous push is still under way

  googleView = new steroids.views.WebView "http://www.google.com"


  describe "when pushing & popping on top of listening layer", ->
    it "should log two visibilitychange events", (done) ->
      visibilityChangeCount = 0

      document.addEventListener "visibilitychange", ->
        visibilityChangeCount++

      steroids.layers.push {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.layers.pop {},
              onSuccess: ->
                visibilityChangeCount.should.equal 2
                done()
              onFailure: (error) ->
                done new Error "could not pop view: " + error.message
          , 500
        onFailure: (error) ->
          done new Error "could not push view: " + error.message
      }



    it "should log one and only one 'hidden' visibilitychange", (done) ->

      hiddenCount = 0

      document.addEventListener "visibilitychange", ->
        if document.visibilityState is "hidden"
          hiddenCount++

      steroids.layers.push {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.layers.pop {},
              onSuccess: ->
                hiddenCount.should.equal 1
                done()
              onFailure: (error) ->
                done new Error "could not pop view: " + error.message
          , 500
        onFailure: (error) ->
          done new Error "could not push view: " + error.message
      }



    it "should log one 'visible' visibilitychange", (done) ->
      visibleCount = 0

      document.addEventListener "visibilitychange", ->
        if document.visibilityState is "visible"
          visibleCount++

      steroids.layers.push {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.layers.pop {},
              onSuccess: ->
                visibleCount.should.equal 1
                done()
              onFailure: (error) ->
                done new Error "could not pop view: " + error.message
          , 500
        onFailure: (error) ->
          done new Error "could not push view: " + error.message
      }



  describe "when opening a modal on top of listening layer", ->
    it "should log two visibilitychange events", (done) ->
      visibilityChangeCount = 0

      document.addEventListener "visibilitychange", ->
        visibilityChangeCount++

      steroids.modal.show {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.modal.hide {},
              onSuccess: ->
                visibilityChangeCount.should.equal 2
                done()
              onFailure: (error) ->
                done new Error "could not pop view: " + error.message
          , 500
        onFailure: (error) ->
          done new Error "could not push view: " + error.message
      }



    it "should log one and only one 'hidden' visibilitychange", (done) ->

      hiddenCount = 0

      document.addEventListener "visibilitychange", ->
        if document.visibilityState is "hidden"
          hiddenCount++

      steroids.modal.show {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.modal.hide {},
              onSuccess: ->
                hiddenCount.should.equal 1
                done()
              onFailure: (error) ->
                done new Error "could not pop view: " + error.message
          , 500
        onFailure: (error) ->
          done new Error "could not push view: " + error.message
      }



    it "should log one 'visible' visibilitychange", (done) ->
      visibleCount = 0

      document.addEventListener "visibilitychange", ->
        if document.visibilityState is "visible"
          visibleCount++

      steroids.modal.show {
        view: googleView
      }, {
        onSuccess: ->
          setTimeout ->
            steroids.modal.hide {},
              onSuccess: ->
                visibleCount.should.equal 1
                done()
              onFailure: (error) ->
                done new Error "could not pop view: " + error.message
          , 500
        onFailure: (error) ->
          done new Error "could not push view: " + error.message
      }

