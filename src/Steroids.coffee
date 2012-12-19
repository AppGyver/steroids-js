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

  @Audio: new Audio

  # Public Tab class
  @Tab: Tab

  # Current version
  @version: "0.0.1"

  # User interface instances
  @UI:
    # current layer navigation bar
    navigationBar: new NavigationBar

  # Application instance
  @app: new App

  # Device instance
  @device: new Device

  # Debugging boolean
  debugBoolean: false

  # Debug function
  debug: (msg)->
    console.log msg if @debugBoolean