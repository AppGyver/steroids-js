class Analytics

  constructor: ->

  track: (event={}, callbacks={}) ->

    steroids.nativeBridge.nativeCall
      method: "recordEvent"
      parameters:
        type: "custom"
        attributes: event
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]


