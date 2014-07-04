class WebView extends EventsSupport

  params: {}
  id: null
  location: null
  allowedRotations: null

  navigationBar: new NavigationBar

  constructor: (options={})->

    #setup the events support
    super "webview", ["created", "preloaded", "unloaded"]

    @location = if options.constructor.name == "String"
      options
    else
      options.location

    @id = if options.id?
      options.id

    if @location.indexOf("://") == -1 # if a path
      if window.location.href.indexOf("file://") == -1 # if not currently on file protocol
        @location = "#{window.location.protocol}//#{window.location.host}/#{@location}"

    @params = @getParams()

    # Sets the WebView to rotate to portait orientation only by default.
    # User can override this behavior by setting window.AG_allowedRotationsDefaults
    # before loading Steroids.js.

    allowedRotations = window.AG_allowedRotationsDefaults ? [0]
    @setAllowedRotations(allowedRotations)


  preload: (options={}, callbacks={}) ->
    steroids.debug "preload called for WebView #{JSON.stringify @}"

    proposedId = options.id || @id || @location

    setIdOnSuccess = () =>
      steroids.debug "preload success: setting id"
      @id = proposedId

    steroids.nativeBridge.nativeCall
      method: "preloadLayer"
      parameters:
        id: proposedId
        url: options.location || @location
      successCallbacks: [setIdOnSuccess, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  unload: (options={}, callbacks={}) ->
    steroids.debug "unload called for WebView #{JSON.stringify @}"

    if @id?
      steroids.nativeBridge.nativeCall
        method: "unloadLayer"
        parameters:
          id: @id
        successCallbacks: [callbacks.onSuccess]
        failureCallbacks: [callbacks.onFailure]
    else
      callbacks.onFailure?.call @, { errorDescription: "Cannot unload a WebView that is not preloaded" }

  getParams: ()->
    params = {}
    pairStrings = @location.slice(@location.indexOf('?') + 1).split('&')
    for pairString in pairStrings
      pair = pairString.split '='
      params[pair[0]] = pair[1]
    return params

  removeLoading: (options={}, callbacks={}) ->

    steroids.nativeBridge.nativeCall
      method: "removeTransitionHelper"
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  displayLoading: (options={}, callbacks={}) ->

    steroids.nativeBridge.nativeCall
      method: "displayTransitionHelper"
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  @mapDegreesToOrientations: (degrees) ->
    if degrees == 0 or degrees == "0"
      "portrait"
    else if degrees == 180 or degrees == "180"
      "portraitupsidedown"
    else if degrees == -90 or degrees == "-90"
      "landscapeleft"
    else if degrees == 90 or degrees == "90"
      "landscaperight"
    else
      return degrees

  # Deprecated. should use steroids.screen.setAllowedRotations() instead.
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
      WebView.mapDegreesToOrientations value

    steroids.nativeBridge.nativeCall
      method: "setAllowedOrientation"
      parameters: 
        allowedRotations: allowedRotations
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  # Deprecated. should use steroids.screen.rotate() instead.
  rotateTo: (options={}, callbacks={}) ->
    degrees = if options.constructor.name == "String" or options.constructor.name == "Number"
      options
    else
      options.degrees

    orientation = @mapDegreesToOrientations degrees

    steroids.nativeBridge.nativeCall
      method: "setOrientation"
      parameters:
        orientation: orientation
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  setBackgroundColor: (options={}, callbacks={}) ->
    newColor = if options.constructor.name == "String"
      options
    else
      options.color

    steroids.nativeBridge.nativeCall
      method: "setWebViewBackgroundColor"
      parameters:
        color: newColor
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  setBackgroundImage: (options={}, callbacks={}) ->
    newImage = if options.constructor.name == "String"
      options
    else
      options.image

    steroids.nativeBridge.nativeCall
      method: "setWebViewBackgroundImage"
      parameters:
        image: newImage
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  updateKeyboard: (options={}, callbacks={}) ->

    params = {}

    if options.accessoryBarEnabled?
      params.accessoryBarEnabled = options.accessoryBarEnabled

    steroids.nativeBridge.nativeCall
      method: "updateKeyboard"
      parameters: params
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
