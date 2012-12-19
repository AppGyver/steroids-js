document.addEventListener "deviceready", ->
  appPath = ""

  Steroids.app.path {},
    onSuccess: (parameters)=>
      alert "SetPath: #{parameters.applicationPath}"
      appPath = parameters.applicationPath

    onFailure: ->
      throw "Could not resolve app path for Audio component"

  document.getElementById("playAudio").addEventListener "touchstart", ->
    Steroids.Audio.play "#{appPath}/audio/snare.wav"