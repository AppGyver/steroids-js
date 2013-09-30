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

    @buttonCallbacks =
      right: []
      left: []

    params =
      right: []
      left: []

    if options.right?
      for button in options.right
        @buttonCallbacks.right.push(button.onTap ? ->)

        params.right.push {
          title: button.title
        }

    if options.left?
      for button in options.left
        @buttonCallbacks.left.push(button.onTap ? ->)

        params.left.push {
          title: button.title
        }


    steroids.nativeBridge.nativeCall
      method: "setNavigationBarButtons"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      recurringCallbacks: [@buttonTapped]
      failureCallbacks: [callbacks.onFailure]

  buttonTapped: (options)=>
    @buttonCallbacks[options.side][options.index]()
