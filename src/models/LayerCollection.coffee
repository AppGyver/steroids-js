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

    @nativeCall
      method: "openLayer"
      parameters:
        url: layer.location
      successCallbacks: [defaultOnSuccess, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
