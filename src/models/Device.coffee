class Device

  torch: new Torch()

  ping: (options={}, callbacks={}) =>
    steroids.nativeBridge.nativeCall
      method: "ping"
      parameters:
        payload: options.data
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  getIPAddress: (options={}, callbacks={}) =>
    steroids.nativeBridge.nativeCall
      method: "getIPAddress"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

