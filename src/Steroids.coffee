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

  # Public singleton of Camera class
  @Camera: new Camera

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

  @eventCallbacks = {}

  @on: (event, callback)->
    if @["#{event}_has_fired"]?
      callback()
    else
      @eventCallbacks[event] ||= []
      @eventCallbacks[event].push(callback)


  @fireSteroidsEvent: (event)->
    @["#{event}_has_fired"] = new Date().getTime()

    if @eventCallbacks[event]?
      for callback in @eventCallbacks[event]
        callback()
        @eventCallbacks[event].splice @eventCallbacks[event].indexOf(callback), 1

  @waitingForComponents: [
    "App"
  ]

  @markComponentReady: (model)->
    @waitingForComponents.splice @waitingForComponents.indexOf(model), 1
    if @waitingForComponents.length == 0
      @fireSteroidsEvent "ready"


  # Debugging boolean
  debugBoolean: false

  # Debug function
  debug: (msg)->
    console.log msg if @debugBoolean
