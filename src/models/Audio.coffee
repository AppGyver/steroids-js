
class Audio

  play: (options, callbacks={})->
    mediaPath = if options.constructor.name == "String"
      options
    else
      options.absolutePath ? "#{Steroids.app.path}/#{options.path}"

    Steroids.on "ready", ()=>
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
