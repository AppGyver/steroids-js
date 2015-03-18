class App

  path: undefined
  userFilesPath: undefined

  absolutePath: undefined
  absoluteUserFilesPath: undefined

  host:
    getURL:(options={}, callbacks={}) ->

      betterResponseCb = (hostObj) ->
        actualURL = "http://#{hostObj.endpointURL}"

        aElem = document.createElement("a")
        aElem.href = actualURL

        callbacks.onSuccess(aElem.origin)

      steroids.nativeBridge.nativeCall
        method: "getEndpointURL"
        parameters: {}
        successCallbacks: [betterResponseCb]
        failureCallbacks: [callbacks.onFailure]

  constructor: ->
    @getPath {}, onSuccess: (params)=>
      @path = params.applicationPath
      @userFilesPath = params.userFilesPath

      @absolutePath = params.applicationFullPath
      @absoluteUserFilesPath = params.userFilesFullPath

      steroids.markComponentReady("App")

  loadTheme: (options={}, callbacks={})->
    theme = if options.constructor.name == "String"
      options
    else
      options.theme

    steroids.nativeBridge.nativeCall
      method: "loadStyleTheme"
      parameters:
        theme: theme
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  getPath: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "getApplicationPath"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  getLaunchURL: (options={}, callbacks={}) ->
    return window.AG_STEROIDS_SCANNER_URL

  getLaunchURI: (options={}, callbacks={}) ->
    extractStringFromUriJson = (uriJson) ->
      callbacks.onSuccess uriJson.uri

    steroids.nativeBridge.nativeCall
      method: "getLaunchUri"
      parameters: {}
      successCallbacks: [extractStringFromUriJson]
      failureCallbacks: [callbacks.onFailure]

  getMode: (options={}, callbacks={}) ->
    mode = if navigator.userAgent.match(/(StandAlonePackage)/)
      "standalone"
    else
      "scanner"

    callbacks.onSuccess(mode) if callbacks.onSuccess?

  getNSUserDefaults: (options={}, callbacks={}) ->
    steroids.nativeBridge.nativeCall
      method: "getNSUserDefaults"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
