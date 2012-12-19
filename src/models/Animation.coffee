class Animation extends NativeObject
  start: (options, callbacks={})->
    @nativeCall
      method: "performTransition"
      parameters: {
        transition: options.name
        curve: options.curve||"easeInOut"
        duration: options.duration||0.7
      }
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
