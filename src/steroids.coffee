window.steroids =
  version: "@@version"

  # Child Classes
  OAuth2: OAuth2
  Animation: Animation
  XHR: XHR
  File: File
  views:
    WebView: WebView
    PreviewFileView: PreviewFileView
  buttons:
    NavigationBarButton: NavigationBarButton
  data:
    TouchDB: TouchDB

  eventCallbacks: {}
  waitingForComponents: []
  debugEnabled: false

  debug: (msg)->
    console.log msg if steroids.debugEnabled

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

window.steroids.waitingForComponents.push("App")
window.steroids.app = new App

window.steroids.waitingForComponents.push("Events")
Events.extend(document)

window.steroids.layers = new LayerCollection

window.steroids.view = new steroids.views.WebView { location: window.location.href }

window.steroids.modal = new Modal

window.steroids.audio = new Audio

window.steroids.navigationBar = new NavigationBar


window.steroids.waitingForComponents.push("App")
window.steroids.waitingForComponents.push("Events")


# Public App singleton
window.steroids.app = new App

Events.extend(document)

window.steroids.openURL = OpenURL.open

# Public Device singleton
window.steroids.device = new Device

window.steroids.analytics = new Analytics

window.steroids.screen = new Screen
