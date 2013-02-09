class OpenURL

  @open: (options={}, callbacks={}) ->
    url = if options.constructor.name == "String"
      options
    else
      options.url

    steroids.nativeBridge.nativeCall
      method: "openURL"
      parameters:
        url: url
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
