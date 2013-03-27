class BounceShadow
  hide: (options={}, callbacks={}) ->
    @setVisibility({ visibility: false }, callbacks)

  show: (options={}, callbacks={}) ->
    @setVisibility({ visibility: true }, callbacks)

  setVisibility: (options={}, callbacks={}) ->
    visibility = if options.constructor.name == "String"
      options
    else
      options.visibility

    steroids.nativeBridge.nativeCall
      method: "setWebViewBounceShadowVisibility"
      parameters:
        visibility: visibility
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
