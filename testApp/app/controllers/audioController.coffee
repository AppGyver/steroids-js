document.addEventListener "deviceready", ->
  appPath = ""

  Steroids.audio.prime()

  document.getElementById("playAudio").addEventListener "touchstart", ->
    Steroids.audio.play path: "audio/snare.wav"
