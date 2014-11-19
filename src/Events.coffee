class Events

  @dispatchVisibilitychangedEvent: (options={}) =>
    steroids.debug
      msg: "dispatched visibilitychanged"

    visibilityChangeCustomEvent = document.createEvent "CustomEvent"
    visibilityChangeCustomEvent.initCustomEvent "visibilitychange", true, true

    document.dispatchEvent visibilityChangeCustomEvent

  @overrideVisibilityProperties: =>
    if document.__defineGetter__
      delete document.visibilityState
      delete document.hidden

      document.__visibilityState_internal = ""
      document.__hidden_internal = false

      document.__defineGetter__ "visibilityState", ->
        return document.__visibilityState_internal

      document.__defineSetter__ "visibilityState", (val) ->
        document.__visibilityState_internal = val

      document.__defineGetter__ "hidden", ->
        return document.__hidden_internal

      document.__defineSetter__ "hidden", (val) ->
        document.__hidden_internal = val

  @initializeVisibilityState: (options={}) =>
    steroids.debug
      msg: "set document.visibilityState to unloaded"

    @overrideVisibilityProperties()

    document.visibilityState = "unloaded"
    document.hidden = true

    document.addEventListener "DOMContentLoaded", () =>
      steroids.debug
        msg: "got DOMContentLoaded, setting document.visibilityState to prerender"

      document.visibilityState = "prerender"

  @checkInitialVisibility: (options={}, callbacks={}) =>
    setVisibilityStatus = (event) ->
      document.hidden = (event.currentVisibility == "hidden")
      document.visibilityState = event.currentVisibility

      steroids.markComponentReady "Events.initialVisibility"

    steroids.nativeBridge.nativeCall
      method: "getCurrentVisibility"
      successCallbacks: [setVisibilityStatus, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  @waitForWebViewUUID: (callback) ->
    checkWebViewUUID = () =>
      if window.AG_WEBVIEW_UUID
        callback()
      else
        setTimeout checkWebViewUUID, 100

    setTimeout checkWebViewUUID, 100

  #we need the window.AG_WEBVIEW_UUID before we call the addEventListener API
  @extend: (options={}, callbacks={}) ->
    @waitForWebViewUUID =>
      @setupEventHandlers options, callbacks

  @setupEventHandlers: (options={}, callbacks={}) ->
    # Mark initialVisibility and focuslisteners components always ready on iOS
    unless navigator.userAgent.match(/Android/i)
      steroids.markComponentReady("Events.initialVisibility")
      steroids.markComponentReady("Events.focuslisteners")
      return

    @initializeVisibilityState()
    @checkInitialVisibility()

    focusAdded = () =>
      steroids.debug
        msg: "focus added"

      event = "lostFocus"
      eventHandlerId = "#{event.toLowerCase()}_#{window.AG_WEBVIEW_UUID}"

      steroids.nativeBridge.nativeCall
        method: "addEventListener"
        parameters:
          event: event
          eventHandlerId: eventHandlerId
        successCallbacks: [lostFocusAdded, callbacks.onSuccess]
        recurringCallbacks: [becomeHiddenEvent]
        failureCallbacks: [callbacks.onFailure]

    lostFocusAdded = () =>
      steroids.debug
        msg: "lostfocus added"

      steroids.markComponentReady "Events.focuslisteners"

    becomeVisibleEvent = () =>
      steroids.debug
        msg: "become visible"

      document.visibilityState = "visible"
      document.hidden = false

      @dispatchVisibilitychangedEvent()

    becomeHiddenEvent = () =>
      steroids.debug
        msg: "document become hidden"

      document.visibilityState = "hidden"
      document.hidden = true

      @dispatchVisibilitychangedEvent()

    event = "focus"
    eventHandlerId = "#{event}_#{window.AG_WEBVIEW_UUID}"

    steroids.nativeBridge.nativeCall
      method: "addEventListener"
      parameters:
        event: event
        eventHandlerId: eventHandlerId
      successCallbacks: [focusAdded,callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
      recurringCallbacks: [becomeVisibleEvent]
