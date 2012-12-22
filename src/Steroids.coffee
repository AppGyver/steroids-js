class Steroids
  # Current version
  @version: "0.0.1"

  # Public Layer class
  @Layer: Layer

  # Public Tab class
  @Tab: Tab

  # Public Animation singleton
  #TODO: refactor into a class that is instantiated
  @Animation: new Animation

  # Public LayerCollection singleton
  @layers: new LayerCollection

  # Public Modal singleton
  @modal: new Modal

  # Public Audio singleton
  @audio: new Audio

  # Public Camera singleton
  @camera: new Camera

  # Public NavigationBar singleton
  @navigationBar: new NavigationBar

  # Public App singleton
  @app: new App

  # Public Device singleton
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

  # Debugging boolean to enable debug logging
  debugEnabled: false

  # Debug function
  debug: (msg)->
    console.log msg if @debugEnabled
