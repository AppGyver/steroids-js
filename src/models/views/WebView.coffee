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
    @setAllowedRotations([0])


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

  setAllowedRotations: (options={}, callbacks={}) ->
    @allowedRotations = if options.constructor.name == "Array"
      options
    else
      options.allowedRotations

    window.shouldRotateToOrientation = (orientation) =>
      return if orientation in @allowedRotations
        true
      else
        false

    callbacks.onSuccess?.call()

  rotateTo: (options={}, callbacks={}) ->
    degrees = if options.constructor.name == "String"
      options
    else
      options.degrees

    steroids.nativeBridge.nativeCall
      method: "rotateTo"
      parameters:
        orientation: degrees
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
