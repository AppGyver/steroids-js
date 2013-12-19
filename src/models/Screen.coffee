class Screen
  edges:
    LEFT: "left"
    RIGHT: "right"
    TOP: "top"
    BOTTOM: "bottom"

  freeze: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "freeze"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  unfreeze: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "unfreeze"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  capture: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "takeScreenshot"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  tap: (options={}, callbacks={}) ->
    steroids.nativeBridge.nativeCall
      method: "sendTouchEvent"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
