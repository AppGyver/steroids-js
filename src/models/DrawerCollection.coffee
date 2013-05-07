class DrawerCollection

  constructor: ->
    @defaultAnimations = {
      LEFT: new Animation({
        transition: "slideFromLeft"
        duration: 0.2
      })
      RIGHT: new Animation("slideFromRight")
      TOP: new Animation("slideFromTop")
      BOTTOM: new Animation("slideFromBottom")
    }

    @defaultWidth = Math.floor(75/100 * window.screen.width)

  takeParamsFromAnimation: (animation, parameters) ->
    parameters.pushAnimation = animation.transition
    parameters.pushAnimationDuration = animation.duration
    parameters.popAnimation = animation.reversedTransition
    parameters.popAnimationDuration = animation.reversedDuration

    parameters.pushAnimationCurve = animation.curve
    parameters.popAnimationCurve = animation.reversedCurve

  hide: (options={}, callbacks={}) ->
    steroids.debug "steroids.drawers.hide called"

    parameters = { edge: "left" }

    if options.animation?
      steroids.debug "steroids.drawers.show using custom animation"
      @takeParamsFromAnimation(options.animation, parameters)
    else
      steroids.debug "steroids.drawers.show using default animation"
      @takeParamsFromAnimation(window.steroids.drawers.defaultAnimations.LEFT, parameters)

    steroids.nativeBridge.nativeCall
      method: "closeDrawer"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  hideAll: (options={}, callbacks={}) ->
    @hide(options, callbacks)

  show: (options={}, callbacks={}) ->
    steroids.debug "steroids.drawers.show called"

    view = if options.constructor.name == "WebView"
      steroids.debug "steroids.drawers.show using view shorthand"
      options
    else
      steroids.debug "steroids.drawers.show using longhand"
      options.view

    parameters = { edge: "left" }

    if view.id?
      steroids.debug "steroids.drawers.show using preloaded view"
      parameters.id = view.id
    else
      steroids.debug "steroids.drawers.show using new view"
      parameters.url = view.location

    if options.keepLoading == true
      steroids.debug "steroids.drawers.show using keepLoading"
      parameters.keepTransitionHelper = true

    if options.animation?
      steroids.debug "steroids.drawers.show using custom animation"
      @takeParamsFromAnimation(options.animation, parameters)
    else
      steroids.debug "steroids.drawers.show using default animation"
      @takeParamsFromAnimation(@defaultAnimations.LEFT, parameters)

    if options.widthOfDrawerInPixels?
      steroids.debug "steroids.drawers.show using custom width of drawer to determine cutoff point"
      parameters.widthOfDrawerInPixels = options.widthOfDrawerInPixels
    else
      steroids.debug "steroids.drawers.show using default width of drawer to determine cutoff point"
      parameters.widthOfDrawerInPixels = @defaultWidth

    if options.widthOfLayerInPixels?
      steroids.debug "steroids.drawers.show using custom width of layer to determine cutoff point"
      parameters.widthOfLayerInPixels = options.widthOfLayerInPixels

    if options.edge?
      steroids.debug "steroids.drawers.show using custom edge to show drawer from"
      parameters.edge = options.edge
    else
      steroids.debug "steroids.drawers.show using default edge to show drawer from"
      parameters.edge = steroids.screen.edges.LEFT

    steroids.nativeBridge.nativeCall
      method: "openDrawer"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  enableGesture: (options={}, callbacks={}) ->
    steroids.debug "steroids.drawers.enableGesture called"

    view = if options.constructor.name == "WebView"
      steroids.debug "steroids.drawers.enableGesture using view shorthand"
      options
    else
      steroids.debug "steroids.drawers.enableGesture using longhand"
      options.view

    parameters = { edge: "left" }

    if view.id?
      steroids.debug "steroids.drawers.enableGesture using preloaded view"
      parameters.id = view.id
    else
      steroids.debug "steroids.drawers.enableGesture using new view"
      parameters.url = view.location

    if options.keepLoading == true
      steroids.debug "steroids.drawers.enableGesture using keepLoading"
      parameters.keepTransitionHelper = true

    if options.widthOfDrawerInPixels?
      steroids.debug "steroids.drawers.enableGesture using custom width of drawer to determine cutoff point"
      parameters.widthOfDrawerInPixels = options.widthOfDrawerInPixels
    else
      steroids.debug "steroids.drawers.enableGesture using default width of drawer to determine cutoff point"
      parameters.widthOfDrawerInPixels = @defaultWidth

    if options.widthOfLayerInPixels?
      steroids.debug "steroids.drawers.enableGesture using custom width of layer to determine cutoff point"
      parameters.widthOfLayerInPixels = options.widthOfLayerInPixels

    if options.edge?
      steroids.debug "steroids.drawers.enableGesture using custom edge to show drawer from"
      parameters.edge = options.edge
    else
      steroids.debug "steroids.drawers.enableGesture using default edge to show drawer from"
      parameters.edge = steroids.screen.edges.LEFT

    steroids.nativeBridge.nativeCall
      method: "enableDrawerGesture"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  disableGesture: (options={}, callbacks={}) ->
    steroids.debug "steroids.drawers.disableGesture called"

    steroids.nativeBridge.nativeCall
      method: "disableDrawerGesture"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
