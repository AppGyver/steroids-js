class Torch

  turnOn: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "cameraFlashOn"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]


  turnOff: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "cameraFlashOff"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  toggle: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "cameraFlashToggle"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
