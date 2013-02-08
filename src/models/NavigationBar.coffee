class NavigationBar extends NativeObject

  hide: (options={}, callbacks={}) =>
    @nativeCall
      method: "hideNavigationBar"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  show: (options={}, callbacks={}) =>
    @nativeCall
      method: "showNavigationBar"
      parameters:
        title: options.title
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
