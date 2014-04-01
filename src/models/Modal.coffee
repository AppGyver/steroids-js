
class Modal extends EventsSupport

  constructor: ->
    #setup the events support
    super "modal", ["willshow", "didshow", "willclose", "didclose"]

  show: (options={}, callbacks={})->
    view = if options.constructor.name == "Object"
      options.view
    else
      options

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
