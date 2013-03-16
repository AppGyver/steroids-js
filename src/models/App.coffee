class App

  path: undefined
  userFilesPath: ""
  absolutePath: undefined

  constructor: ->
    @getPath {}, onSuccess: (params)=>
      @path = params.applicationPath
      @absolutePath = params.applicationFullPath
      steroids.markComponentReady("App")

  getPath: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "getApplicationPath"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  getLaunchURL: (options={}, callbacks={}) ->
    return window.AG_STEROIDS_SCANNER_URL