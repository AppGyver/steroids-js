class Modal extends NativeObject
  # Show Modal
  show: (layer, callbacks={})->
    @nativeCall
      method: "openModal"
      parameters:
        url: layer.location
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  # Hide Modal
  hide: (options={}, callbacks={})->
    @nativeCall
      method: "closeModal"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
