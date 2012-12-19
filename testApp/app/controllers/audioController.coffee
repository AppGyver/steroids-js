document.addEventListener "deviceready", ->
  appPath = ""

  Steroids.Audio.prime()

  Steroids.app.path {},
    onSuccess: (parameters)=>
      console.log "SetPath: #{parameters.applicationPath}"
      appPath = parameters.applicationPath

    onFailure: ->
      throw "Could not resolve app path for Audio component"

  document.getElementById("playAudio").addEventListener "touchstart", ->
    Steroids.Audio.play fullPath: "#{appPath}/audio/snare.wav"