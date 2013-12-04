class Analytics

  constructor: ->

  track: (options={}, callbacks={}) ->

    event = if options.constructor.name == "String"
      options
    else
      options.event

    steroids.nativeBridge.nativeCall
      method: "recordEvent"
      parameters:
        type: "custom"
        attributes: event
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]


