class Torch extends NativeObject

  turnOn: (options={}, callbacks={})->
    @nativeCall
      method: "cameraFlashOn"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]


  turnOff: (options={}, callbacks={})->
    @nativeCall
      method: "cameraFlashOff"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  toggle: (options={}, callbacks={})->
    @nativeCall
      method: "cameraFlashToggle"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
