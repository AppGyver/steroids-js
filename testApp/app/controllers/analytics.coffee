class window.AnalyticsController

  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "analytics" }

  @testTrack: () ->

    steroids.analytics.track {
      event: {
        hello: "world"
      }
    }, {
      onSuccess: () -> steroids.logger.log "SUCCESS in tracking event"
      onFailure: () -> steroids.logger.log "FAILURE in testTrack"
    }


  @testTrackCustomEventCollection: () ->

    steroids.analytics.track {
      event: {
        hello: "world"
        appgyver_event_name: "customeventcollection"
      }
    }, {
      onSuccess: () -> steroids.logger.log "SUCCESS in tracking event to custom event collection"
      onFailure: () -> steroids.logger.log "FAILURE in testTrackCustomEventCollection"
    }

