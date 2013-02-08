class window.AnalyticsController

  @testRecordEvent: () ->

    steroids.device.ping {
      event: {
        hello: "world"
      }
    }, {
      onSuccess: () -> alert "recorded"
    }

