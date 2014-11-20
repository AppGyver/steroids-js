describe "View", ->

  it "should be defined", ->
    steroids.view.should.be.defined

  it "should track WebView created events", (done)->

    created = 0

    steroids.view.on "created", ->
      created++

    testView = new steroids.views.WebView {location: "http://www.google.com", id:"eventTrackerTest"}

    created.should.equal 1
    done()


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

