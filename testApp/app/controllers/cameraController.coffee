document.addEventListener "deviceready", ->
  document.getElementById("toggleFlash").addEventListener "touchstart", ->
    Steroids.camera.flash.toggle()
