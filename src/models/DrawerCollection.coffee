class DrawerCollection

  constructor: ->
    @defaultAnimations = {
      LEFT: new Animation({
        transition: "slideFromLeft"
        duration: 0.2
      })
      RIGHT: new Animation("slideFromRight")
      # TOP: new Animation("slideFromTop")
      # BOTTOM: new Animation("slideFromBottom")
    }

    @defaultWidth = Math.floor(75/100 * window.screen.width)
    
    # QuickClose -> close the drawer from where the drawer is
    # FullChange -> fully extends the drawer before closing it
    @closeMode = "QuickClose" 
    
    @showShadow = false
    
    # PanNavBar -> open the drawer by panning the NavBar
    # PanCenterView -> open the drawer by panning anywhere in the center view
    # PanBezelCenterView -> open the drawer by panning starting from the edge (bezel). the distance from the bezel is defined by the property XXX
    @openGestures = ["PanNavBar", "PanCenterView", "PanBezelCenterView"]
    
    # PanNavBar -> close the drawer by panning the NavBar
    # PanCenterView -> close the drawer by panning anywhere in the center view
    # PanBezelCenterView -> close the drawer by panning starting from the edge (bezel). the distance from the bezel is defined by the property XXX
    # TapNavBar -> closes the drawer then the user taps on the navbar of the center view
    # TapCenterView -> closes the drawer then the user taps anywhere on the center view
    # PanDrawerView -> close the drawer by panning the drawer view
    @closeGestures = ["PanNavBar", "PanCenterView", "PanBezelCenterView", "TapNavBar", "TapCenterView", "PanDrawerView"]

    # at the end of the drawer open animation the drawer view can be streched to give a "elastic" effect.
    @strechDrawer = false

    # None -> The user can not interact with any content in the center view.
    # Full -> The user can interact with all content in the center view.
    # NavBar -> The user can interact with only content on the navigation bar. The setting allows the menu button to still respond, allowing you to toggle the drawer closed when it is open. This is the default setting.
    @centerViewInteractionMode = "None"

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
    
    @applyDrawerSettings options, parameters
    
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
    
    @applyDrawerSettings options, parameters
    
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
  
  # TODO: make it private.. ne need to expose in the object
  applyDrawerSettings: (options={}, parameters={}) ->
    if options.closeMode?
      parameters.closeMode = options.closeMode
    else
      parameters.closeMode = @closeMode
      
    if options.showShadow?
      parameters.showShadow = options.showShadow
    else
      parameters.showShadow = @showShadow
      
    if options.openGestures?
      parameters.openGestures = options.openGestures
    else
      parameters.openGestures = @openGestures
      
    if options.closeGestures?
      parameters.closeGestures = options.closeGestures
    else
      parameters.closeGestures = @closeGestures
      
    if options.strechDrawer?
      parameters.strechDrawer = options.strechDrawer
    else
      parameters.strechDrawer = @strechDrawer
    
    if options.centerViewInteractionMode?
      parameters.centerViewInteractionMode = options.centerViewInteractionMode
    else
      parameters.centerViewInteractionMode = @centerViewInteractionMode
    
    parameters 
