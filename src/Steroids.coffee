window.steroids =
  eventCallbacks: {}
  waitingForComponents: []

  on: (event, callback)->
    if @["#{event}_has_fired"]?
      callback()
    else
      @eventCallbacks[event] ||= []
      @eventCallbacks[event].push(callback)


  fireSteroidsEvent: (event)->
    @["#{event}_has_fired"] = new Date().getTime()

    if @eventCallbacks[event]?
      for callback in @eventCallbacks[event]
        callback()
        @eventCallbacks[event].splice @eventCallbacks[event].indexOf(callback), 1

  markComponentReady: (model)->
    @waitingForComponents.splice @waitingForComponents.indexOf(model), 1
    if @waitingForComponents.length == 0
      @fireSteroidsEvent "ready"


# Communication endpoint to native API
# Native bridge is the communication layer from WebView to Native
# Valid values are subclasses of Bridge
window.steroids.nativeBridge = Bridge.getBestNativeBridge()

# Current version
window.steroids.version = "@@version"

# Public Layer class
window.steroids.Layer = Layer

# Public Tab class
window.steroids.Tab = Tab

# Public OAuth2 class
window.steroids.OAuth2 = OAuth2

# Public Animation singleton

window.steroids.Animation = new Animation  # to be deprecated, not documented
window.steroids.animation = window.steroids.Animation

# Public LayerCollection singleton
window.steroids.layers = new LayerCollection

# Current Layer
window.steroids.layer = new Layer { location: window.location.href }

# Public Modal singleton
window.steroids.modal = new Modal

# Public Audio singleton
window.steroids.audio = new Audio

# Public Camera singleton
window.steroids.camera = new Camera

# Public NavigationBar singleton
window.steroids.navigationBar = new NavigationBar

# Public App singleton
window.steroids.waitingForComponents.push("App")
window.steroids.app = new App

# Public Device singleton
window.steroids.device = new Device

window.steroids.data = {}
window.steroids.data.TouchDB = TouchDB

window.steroids.XHR = XHR

window.steroids.analytics = new Analytics
