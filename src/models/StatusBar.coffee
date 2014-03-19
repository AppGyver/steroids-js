class StatusBar
  
  onTap: (options={}, callbacks={}) ->
    @onTap = options
    
    steroids.nativeBridge.nativeCall
      method: "setupStatusBarOnTap"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      recurringCallbacks: [@onTap]
      failureCallbacks: [callbacks.onFailure]
  
  hide: (options={}, callbacks={}) ->
    steroids.debug "steroids.statusBar.hide options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"
    
    steroids.nativeBridge.nativeCall
      method: "hideStatusBar"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  show: (options={}, callbacks={}) ->
    steroids.debug "steroids.statusBar.show options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"

    parameters = if options.constructor.name == "Object"
      style: options.style
    else
      style: options

    steroids.nativeBridge.nativeCall
      method: "showStatusBar"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
