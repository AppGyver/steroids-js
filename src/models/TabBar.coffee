class TabBar
  
  hide: (options={}, callbacks={}) ->
    steroids.debug "steroids.tabBar.hide options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"
    
    steroids.nativeBridge.nativeCall
      method: "hideTabBar"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  show: (options={}, callbacks={}) ->
    steroids.debug "steroids.tabBar.show options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"

    steroids.nativeBridge.nativeCall
      method: "showTabBar"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
