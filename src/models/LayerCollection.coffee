class LayerCollection
  constructor: ->
    @array = []

  pop: (options={}, callbacks={})->
    defaultOnSuccess = ()=>
      @array.pop()

    steroids.nativeBridge.nativeCall
      method: "popLayer"
      successCallbacks: [defaultOnSuccess, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]


  push: (options={}, callbacks={})->
    defaultOnSuccess = ()=>
      @array.push view

    view = if options.constructor.name == "WebView"
      options
    else
      options.view

    parameters = if view.id?
      { id: view.id }
    else
      { url: view.location }

    if options.navigationBar == false
      parameters.hidesNavigationBar = true

    if options.keepLoading == true
      parameters.keepTransitionHelper = true

    if options.animation?
      parameters.pushAnimation = options.animation.transition
      parameters.pushAnimationDuration = options.animation.duration
      parameters.popAnimation = options.animation.reversedTransition
      parameters.popAnimationDuration = options.animation.reversedDuration

    steroids.nativeBridge.nativeCall
      method: "openLayer"
      parameters: parameters
      successCallbacks: [defaultOnSuccess, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
