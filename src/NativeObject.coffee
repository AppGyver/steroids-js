# NativeObject description
class NativeObject

  constructor: ()->

  # Run passed recurringCallbacks on API call
  didOccur: (options, parameters) ->
    for callback in options.recurringCallbacks when callback?
      callback.call(@, parameters, options)

  # Run passed successCallbacks on API call
  didHappen: (options, parameters) ->
    for callback in options.successCallbacks when callback?
      callback.call(@, parameters, options)

  # Run passed failureCallbacks on API call
  didFail: (options)->
    for callback in options.failureCallbacks when callback?
      callback.call(@, parameters, options)

  # Call to native layer via native bridge
  nativeCall: (options) ->
    steroids.nativeBridge.send
      # options.method is the native API call name
      method: options.method
      # options.parameters is a parameters object for API call
      parameters: options.parameters
      # options.callbacks should have successCallbacks, recurringCallbacks and failureCallbacks function arrays
      callbacks:
        recurring: (parameters) => @didOccur(options, parameters)
        success: (parameters) => @didHappen(options, parameters)
        failure: (parameters) => @didFail(options, parameters)
