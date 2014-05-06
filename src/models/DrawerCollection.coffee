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

  hide: (options={}, callbacks={}) ->
    steroids.debug "steroids.drawers.hide called"

    parameters = {
      center:{}
      fullChange: false
    }

    # false -> close the drawer from where the drawer is
    # true -> fully extends the drawer before closing it .. that allows for the center view to be changed
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

    parameters = {
      edge: steroids.screen.edges.LEFT
      left:{}
      right:{}
      options:{}
    }

    if options.left?
      DrawerCollection.applyViewOptions options.left, parameters.left

    if options.right?
      DrawerCollection.applyViewOptions options.right, parameters.right

    if options.options?
      DrawerCollection.applyDrawerSettings options.options, parameters.options

    if options.edge?
      parameters.edge = options.edge

    steroids.nativeBridge.nativeCall
      method: "openDrawer"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  update: (options={}, callbacks={}) ->
    steroids.debug "steroids.drawers.update called"

    parameters = {
      left:{}
      right:{}
      options:{}
    }

    if options.left?
      DrawerCollection.applyViewOptions options.left, parameters.left

    if options.right?
      DrawerCollection.applyViewOptions options.right, parameters.right

    if options.options?
      DrawerCollection.applyDrawerSettings options.options, parameters.options

    steroids.nativeBridge.nativeCall
      method: "updateDrawer"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

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

  @applyViewOptions: (view={}, parameters={}) ->
    if view.id?
      parameters.id = view.id
    else
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
    # You can disable this by setting strechDrawer to false
    if options.strechDrawer?
      parameters.strechDrawer = options.strechDrawer

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
