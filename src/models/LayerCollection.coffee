# LayerCollection description
class LayerCollection extends NativeObject
  constructor: ->
    super()
    @array = []

  pop: (options={}, callbacks={})->
    defaultOnSuccess = ()=>
      @array.pop()

    @nativeCall
      method: "popLayer"
      successCallbacks: [defaultOnSuccess, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]


  push: (options={}, callbacks={})->
    defaultOnSuccess = ()=>
      @array.push options.layer

    parameters = if options.layer.id?
      { id: options.layer.id }
    else
      { url: options.layer.location }

    if options.animation?
      parameters.pushAnimation = options.animation.transition
      parameters.pushAnimationDuration = options.animation.duration
      parameters.popAnimation = options.animation.reversedTransition
      parameters.popAnimationDuration = options.animation.reversedDuration

    @nativeCall
      method: "openLayer"
      parameters: parameters
      successCallbacks: [defaultOnSuccess, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
