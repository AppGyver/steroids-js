class NavigationBar extends EventsSupport

  constructor: ()->
    #setup the events support
    super "navigationBar", ["buttonTapped"], "webview"

  setStyleId: (options={}, callbacks={}) ->

    styleId = if options.constructor.name == "String"
      options
    else
      options.styleId

    steroids.nativeBridge.nativeCall
      method: "setNavigationBarStyleId"
      parameters:
        styleId: styleId
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  setStyleCSS: (options={}, callbacks={}) ->

    styleCSS = if options.constructor.name == "String"
      options
    else
      options.styleCSS

    steroids.nativeBridge.nativeCall
      method: "setNavigationBarStyleCSS"
      parameters:
        styleCSS: styleCSS
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  addStyleClass: (options={}, callbacks={}) ->

    styleClass = if options.constructor.name == "String"
      options
    else
      options.styleClass

    steroids.nativeBridge.nativeCall
      method: "addNavigationBarStyleClass"
      parameters:
        styleClass: styleClass
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  setStyleClass: (options={}, callbacks={}) ->

    styleClass = if options.constructor.name == "String"
      options
    else
      options.styleClass

    steroids.nativeBridge.nativeCall
      method: "setNavigationBarStyleClass"
      parameters:
        styleClass: styleClass
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  tapButton: (options={}, callbacks={}) ->
    steroids.nativeBridge.nativeCall
      method: "navigationBarTapButton"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

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
        btnParams = obj.toParams()
        if obj.imagePath?
          btnParams.imagePath = relativeTo + obj.imagePath
        return btnParams

      if typeof AndroidAPIBridge is 'undefined' # no AndroidAPIBridge on iOS

        for location in ["right", "left"]
          steroids.debug "steroids.navigationBar.setButtons constructing location #{location}"
          params[location] = []

          if options[location]?
            for button in options[location]
              buttonParameters = buttonParametersFrom(button)
              params[location].push buttonParameters

              steroids.debug "steroids.navigationBar.setButtons adding button #{JSON.stringify(buttonParameters)} to location #{location}"

              steroids.navigationBar.on "buttonTapped", (event) ->
                if event.button.id == button.id
                  callback = button.getCallback() ? ->
                  callback()

        steroids.nativeBridge.nativeCall
          method: "setNavigationBarButtons"
          parameters: params
          successCallbacks: [callbacks.onSuccess]
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

  setAppearance: do ->
    appearancePropertyNames = [
      'portraitBackgroundImage'
      'landscapeBackgroundImage'
      'tintColor'
      'titleTextColor'
      'titleShadowColor'
      'buttonTintColor'
      'buttonTitleTextColor'
      'buttonTitleShadowColor'
    ]
    camelcasedNavBarAppearancePropertyName = (appearancePropertyName) ->
      'navBar' + ucfirst appearancePropertyName
    ucfirst = (string) ->
      if string?.length > 0
        string.charAt(0).toUpperCase() + string.slice(1)
      else
        ""
    optionsToAppearanceParams = (options) ->
      appearance = {}
      for propertyName in appearancePropertyNames
        if options[propertyName]?
          appearance[camelcasedNavBarAppearancePropertyName propertyName] = options[propertyName]
      {
        appearance
      }

    (options = {}, callbacks = {}) ->
      steroids.debug "steroids.navigationBar.setAppearance options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"

      steroids.on "ready", ->
        steroids.nativeBridge.nativeCall
          method: "setAppearance"
          parameters: optionsToAppearanceParams options
          successCallbacks: [callbacks.onSuccess]
          failureCallbacks: [callbacks.onFailure]

  update: (options={}, callbacks={}) ->
    steroids.debug "steroids.navigationBar.update options: #{JSON.stringify options} callbacks: #{JSON.stringify callbacks}"
    steroids.on "ready", ()=>

      relativeTo = steroids.app.path
      params = {}

      if options.constructor.name == "String"
        params.title = options

      if options.title?
        params.title = options.title
        params.titleImagePath = ""

      params.border = options.border

      if options.titleImagePath?
        if not options.title?
          params.titleImagePath = relativeTo + options.titleImagePath
          params.title = ""

      if options.overrideBackButton?
        params.overrideBackButton = options.overrideBackButton

      if options.backButton?
        params.backButton = options.backButton.toParams()

      if options.buttons?
        for location in ["right", "left"]
          if options.buttons[location]?
            params.buttons ?= {}
            steroids.debug "steroids.navigationBar.update constructing location #{location}"
            params.buttons[location] = []

            for button in options.buttons[location]
              parameters = button.toParams()
              params.buttons[location].push parameters

              steroids.debug "steroids.navigationBar.update adding button #{JSON.stringify(parameters)} to location #{location}"

              steroids.navigationBar.on "buttonTapped", (tappedButton) ->
                if tappedButton.id == button.id
                  callback = button.getCallback() ? ->
                  callback()

      steroids.nativeBridge.nativeCall
        method: "updateNavigationBar"
        parameters: params
        successCallbacks: [callbacks.onSuccess]
        failureCallbacks: [callbacks.onFailure]

  getNativeState: (options={}, callbacks={}) ->
    steroids.nativeBridge.nativeCall
      method: "GetNavigationBarState"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
