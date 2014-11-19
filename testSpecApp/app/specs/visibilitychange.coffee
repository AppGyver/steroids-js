describe "visibilitychange", ->

  beforeEach (done) ->
    document.addEventListener "deviceready", ->
      setTimeout done, 750
      # to solve iOS issue of trying to push when previous push is still under way

  it "should log two visibilitychange events for this view", (done) ->
    visibilityChangeCount = 0

    document.addEventListener "visibilitychange", ->
      visibilityChangeCount++

    googleView = new steroids.views.WebView "http://www.google.com"

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

  it "should log one and only one 'hidden' visibilitychange for this view", (done) ->

    hiddenCount = 0

    document.addEventListener "visibilitychange", ->
      if document.visibilityState is "hidden"
        hiddenCount++

    googleView = new steroids.views.WebView "http://www.google.com"

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



  it "should log one 'visible' visibilitychange for this view", (done) ->
    visibleCount = 0

    document.addEventListener "visibilitychange", ->
      if document.visibilityState is "visible"
        visibleCount++

    googleView = new steroids.views.WebView "http://www.google.com"

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
