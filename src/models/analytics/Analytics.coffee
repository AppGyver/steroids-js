class Analytics

  recordEvent: (opts={}, callbacks={}) ->
    steroids.nativeBridge.nativeCall
      method: "recordEvent"
      parameters:
        type: "custom"
        attributes: opts.event
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

