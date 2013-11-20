class StatusBar
  
  hide: (options={}, callbacks={}) ->
    steroids.nativeBridge.nativeCall
      method: "hideStatusBar"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  show: (options={}, callbacks={}) ->
    steroids.debug "steroids.view.statusBar.show options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"

    parameters = if options.constructor.name == "Object"
      if options is "light"
        style: "light"
    else
      style: "default"

    steroids.nativeBridge.nativeCall
      method: "showStatusBar"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
      
      

