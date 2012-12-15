# App description
class App extends NativeObject
  # ###Steroids.app.path
  #
  #   Get application path from native
  #
  # ####Example:
  #     Steroids.app.path {},
  #      onSuccess: (parameters) ->
  #        /^\/var/.test(parameters.applicationFullPath)
  #        /^applications/.test(parameters.applicationPath)
  #        return
  #
  path: (options, callbacks)->
    @nativeCall
      method: "getApplicationPath"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]