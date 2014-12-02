describe "View", ->

  it "should be defined", ->
    steroids.view.should.be.defined

  it "should track WebView created events", (done)->

    @timeout 3000

    created = 0

    steroids.view.on "created", ->
      created++

    lulView = new steroids.views.WebView {location: "http://www.google.com", id:"eventTest"}

    steroids.layers.push {
      view: "eventTest"
    }, {
      onSuccess: ->
        setTimeout ->
          steroids.layers.pop {},
            onSuccess: ->
              created.should.equal 1
              done()
            onFailure: (error) ->
              done new Error "could not pop layer:" + error
        , 500
      onFailure: (error) ->
        done new Error "could not push layer: " + error.errorDescription
    }


  it "should track WebView preloaded & unloaded events", (done)->
    preloaded = 0
    unloaded = 0

    steroids.view.on "preloaded", ->
      preloaded++

    steroids.view.on "unloaded", ->
      unloaded++

    testView = new steroids.views.WebView {location: "http://www.google.com", id:"eventTrackerTest"}

    testView.preload {},
      onSuccess: ->
        preloaded.should.equal 1, "preloaded event was not noticed"
        testView.unload {},
          onSuccess: ->
            unloaded.should.equal 1, "unloaded event was not noticed"
            done()
          onFailure: ->
            done new Error "could not unload view"
      onFailure: ->
        done new Error "could not preload view"


  it "should recognize a preloaded layer's visibilityState as 'prerender'", (done) ->
    yahooView = new steroids.views.WebView "http://www.yahoo.com"

    yahooView.preload {},
      onSuccess: ->
        (document.visibilityState).should.equal "prerender"
        done()
      onFailure: ->
        done new Error "could not preload view:" + error.errorDescription
