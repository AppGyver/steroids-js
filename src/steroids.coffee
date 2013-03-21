window.steroids =
  version: "@@version"

  # Child Classes
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
    OAuth2: OAuth2

  eventCallbacks: {}
  waitingForComponents: []

  debugMessages: []
  debugEnabled: true

  debug: (options={}) ->
    return unless steroids.debugEnabled

    msg = if options.constructor.name == "String"
      options
    else
      options.msg

    debugMessage = "#{window.location.href} - #{msg}"

    window.steroids.debugMessages.push debugMessage
    console.log debugMessage

  on: (event, callback)->
    @debug "on event #{event}"
    if @["#{event}_has_fired"]?
      @debug "on event #{event}, alrueady fierd"
      callback()
    else
      @debug "on event #{event}, waiting"
      @eventCallbacks[event] ||= []
      @eventCallbacks[event].push(callback)


  fireSteroidsEvent: (event)->
    @debug "firign event #{event}"
    @["#{event}_has_fired"] = new Date().getTime()

    if @eventCallbacks[event]?
      callbacks = @eventCallbacks[event].splice 0
      for callback in callbacks
        @debug "firing event callback"
        callback()

  markComponentReady: (model)->
    @debug "#{model} is ready"
    @waitingForComponents.splice @waitingForComponents.indexOf(model), 1
    if @waitingForComponents.length == 0
      @debug "steroids is ready"
      @fireSteroidsEvent "ready"

# Communication endpoint to native API
# Native bridge is the communication layer from WebView to Native
# Valid values are subclasses of Bridge
window.steroids.nativeBridge = Bridge.getBestNativeBridge()

window.steroids.waitingForComponents.push("App")
window.steroids.app = new App

window.steroids.waitingForComponents.push("Events.focuslisteners")
window.steroids.waitingForComponents.push("Events.initialVisibility")
Events.extend()

window.steroids.layers = new LayerCollection

window.steroids.view = new steroids.views.WebView { location: window.location.href }

window.steroids.modal = new Modal

window.steroids.audio = new Audio

window.steroids.navigationBar = new NavigationBar


window.steroids.openURL = OpenURL.open

# Public Device singleton
window.steroids.device = new Device

window.steroids.analytics = new Analytics

window.steroids.screen = new Screen

window.steroids.notifications = new Notifications
window.steroids.PostMessage = PostMessage

window.postMessage = PostMessage.postMessage