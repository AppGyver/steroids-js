
class Modal

  show: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "openModal"
      parameters:
        url: options.layer.location
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  hide: (options={}, callbacks={})->
    steroids.nativeBridge.nativeCall
      method: "closeModal"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
