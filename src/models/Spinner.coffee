class Spinner

  show: (options={}, callbacks={}) ->
    steroids.nativeBridge.nativeCall
      method: "showSpinner"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  hide: (options={}, callbacks={}) ->
    steroids.nativeBridge.nativeCall
      method: "hideSpinner"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
