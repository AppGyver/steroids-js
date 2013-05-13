class window.AnalyticsController

  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "analytics" }

  @testRecordEvent: () ->

    steroids.analytics.recordEvent {
      event: {
        hello: "world"
      }
    }, {
      onSuccess: () -> alert "recorded"
    }

