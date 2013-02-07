class App extends NativeObject

  path: undefined

  absolutePath: undefined

  constructor: ->
    super()
    @getPath {}, onSuccess: (params)=>
      @path = params.applicationPath
      @absolutePath = params.applicationFullPath
      Steroids.markComponentReady("App")

  getPath: (options, callbacks)->
    @nativeCall
      method: "getApplicationPath"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
