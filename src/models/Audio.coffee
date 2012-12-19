# Audio description
class Audio extends NativeObject
  # ###Steroids.Audio.play
  #
  #   Play an audio file from the file system
  #
  # ####Example:
  #     Steroids.Audio.play({
  play: (options, callbacks={})->
    @nativeCall
      method: "play"
      parameters: {
        filenameWithPath:  options.fullPath
      }
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  # ###Steroids.Audio.prime()
  #
  #   Preload the native audio framework to play sounds instantly
  #
  # ####Example:
  #     Steroids.audio.prime()
  prime: (options={}, callbacks={})->
    @nativeCall
      method: "primeAudioPlayer"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
