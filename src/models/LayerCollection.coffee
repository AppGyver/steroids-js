class LayerCollection extends NativeObject
  constructor: ->
    @array = []

  pop: (callbacks={})->
    defaultOnSuccess = ()=>
      @array.pop()

    @nativeCall
      method: "popLayer"
      successCallbacks: [defaultOnSuccess, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
    @array.pop()

  push: (layer, callbacks={})->
    defaultOnSuccess = ()=>
      ()=>@array.push layer

    parameters =
      url: layer.location

    parameters.pushAnimation = layer.pushAnimation if layer.pushAnimation?
    parameters.pushAnimationDuration = layer.pushAnimationDuration if layer.pushAnimationDuration?
    parameters.popAnimation = layer.popAnimation if layer.popAnimation?
    parameters.popAnimationDuration = layer.popAnimationDuration if layer.popAnimationDuration?

    @nativeCall
      method: "openLayer"
      parameters: parameters
      successCallbacks: [defaultOnSuccess, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
