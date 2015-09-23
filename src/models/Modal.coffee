
class Modal extends EventsSupport

  constructor: ->
    #setup the events support
    super "modal", ["willshow", "didshow", "willclose", "didclose"]

  show: (options={}, callbacks={})->
    view = if options.constructor.name == "Object"
      options.view
    else
      options

    allowedRotations = null
    if options.allowedRotations?
      allowedRotations = if options.allowedRotations.constructor.name == "Array"
        options.allowedRotations
      else
        [options.allowedRotations]

      #make sure we have orientation and not degrees
      allowedRotations = allowedRotations.map (value) ->
        Screen.mapDegreesToOrientations value

    switch view.constructor.name
      when "MediaGalleryView"
        steroids.nativeBridge.nativeCall
          method: "showMediaGallery"
          parameters:
            files: view.getNativeFilePath()
          successCallbacks: [callbacks.onSuccess]
          failureCallbacks: [callbacks.onFailure]

      when "PreviewFileView"
        steroids.nativeBridge.nativeCall
          method: "previewFile"
          parameters:
            filenameWithPath: view.getNativeFilePath()
          successCallbacks: [callbacks.onSuccess]
          failureCallbacks: [callbacks.onFailure]

      when "MapView", "WebView"

        parameters = if view.id?
          { id: view.id }
        else
          { url: view.location }

        parameters.keepTransitionHelper = options.keepLoading

        parameters.disableAnimation = options.disableAnimation

        parameters.waitTransitionEnd = options.waitTransitionEnd


        if options.animation?
          parameters.pushAnimation = options.animation.transition
          parameters.pushAnimationDuration = options.animation.duration
          parameters.popAnimation = options.animation.reversedTransition
          parameters.popAnimationDuration = options.animation.reversedDuration

          parameters.pushAnimationCurve = options.animation.curve
          parameters.popAnimationCurve = options.animation.reversedCurve

        if allowedRotations?
          parameters.allowedRotations = allowedRotations

        if options.navigationBar == true
              parameters.hidesNavigationBar = false
        else
          #default is modal without nav bar
          parameters.hidesNavigationBar = true

        # map view options
        if view.constructor.name == "MapView"
          parameters.map = view

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
