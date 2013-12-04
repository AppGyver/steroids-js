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
      onSuccess: () -> alert "recorded"
    }

