describe "visibilitychange", ->

  beforeEach (done) ->
    document.addEventListener "deviceready", ->
      setTimeout done, 500
      # to solve iOS issue of trying to push when previous push is still under way

  it "should log two visibilitychange events in this view", (done) ->
    visibilityChangeCount = 0
    wasHidden = false
    wasVisible = false

    document.addEventListener "visibilitychange", ->
      visibilityChangeCount++
      if document.visibilityState is "hidden"
        wasHidden = true
      if document.visibilityState is "visible"
        wasVisible = true

    googleView = new steroids.views.WebView "http://www.google.com"

    steroids.layers.push {
      view: googleView
    }, {
      onSuccess: ->
        setTimeout ->
          steroids.layers.pop {},
            onSuccess: ->
              visibilityChangeCount.should.equal 2
              wasHidden.should.be.true
              wasVisible.should.be.true
              done()
            onFailure: (error) ->
              done new Error "could not pop view: " + error.message
        , 500
      onFailure: (error) ->
        done new Error "could not push view: " + error.message
    }