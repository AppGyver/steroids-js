# App description
class App extends NativeObject

  # ### Steroids.app.path
  #
  # Application path relative to OS application directory
  # Readable after Steroids ready event
  #
  # #### Example:
  #
  # Steroids.app.path == "applications/local/123456789/"
  #
  path: undefined

  # ### Steroids.app.absolutePath
  #
  # Application path as an absolute path from device root.
  # Readable after Steroids ready event
  #
  # #### Example:
  #
  # Steroids.app.absolutePath == "/var/mobile/Applications/AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA/Scanner.app/Documents/applications/local/123456789/"
  #
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
