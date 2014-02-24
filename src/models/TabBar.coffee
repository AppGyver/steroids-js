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

  selectTab: (options={}, callbacks={}) ->
    steroids.debug "steroids.tabBar.selectTab options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"

    @index = if options.constructor.name is "Number"
      options
    else
      options.index

    steroids.nativeBridge.nativeCall
      method: "selectTab"
      parameters:
        index: @index
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  update: (options={}, callbacks={}) ->
    steroids.debug "steroids.tabBar.update options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"

    if options.constructor.name == "Object"
      parameters = {}
      parameters.tabs = []
      for scale in [0...options.tabs.length]
        parameters.tabs.push(
          {
            title: options.tabs[scale].title
            image_path: options.tabs[scale].icon
            badge: options.tabs[scale].badge
          }
        )

    steroids.nativeBridge.nativeCall
      method: "updateTabs"
      parameters: parameters
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

