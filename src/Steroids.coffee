class Steroids
  constructor: ->
    @debug "Steroids loaded"
  # Public NavigationBar class
  @NavigationBar: NavigationBar
  # Public Layer class
  @Layer: Layer
  @layers: new LayerCollection

  # Public Modal class
  @Modal: new Modal

  # Public singleton of Audio class
  @Audio: new Audio

  # Public singleton of Animation class
  @Animation: new Animation

  # Public Tab class
  @Tab: Tab

  # Current version
  @version: "0.0.1"

  # current screen Navigation Bar
  @navigationBar: new NavigationBar

  # Application instance
  @app: new App

  # Device instance
  @device: new Device

  # Debugging boolean
  debugBoolean: false

  # Debug function
  debug: (msg)->
    console.log msg if @debugBoolean