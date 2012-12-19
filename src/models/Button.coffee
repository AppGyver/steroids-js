# Button description

class Button extends NativeObject
  # Show button in navigation bar
  show: (options, callbacks={})->
    @nativeCall
      method: "showNavigationBarRightButton"
      parameters:
        title: options.title
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
      recurringCallbacks: [callbacks.onRecurring]
