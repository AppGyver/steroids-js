document.addEventListener "deviceready", ->
  appPath = ""

  Steroids.Audio.prime()

  document.getElementById("playAudio").addEventListener "touchstart", ->
    Steroids.Audio.play path: "audio/snare.wav"
