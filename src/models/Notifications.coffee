class Notifications


  post: (options={}, callbacks={}) ->
    message = if options.constructor.name == "String"
      options
    else
      options.message

    steroids.nativeBridge.nativeCall
      method: "postNotification"
      parameters: {
        body: message
      }
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]