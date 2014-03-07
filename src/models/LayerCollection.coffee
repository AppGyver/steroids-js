class LayerCollection extends EventsSupport
  constructor: ->
    #setup the events support
    super "layer", ["willchange", "didchange"]

  pop: (options={}, callbacks={}) ->

    steroids.nativeBridge.nativeCall
      method: "popLayer"
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  popAll: (options={}, callbacks={}) ->

    steroids.nativeBridge.nativeCall
      method: "popAllLayers"
      successCallbacks: [callbacks.onSuccess, callbacks.onTransitionStarted]
      recurringCallbacks: [callbacks.onTransitionEnd]
      failureCallbacks: [callbacks.onFailure]


  push: (options={}, callbacks={}) ->
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

    if options.tabBar == false
      parameters.hidesTabBar = true

    if options.keepLoading == true
      parameters.keepTransitionHelper = true

    if options.animation?
      parameters.pushAnimation = options.animation.transition
      parameters.pushAnimationDuration = options.animation.duration
      parameters.popAnimation = options.animation.reversedTransition
      parameters.popAnimationDuration = options.animation.reversedDuration

      parameters.pushAnimationCurve = options.animation.curve
      parameters.popAnimationCurve = options.animation.reversedCurve

    switch view.constructor.name
      when "MapView"
        parameters.map = view
        steroids.nativeBridge.nativeCall
          method: "openMapLayer"
          parameters: parameters
          successCallbacks: [callbacks.onSuccess]
          failureCallbacks: [callbacks.onFailure]
      else
        steroids.nativeBridge.nativeCall
          method: "openLayer"
          parameters: parameters
          successCallbacks: [callbacks.onSuccess]
          failureCallbacks: [callbacks.onFailure]

  replace: (options={}, callbacks={}) ->
    steroids.debug "steroids.layers.replace called"

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
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
