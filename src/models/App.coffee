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

  getPath: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "getApplicationPath"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  getLaunchURL: (options={}, callbacks={}) ->
    return window.AG_STEROIDS_SCANNER_URL

  getMode: (options={}, callbacks={}) ->
    mode = if navigator.userAgent.match(/(StandAlonePackage)/)
      "standalone"
    else
      "scanner"

    callbacks.onSuccess(mode) if callbacks.onSuccess?