class Screen extends EventsSupport

  constructor: ->
    #setup the events support
    super "screen", ["alertdidshow"]

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

  dismissAlert: (options={}, callbacks={}) ->
    steroids.nativeBridge.nativeCall
      method: "dismissAlert"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  @mapDegreesToOrientations: (degrees) ->
    if degrees == 0 or degrees == "0"
      "portrait"
    else if degrees == 180 or degrees == "180"
      "portraitUpsideDown"
    else if degrees == -90 or degrees == "-90"
      "landscapeLeft"
    else if degrees == 90 or degrees == "90"
      "landscapeRight"
    else
      return degrees

  setAllowedRotations: (options={}, callbacks={}) ->
    allowedRotations = if options.constructor.name == "Array"
      options
    else if options.constructor.name == "String"
      [options]
    else
      options.allowedRotations

    if not allowedRotations? or allowedRotations.length == 0
      allowedRotations = [0]

    #make sure we have orientation and not degrees
    allowedRotations = allowedRotations.map (value) ->
      Screen.mapDegreesToOrientations value

    steroids.nativeBridge.nativeCall
      method: "setAllowedOrientation"
      parameters:
        allowedRotations: allowedRotations
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

    params.orientation = Screen.mapDegreesToOrientations params.orientation

    steroids.nativeBridge.nativeCall
      method: "setOrientation"
      parameters: params
      successCallbacks: [callbacks.onSuccess, callbacks.onTransitionStarted]
      recurringCallbacks: [callbacks.onTransitionEnded]
      failureCallbacks: [callbacks.onFailure]
