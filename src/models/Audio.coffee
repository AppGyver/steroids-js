
class Audio

  play: (options={}, callbacks={})->
    readyCapableDevice = false

    setTimeout =>
      return if readyCapableDevice

      navigator.notification.alert("Audio playback requires a newer version of Scanner, please update from the App Store.", null, "Update Required");
    , 500

    steroids.on "ready", ()=>
      readyCapableDevice = true

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
