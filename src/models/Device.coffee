class Device

  torch: new Torch()

  ping: (options={}, callbacks={}) =>
    data = if options.constructor.name == "String"
      options
    else
      options.data

    steroids.nativeBridge.nativeCall
      method: "ping"
      parameters:
        payload: data
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  getIPAddress: (options={}, callbacks={}) =>
    steroids.nativeBridge.nativeCall
      method: "getIPAddress"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

