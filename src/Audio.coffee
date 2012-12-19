class Audio extends NativeObject
  play: (options, callbacks={})->
    @nativeCall
      method: "play"
      parameters: {
        filenameWithPath:  options.fullPath
      }
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]