class Flash extends NativeObject
  toggle: (options={}, callbacks={})->
    @nativeCall
      method: "cameraFlashToggle"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
