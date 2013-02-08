class Screen extends NativeObject
  freeze: (options={}, callbacks={})->
    @nativeCall
      method: "freeze"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  unfreeze: (options={}, callbacks={})->
    @nativeCall
      method: "unfreeze"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  capture: (options={}, callbacks={})->
    @nativeCall
      method: "takeScreenshot"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
