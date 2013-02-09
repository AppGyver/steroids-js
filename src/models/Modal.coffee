
class Modal

  show: (options={}, callbacks={})->

    switch options.view.constructor.name
      when "PreviewFileView"
        steroids.nativeBridge.nativeCall
          method: "previewFile"
          parameters:
            filenameWithPath: options.view.file
          successCallbacks: [callbacks.onSuccess]
          failureCallbacks: [callbacks.onFailure]
      when "WebView"
        steroids.nativeBridge.nativeCall
          method: "openModal"
          parameters:
            url: options.view.location
          successCallbacks: [callbacks.onSuccess]
          failureCallbacks: [callbacks.onFailure]
      else
        throw "Unsupported view sent to steroids.modal.show"


  hide: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "closeModal"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
