class OpenURL

  @open: (options={}, callbacks={}) ->
    steroids.nativeBridge.nativeCall
      method: "openURL"
      parameters:
        url: options.url
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
