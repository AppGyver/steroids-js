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

  #orientation:
  #  portrait
  #  portraitUpsideDown
  #  landscapeLeft
  #  landscapeRight
  rotate: (options={}, callbacks={}) ->

    params = {}

    params.orientation = if options.constructor.name == "String"
      options
    else
      if options.orientation?
        options.orientation
      else
        "portrait"

    steroids.nativeBridge.nativeCall
      method: "setOrientation"
      parameters: params
      successCallbacks: [callbacks.onSuccess, callbacks.onTransitionStarted]
      recurringCallbacks: [callbacks.onTransitionEnded]
      failureCallbacks: [callbacks.onFailure]


