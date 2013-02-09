class Analytics

  recordEvent: (options={}, callbacks={}) ->

    steroids.nativeBridge.nativeCall
      method: "recordEvent"
      parameters:
        type: "custom"
        attributes: options.event
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

