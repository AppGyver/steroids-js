class Events


  @extend: (element, callbacks={}) ->
    focusAdded = () =>
      steroids.markComponentReady("Events")

    dispatchVisibilitychangedEvent = () =>
      visibilityChangeCustomEvent = document.createEvent("CustomEvent")
      visibilityChangeCustomEvent.initCustomEvent("visibilitychange", true, true)

      element.dispatchEvent(visibilityChangeCustomEvent)

    steroids.nativeBridge.nativeCall
      method: "addEventListener"
      parameters:
        event: "focus"
      successCallbacks: [focusAdded,callbacks.onSuccess]
      recurringCallbacks: [dispatchVisibilitychangedEvent, callbacks.onFailure]