

class Events

  @dispatchVisibilitychangedEvent: (options={}) =>
    steroids.debug
      msg: "dispatched visibilitychanged"

    visibilityChangeCustomEvent = document.createEvent("CustomEvent")
    visibilityChangeCustomEvent.initCustomEvent("visibilitychange", true, true)

    document.dispatchEvent(visibilityChangeCustomEvent)

  @initializeVisibilityState: (options={}) =>
    steroids.debug
      msg: "set document.visibilityState to unloaded"

    document.visibilityState = "unloaded"
    document.hidden = "true"

    document.addEventListener "DOMContentLoaded", () =>
      steroids.debug
        msg: "got DOMContentLoaded, setting document.visibilityState to prerender"

      document.visibilityState = "prerender"

  @checkInitialVisibility: (options={}, callbacks={}) =>
    setVisibilityStatus = (event) ->
      document.hidden = (event.currentVisibility == "hidden")
      document.visibilityState = event.currentVisibility
      steroids.markComponentReady("Events.initialVisibility")

    steroids.nativeBridge.nativeCall
      method: "getCurrentVisibility"
      successCallbacks: [setVisibilityStatus, callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]


  @extend: (options={}, callbacks={}) ->
    @initializeVisibilityState()
    @checkInitialVisibility()

    focusAdded = () =>
      steroids.debug
        msg: "focus added"

      steroids.nativeBridge.nativeCall
        method: "addEventListener"
        parameters:
          event: "lostFocus"
        successCallbacks: [lostFocusAdded,callbacks.onSuccess]
        recurringCallbacks: [becomeHiddenEvent, callbacks.onFailure]

    lostFocusAdded = () =>
      steroids.debug
        msg: "lostfocus added"

      steroids.markComponentReady("Events.focuslisteners")

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


    steroids.nativeBridge.nativeCall
      method: "addEventListener"
      parameters:
        event: "focus"
      successCallbacks: [focusAdded,callbacks.onSuccess]
      recurringCallbacks: [becomeVisibleEvent, callbacks.onFailure]