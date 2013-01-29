document.addEventListener "deviceready", ->

  document.getElementById("recordEvent").addEventListener "touchstart", ->

    Steroids.analytics.recordEvent
      event:
        hello: "world"
      {
        onSuccess: () ->
          alert "Great success"
        onFailure: () ->
          alert "Failure!"
      }
