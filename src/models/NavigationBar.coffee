class NavigationBar
  hide: (options={}, callbacks={}) ->
    steroids.nativeBridge.nativeCall
      method: "hideNavigationBar"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  show: (options={}, callbacks={}) ->
    steroids.debug "steroids.navigationBar.show options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"
    relativeTo = options.relativeTo ? steroids.app.path
    parameters = if options.constructor.name == "Object"
      if options.title?
        title: options.title
      else
        titleImagePath: relativeTo + options.titleImagePath
    else
      title: options

    steroids.nativeBridge.nativeCall
      method: "showNavigationBar"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  setButtons: (options={}, callbacks={}) ->
    steroids.debug "steroids.navigationBar.setButtons options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"
    if options.right? && options.right != []
      steroids.debug "steroids.navigationBar.setButtons showing right button title: #{options.right[0].title} callback: #{options.right[0].onTap}"
      steroids.nativeBridge.nativeCall
        method: "showNavigationBarRightButton"
        parameters:
          title: options.right[0].title
        successCallbacks: [callbacks.onSuccess]
        recurringCallbacks: [options.right[0].onTap]
        failureCallbacks: [callbacks.onFailure]
    else
      steroids.debug "steroids.navigationBar.setButtons hiding right button"
      steroids.nativeBridge.nativeCall
        method: "hideNavigationBarRightButton"
        parameters: {}
        successCallbacks: [callbacks.onSuccess]
        failureCallbacks: [callbacks.onFailure]
