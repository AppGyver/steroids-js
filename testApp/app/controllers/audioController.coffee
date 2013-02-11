class window.AudioController

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

