class DrawerCollection extends EventsSupport

  constructor: ->
    #setup the events support
    super "drawer", ["willshow", "didshow", "willclose", "didclose"]

    @defaultAnimations = {
      SLIDE: new Animation({
        transition: "slide"
        duration: 0.8
      })
      SLIDE_AND_SCALE: new Animation({
        transition: "slideAndScale"
        duration: 0.8
      })
      SWINGING_DOOR: new Animation({
        transition: "swingingDoor"
        duration: 0.8
      })
      PARALLAX: new Animation({
        transition: "parallax"
        duration: 0.8
        parallaxFactor: 2.0
      })
    }

  enable: (options={}, callbacks={}) ->
    parameters = {}
    parameters.side = options.side

    steroids.nativeBridge.nativeCall
      method: "enableDrawer"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  disable: (options={}, callbacks={}) ->
    parameters = {}
    parameters.side = options.side

    steroids.nativeBridge.nativeCall
      method: "disableDrawer"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  hide: (options={}, callbacks={}) ->
    steroids.debug "steroids.drawers.hide called"

    parameters = {
      center:{}
      fullChange: false
    }

    # false -> close the drawer from where the drawer is.
    # true -> fully extend the drawer before closing it. This allows the center view to be changed while it is hidden.
    if options.fullChange?
      parameters.fullChange = options.fullChange

    # when center is defined, force fullChange:true
    if options.center?
      parameters.fullChange = true
      DrawerCollection.applyViewOptions options.center, parameters.center

    steroids.nativeBridge.nativeCall
      method: "closeDrawer"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  show: (options={}, callbacks={}) ->
    steroids.debug "steroids.drawers.show called"

    parameters =
      edge: options.edge || steroids.screen.edges.LEFT

    steroids.nativeBridge.nativeCall
      method: "openDrawer"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  update: (options={}, callbacks={}) ->
    steroids.debug "steroids.drawers.update called"

    parameters =
      left:{}
      right:{}
      options:{}

    validViews = true

    if options.left?
      if ! options.left.id? and options.left.location
        validViews = false
        if callbacks.onFailure?
          callbacks.onFailure "No identifier provided for the preloaded webview!"
      else
        DrawerCollection.applyViewOptions options.left, parameters.left

    if options.right?
      if ! options.right.id? and options.right.location
        validViews = false
        if callbacks.onFailure?
          callbacks.onFailure "No identifier provided for the preloaded webview!"
      else
        DrawerCollection.applyViewOptions options.right, parameters.right

    if options.options?
      DrawerCollection.applyDrawerSettings options.options, parameters.options

    if validViews
      steroids.nativeBridge.nativeCall
        method: "updateDrawer"
        parameters: parameters
        successCallbacks: [callbacks.onSuccess]
        failureCallbacks: [callbacks.onFailure]

  # DEPRECATED, legacy support only
  disableGesture: (options={}, callbacks={}) ->
    steroids.debug "steroids.drawers.disableGesture called"

    parameters =
      options:
        openGestures: ["None"]
        closeGestures: ["None"]

    steroids.nativeBridge.nativeCall
      method: "updateDrawer"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  # DEPRECATED, legacy support only
  enableGesture: (options={}, callbacks={}) ->
    steroids.debug "steroids.drawers.enableGesture called"

    parameters =
      left: {}
      right: {}
      options: {}

    # support shorthand of passing just WebView
    if options.constructor.name == "WebView"
      options =
        view: options

    if options.keepLoading?
      options.view.keepLoading = options.keepLoading

    if options.widthOfDrawerInPixels?
      options.view.widthOfDrawerInPixels = options.widthOfDrawerInPixels
    else if options.widthOfLayerInPixels?
      parameters.options.widthOfLayerInPixels = options.widthOfLayerInPixels

    edge = options.edge || steroids.screen.edges.LEFT

    if edge is steroids.screen.edges.RIGHT
      DrawerCollection.applyViewOptions options.view, parameters.right
    else # default to left edge
      DrawerCollection.applyViewOptions options.view, parameters.left

    parameters.options.openGestures = ["PanNavBar", "PanCenterView"]
    parameters.options.closeGestures = ["PanNavBar", "PanCenterView", "TapNavBar", "TapCenterView", "PanDrawerView"]

    steroids.nativeBridge.nativeCall
      method: "updateDrawer"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  @applyViewOptions: (view={}, parameters={}) ->
    if view.id?
      parameters.id = view.id

    if view.location?
      parameters.url = view.location

    if view.keepLoading == true
      steroids.debug "steroids.drawers using keepLoading"
      parameters.keepTransitionHelper = true

    if view.widthOfDrawerInPixels?
      steroids.debug "steroids.drawers using custom width of drawer to determine cutoff point"
      parameters.widthOfDrawerInPixels = view.widthOfDrawerInPixels

    parameters

  @applyDrawerSettings: (options={}, parameters={}) ->

    if options.showShadow?
      parameters.showShadow = options.showShadow

    # None -> Disable any gesture for open
    # PanNavBar -> open the drawer by panning the NavBar
    # PanCenterView -> open the drawer by panning anywhere in the center view
    # PanBezelCenterView -> open the drawer by panning starting from the edge (bezel). the distance from the bezel is 20 device pixels
    # Sample :
    # openGestures : ["PanNavBar", "PanCenterView", "PanBezelCenterView"]
    if options.openGestures?
      parameters.openGestures = options.openGestures

    # None -> Disable any gesture for close
    # PanNavBar -> close the drawer by panning the NavBar
    # PanCenterView -> close the drawer by panning anywhere in the center view
    # PanBezelCenterView -> close the drawer by panning starting from the edge (bezel). the distance from the bezel is 20 device pixels
    # TapNavBar -> closes the drawer then the user taps on the navbar of the center view
    # TapCenterView -> closes the drawer then the user taps anywhere on the center view
    # PanDrawerView -> close the drawer by panning the drawer view
    # Sample:
    # closeGestures : ["PanNavBar", "PanCenterView", "PanBezelCenterView", "TapNavBar", "TapCenterView", "PanDrawerView"]
    if options.closeGestures?
      parameters.closeGestures = options.closeGestures

    # By default, the side drawer will stretch if the user pans past the maximum drawer width. This gives a playful stretch effect.
    # You can disable this by setting stretchDrawer to false
    if options.stretchDrawer?
      parameters.stretchDrawer = options.stretchDrawer

    # None -> The user can not interact with any content in the center view.
    # Full -> The user can interact with all content in the center view.
    # NavBar -> The user can interact with only content on the navigation bar. The setting allows the menu button to still respond, allowing you to toggle the drawer closed when it is open.
    # Sample:
    # centerViewInteractionMode : "None"
    if options.centerViewInteractionMode?
      parameters.centerViewInteractionMode = options.centerViewInteractionMode

    if options.animation?
      steroids.debug "steroids.drawers.show using custom animation"
      parameters.animation = options.animation.transition
      parameters.animationDuration = options.animation.duration
      parameters.parallaxFactor = options.animation.parallaxFactor

    if options.widthOfLayerInPixels?
      steroids.debug "steroids.drawers using custom width of layer to determine cutoff point"
      parameters.widthOfLayerInPixels = options.widthOfLayerInPixels

    parameters
