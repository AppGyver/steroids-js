class NavigationBar
  hide: (options={}, callbacks={}) ->

    options.animated = options.animated?
    options.visible = false

    steroids.nativeBridge.nativeCall
      method: "setNavigationBarVisibility"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]


  show: (options={}, callbacks={}) ->
    steroids.debug "steroids.navigationBar.show options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"

    title = if options.constructor.name == "String"
      options
    else
      options.title

    if title or options.titleImagePath
      steroids.on "ready", ()=>
        relativeTo = options.relativeTo ? steroids.app.path

        parameters = if title
          title: title
        else
          titleImagePath: relativeTo + options.titleImagePath

        steroids.nativeBridge.nativeCall
          method: "showNavigationBar"
          parameters: parameters
          successCallbacks: [callbacks.onSuccess]
          failureCallbacks: [callbacks.onFailure]
    else
      steroids.nativeBridge.nativeCall
        method: "setNavigationBarVisibility"
        parameters:
          visible: true
          animated: options.animated?
        successCallbacks: [callbacks.onSuccess]
        failureCallbacks: [callbacks.onFailure]

  setButtons: (options={}, callbacks={}) ->
    steroids.debug "steroids.navigationBar.setButtons options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"
    steroids.on "ready", ()=>
      relativeTo = options.relativeTo ? steroids.app.path

      @buttonCallbacks = {}
      params =
        overrideBackButton: options.overrideBackButton
      buttonParametersFrom = (obj)->
        if obj.title?
          title: obj.title
        else
          imagePath: relativeTo + obj.imagePath


      if typeof AndroidAPIBridge is 'undefined' # no AndroidAPIBridge on iOS
        locations = ["right", "left"]

        for location in locations
          steroids.debug "steroids.navigationBar.setButtons constructing location #{location}"
          @buttonCallbacks[location] = []
          params[location] = []

          if options[location]?
            for button in options[location]
              buttonParameters = buttonParametersFrom(button)
              callback = button.onTap ? ->

              steroids.debug "steroids.navigationBar.setButtons adding button #{JSON.stringify(buttonParameters)} to location #{location}"
              @buttonCallbacks[location].push callback
              params[location].push buttonParameters

        steroids.nativeBridge.nativeCall
          method: "setNavigationBarButtons"
          parameters: params
          successCallbacks: [callbacks.onSuccess]
          recurringCallbacks: [@buttonTapped]
          failureCallbacks: [callbacks.onFailure]

      else # is android, using legacy
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

  buttonTapped: (options)=>
    @buttonCallbacks[options.location][options.index]()
