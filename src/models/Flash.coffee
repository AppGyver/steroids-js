# Flash description
class Flash extends NativeObject
  # ### Steroids.camera.flash.toggle
  #
  # Toggles the flash torch either on or off.
  #
  # #### Example:
  #
  # Steroids.camera.flash.toggle({}, {onSuccess: function() {
  #   console.log("Flash toggled");
  # }});
  #
  toggle: (options={}, callbacks={})->
    @nativeCall
      method: "cameraFlashToggle"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
