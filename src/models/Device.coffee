class Device extends NativeObject

  torch: new Torch()

  ping: (options={}, callbacks={}) =>
    @nativeCall
      method: "ping"
      parameters:
        payload: options.data
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  getIPAddress: (options={}, callbacks={}) =>
    @nativeCall
      method: "getIPAddress"
      parameters: {}
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

