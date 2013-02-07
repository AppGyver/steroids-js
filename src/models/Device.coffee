class Device extends NativeObject

  ping: (options, callbacks={})->
    @nativeCall
      method: "ping"
      parameters:
        payload: options.data
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
