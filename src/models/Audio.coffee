
class Audio

  play: (options={}, callbacks={})->

    steroids.on "ready", ()=>
      relativeTo = options.relativeTo ? steroids.app.path

      mediaPath = if options.constructor.name == "String"
        "#{relativeTo}/#{options}"
      else
        "#{relativeTo}/#{options.path}"

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
