window.steroids =
  version: "@@version"

  # Child Classes
  Animation: Animation
  File: File

  views:
    WebView: WebView
    PreviewFileView: PreviewFileView

  buttons:
    NavigationBarButton: NavigationBarButton

  data:
    SQLiteDB: SQLiteDB
    TouchDB: TouchDB
    RSS: RSS
    OAuth2: OAuth2

  openURL: OpenURL.open

  eventCallbacks: {}
  waitingForComponents: []

  debugMessages: []
  debugEnabled: false

  getApplicationState: (options={}, callbacks={}) ->
    steroids.nativeBridge.nativeCall
        method: "getApplicationState"
        parameters: {}
        successCallbacks: [callbacks.onSuccess]
        failureCallbacks: [callbacks.onFailure]

  debug: (msg) ->
    return unless steroids.debugEnabled

    msgJSON = JSON.stringify(msg)

    red   = '\u001b[31m'
    blue  = '\u001b[34m'
    reset = '\u001b[0m'

    debugMessage = "[#{red}DEBUG#{reset}] - #{msgJSON} - #{blue} #{window.location.href}#{reset}"

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
      @debug "firign event #{event} callbacks"
      callbacks = @eventCallbacks[event].splice 0
      for callback in callbacks
        @debug "firing event #{event} callback"
        callback()

  resetSteroidsEvent: (event)->
    @debug "resettign event #{event}"
    @["#{event}_has_fired"] = undefined

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

# All compnents that perform async operations are here
window.steroids.waitingForComponents.push("App")
window.steroids.waitingForComponents.push("Events.focuslisteners")
window.steroids.waitingForComponents.push("Events.initialVisibility")


window.steroids.app = new App

Events.extend()

window.steroids.initialView = new InitialView

window.steroids.drawers = new DrawerCollection

window.steroids.layers = new LayerCollection

window.steroids.view = new steroids.views.WebView { location: window.location.href }

window.steroids.modal = new Modal

window.steroids.audio = new Audio

window.steroids.navigationBar = new NavigationBar

window.steroids.statusBar = new StatusBar

window.steroids.tabBar = new TabBar

# Public Device singleton
window.steroids.device = new Device

window.steroids.analytics = new Analytics

window.steroids.screen = new Screen

window.steroids.notifications = new Notifications

window.steroids.splashscreen = new Splashscreen

window.steroids.PostMessage = PostMessage
window.postMessage = PostMessage.postMessage

window.steroids.logger = new Logger
window.steroids.logger.queue.autoFlush(100)

window.addEventListener "error", (error, url, lineNumber) ->
  steroids.logger.log "#{error.message} - #{url}:#{lineNumber}"
