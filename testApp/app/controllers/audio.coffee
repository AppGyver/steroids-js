class window.AudioController
  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "audio" }

  @testPlay: ->
    steroids.audio.play {
      path: "clap.wav"
    }, {
      onSuccess: () -> alert "audio played"
      onFailure: () -> alert "audio play failed"
    }

  @testPrime: ->
    steroids.audio.prime {
    }, {
      onSuccess: () -> alert "audio primed"
      onFailure: () -> alert "audio prime failed"
    }

