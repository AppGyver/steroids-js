class Steroids
  @eventCallbacks: {}
  @waitingForComponents: []

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

  @markComponentReady: (model)->
    @waitingForComponents.splice @waitingForComponents.indexOf(model), 1
    if @waitingForComponents.length == 0
      @fireSteroidsEvent "ready"

window.Steroids = Steroids

# Communication endpoint to native API
# Native bridge is the communication layer from WebView to Native
# Valid values are subclasses of Bridge
window.Steroids.nativeBridge = Bridge.getBestNativeBridge()

# Current version
window.Steroids.version = "@@version"


# Public Layer class
window.Steroids.Layer = Layer

# Public Tab class
window.Steroids.Tab = Tab

# Public Animation singleton
#TODO: refactor into a class that is instantiated
window.Steroids.Animation = new Animation

# Public LayerCollection singleton
window.Steroids.layers = new LayerCollection

# Current Layer
window.Steroids.layer = new Layer { location: window.location.href }

# Public Modal singleton
window.Steroids.modal = new Modal

# Public Audio singleton
window.Steroids.audio = new Audio

# Public Camera singleton
window.Steroids.camera = new Camera

# Public NavigationBar singleton
window.Steroids.navigationBar = new NavigationBar

# Public App singleton
window.Steroids.waitingForComponents.push("App")
window.Steroids.app = new App

# Public Device singleton
window.Steroids.device = new Device

window.Steroids.OAuth = OAuth

window.Steroids.data = {}
window.Steroids.data.TouchDB = TouchDB

