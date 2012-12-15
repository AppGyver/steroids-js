class NativeObject
  context: undefined

  # Communication endpoint to native API
  nativeBridge: new NativeBridge

  # Run passed successCallbacks on API call failure failure
  didHappen: (options, parameters) ->
    callback.call(@, parameters, options) for callback in options.successCallbacks

  # Run passed failureCallbacks on API call failure failure
  didFail: (options)->
    callback.call(@, parameters, options) for callback in options.failureCallbacks


  # Call to native layer via native bridge
  nativeCall: (options) ->
    @nativeBridge.send
      # options.method is the native API call name
      method: options.method
      # options.parameters is a parameters object for API call
      parameters: options.parameters
      # options.callbacks should have successCallbacks and failureCallbacks function arrays
      callbacks:
        recurring: (parameters) => @didHappen(options, parameters)
        success: (parameters) => @didHappen(options, parameters)
        failure: (parameters) => @didFail(options, parameters)