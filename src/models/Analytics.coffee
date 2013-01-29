class Analytics extends NativeObject

  recordEvent: (opts={}, callbacks={}) ->
    @nativeCall
      method: "recordEvent"
      parameters:
        type: "custom"
        attributes: opts.attributes
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

