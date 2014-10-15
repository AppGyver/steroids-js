trackEvent = (eventObject, done) ->
  steroids.analytics.track {
    eventObject
  }, {
    onSuccess: -> done()
  }

describe "analytics", ->
  describe "track", ->
    it "should be defined", ->
      steroids.analytics.track.should.be.defined

    it "should track an event", (done) ->
      eventObject =
        event:
          hello: "world"

      trackEvent eventObject, done

    it "should track an event to custom event collection", (done) ->
      eventObject =
        event:
          hello: "world"
          appgyver_event_name: "customeventcollection"

      trackEvent eventObject, done
