class window.AnalyticsController

  @testRecordEvent: () ->

    steroids.analytics.recordEvent {
      event: {
        hello: "world"
      }
    }, {
      onSuccess: () -> alert "recorded"
    }

