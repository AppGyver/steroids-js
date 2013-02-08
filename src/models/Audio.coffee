
class Audio

  play: (options, callbacks={})->
    Steroids.on "ready", ()=>
      if options.absolutePath
        mediaPath = options.absolutePath
      else
        mediaPath = "#{Steroids.app.path}/#{options.path}"

      steroids.nativeBridge.nativeCall
        method: "play"
        parameters: {
          filenameWithPath: mediaPath
        }
        successCallbacks: [callbacks.onSuccess]
        failureCallbacks: [callbacks.onFailure]

  prime: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "primeAudioPlayer"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
