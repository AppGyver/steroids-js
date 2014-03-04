class Device

  torch: new Torch()
  platform:
    getName: (options={}, callbacks={}) ->
      name = if ( typeof AndroidAPIBridge != 'undefined' )
        "android"
      else if ( navigator.userAgent.indexOf("Tizen") != -1 )
        "tizen"
      else if ( navigator.userAgent.match(/(iPod|iPhone|iPad)/) )
        "ios"
      else
        undefined

      callbacks.onSuccess(name) if callbacks.onSuccess?

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

  disableSleep: (options={}, callbacks={}) =>
    options.disabled = true

    @setSleepDisabled(options, callbacks)

  enableSleep: (options={}, callbacks={}) =>
    options.disabled = false

    @setSleepDisabled(options, callbacks)

  setSleepDisabled: (options={}, callbacks={}) =>
    disabled = if options.constructor.name == "Boolean"
      options
    else
      options.disabled

    steroids.nativeBridge.nativeCall
      method: "setSleepDisabled"
      parameters:
        sleepDisabled: disabled
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
