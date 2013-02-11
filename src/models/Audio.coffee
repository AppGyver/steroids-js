
class Audio

  play: (options, callbacks={})->

    steroids.on "ready", ()=>

      mediaPath = if options.constructor.name == "String"
        "#{steroids.app.path}/#{options}"
      else
        options.absolutePath ? "#{steroids.app.path}/#{options.path}"

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
