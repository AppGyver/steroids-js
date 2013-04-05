class App

  path: undefined
  userFilesPath: undefined

  absolutePath: undefined
  absoluteUserFilesPath: undefined

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
