class NavigationBar

  hide: (options={}, callbacks={}) =>
    steroids.nativeBridge.nativeCall
      method: "hideNavigationBar"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  show: (options={}, callbacks={}) =>
    steroids.nativeBridge.nativeCall
      method: "showNavigationBar"
      parameters:
        title: options.title
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
