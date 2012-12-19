document.addEventListener "deviceready", ->
  document.getElementById("toggleFlash").addEventListener "touchstart", ->
    Steroids.Camera.flash.toggle()
