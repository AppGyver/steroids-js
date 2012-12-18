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
  hide: (callbacks={})->
    @nativeCall
      method: "closeModal"
      parameters: {}
      successCallbacks: []
      failureCallbacks: [callbacks.onFailure]
