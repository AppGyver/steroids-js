class NavigationBar
  hide: (options={}, callbacks={}) ->
    steroids.nativeBridge.nativeCall
      method: "hideNavigationBar"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  show: (options={}, callbacks={}) ->
    steroids.debug "steroids.navigationBar.show options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"

    steroids.on "ready", ()=>
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

  update: (options={}, callbacks={}) ->
    steroids.debug "steroids.navigationBar.update options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"
    steroids.on "ready", ()=>

      relativeTo = steroids.app.path
      params = {}

      if options.overrideBackButton?
        params.overrideBackButton = options.overrideBackButton

      if options.constructor.name == "String"
        params.title = options
      else
        params.title = options.title

      if options.titleImagePath?
        params.titleImagePath = relativeTo + options.titleImagePath
      else
        params.titleImagePath = ""

      if options.buttons?
        params.buttons = {}

        @buttonCallbacks = {}
        buttonParametersFrom = (obj)->
          if obj.title?
            title: obj.title
          else
            imagePath: relativeTo + obj.imagePath

        locations = ["right", "left"]

        for location in locations
          steroids.debug "steroids.navigationBar.update constructing location #{location}"
          @buttonCallbacks[location] = []
          params.buttons[location] = []

          if options.buttons[location]?
            for button in options.buttons[location]
              buttonParameters = buttonParametersFrom(button)
              callback = button.onTap ? ->

              steroids.debug "steroids.navigationBar.update adding button #{JSON.stringify(buttonParameters)} to location #{location}"
              @buttonCallbacks[location].push callback
              params.buttons[location].push buttonParameters

      steroids.nativeBridge.nativeCall
        method: "updateNavigationBar"
        parameters: params
        successCallbacks: [callbacks.onSuccess]
        recurringCallbacks: [@buttonTapped]
        failureCallbacks: [callbacks.onFailure]




