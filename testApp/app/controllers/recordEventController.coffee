document.addEventListener "deviceready", ->

  document.getElementById("recordEvent").addEventListener "touchstart", ->

    Steroids.analytics.recordEvent
      event:
        keenio: true
        hello: "world"
      {
        onSuccess: () ->
          alert "Great success"
        onFailure: () ->
          alert "Failure!"
      }
