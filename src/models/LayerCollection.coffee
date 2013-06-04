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

  popAll: (options={}, callbacks={}) ->

    steroids.nativeBridge.nativeCall
      method: "popAllLayers"
      successCallbacks: [callbacks.onSuccess]
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

      parameters.pushAnimationCurve = options.animation.curve
      parameters.popAnimationCurve = options.animation.reversedCurve


    steroids.nativeBridge.nativeCall
      method: "openLayer"
      parameters: parameters
      successCallbacks: [defaultOnSuccess, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  replace: (options={}, callbacks={})->
    steroids.debug "steroids.layers.replace called"

    defaultOnSuccess = ()=>
      steroids.debug "steroids.layers.replace defaultOnSuccess"
      @array = [view]

    view = if options.constructor.name == "WebView"
      steroids.debug "steroids.layers.replace using view shorthand"
      options
    else
      steroids.debug "steroids.layers.replace using longhand"
      options.view

    parameters = {}

    if view.id?
      steroids.debug "steroids.layers.replace using preloaded view"
      parameters.id = view.id
    else
      steroids.debug "steroids.layers.replace using new view"
      parameters.url = view.location

    steroids.nativeBridge.nativeCall
      method: "replaceLayers"
      parameters: parameters
      successCallbacks: [defaultOnSuccess, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
