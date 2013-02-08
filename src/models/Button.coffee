
class Button

  show: (options, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "showNavigationBarRightButton"
      parameters:
        title: options.title
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
      recurringCallbacks: [callbacks.onRecurring]
