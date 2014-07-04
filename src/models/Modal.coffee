
class Modal extends EventsSupport

  constructor: ->
    #setup the events support
    super "modal", ["willshow", "didshow", "willclose", "didclose"]

  show: (options={}, callbacks={})->
    view = if options.constructor.name == "Object"
      options.view
    else
      options

    allowedRotations = if options.constructor.name == "Array"
      options
    else if options.constructor.name == "String"
      [options]
    else
      options.allowedRotations

    allowedRotations = {}
    if options.allowedRotations?
      allowedRotations = if options.allowedRotations.name == "Array"
        options.allowedRotations
      else
        [options.allowedRotations]

      #make sure we have orientation and not degrees
      allowedRotations = allowedRotations.map (value) -> 
        Screen.mapDegreesToOrientations value

    switch view.constructor.name
      when "PreviewFileView"
        steroids.nativeBridge.nativeCall
          method: "previewFile"
          parameters:
            filenameWithPath: view.getNativeFilePath()
          successCallbacks: [callbacks.onSuccess]
          failureCallbacks: [callbacks.onFailure]
      when "WebView"

        parameters = if view.id?
          { id: view.id }
        else
          { url: view.location }

        parameters.keepTransitionHelper = options.keepLoading

        parameters.disableAnimation = options.disableAnimation

        if options.navigationBar == true
              parameters.hidesNavigationBar = false
        else
          #default is modal without nav bar
          parameters.hidesNavigationBar = true

        steroids.nativeBridge.nativeCall
          method: "openModal"
          parameters: parameters
          successCallbacks: [callbacks.onSuccess]
          failureCallbacks: [callbacks.onFailure]
      else
        throw "Unsupported view sent to steroids.modal.show - #{view.constructor.name}"


  hide: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "closeModal"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  hideAll: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "closeAllModal"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
