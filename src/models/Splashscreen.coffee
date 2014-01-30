
class Splashscreen

  show: (options={}, callbacks={})->
    @setVisibility(true, callbacks)

  hide: (options={}, callbacks={})->
    @setVisibility(false, callbacks)

  setVisibility: (visibility, callbacks) ->
    options =
      visible: visibility

    steroids.nativeBridge.nativeCall
      method: "setSplashScreenVisibility"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

