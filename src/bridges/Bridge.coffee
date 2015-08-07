class Bridge
  # Unique identifier to make named callbacks unique
  uid: 0
  # Stored callbacks
  callbacks: {}

  @bestNativeBridge: null

  @getBestNativeBridge: ()->
    # Add new native bridges here
    prioritizedList =
    [
      FreshAndroidBridge
      ModuleBridge
      TizenBridge
      WebBridge
      AndroidBridge
      WebsocketBridge
      JSCoreBridge
    ]

    unless @bestNativeBridge?
      for bridgeClass in prioritizedList when not @bestNativeBridge?
        if bridgeClass.isUsable()
          @bestNativeBridge = new bridgeClass()

    return @bestNativeBridge

  constructor: ->

  sendMessageToNative: (options={})->
    throw "ERROR: Bridge#sendMessageToNative not overridden by subclass!"

  @isUsable: ()->
    throw "ERROR: Bridge.isUsable not overridden by subclass!"

  # Handles incoming API messages
  message_handler: (e)=>
    msg = JSON.parse(e)

    if msg?.callback?
      if @callbacks[msg.callback]?
        @callbacks[msg.callback].call(msg.parameters, msg.parameters)


  nativeCall: (options={}) =>
    @send
      # options.method is the native API call name
      method: options.method
      # options.parameters is a parameters object for API call
      parameters: options.parameters
      # options.callbacks should have successCallbacks, recurringCallbacks and failureCallbacks function arrays
      callbacks:
        recurring: (parameters) =>
          if options.recurringCallbacks?
            for callback in options.recurringCallbacks when callback?
              callback.call(@, parameters, options)
        success: (parameters) =>
          if options.successCallbacks?
            for callback in options.successCallbacks when callback?
              callback.call(@, parameters, options)
        failure: (parameters) =>
          if options.failureCallbacks?
            for callback in options.failureCallbacks when callback?
              callback.call(@, parameters, options)


  send: (options={})=>
    callbacks = @storeCallbacks(options)

    # Build the request object for native API
    request =
      method: options.method
      parameters: if options?.parameters? then options.parameters else {}
      callbacks: callbacks

    # Add context parameters
    request.parameters["view"] = window.top.AG_VIEW_ID
    request.parameters["screen"] = window.top.AG_SCREEN_ID
    request.parameters["layer"] = window.top.AG_LAYER_ID
    request.parameters["udid"] = window.top.AG_WEBVIEW_UDID

    #console.log(request)
    request = @parseMessage request
    @sendMessageToNative request

  #allow for the implementation to override and decide
  #to call stringify or not (iOS we pass as objects)
  parseMessage: (message={})->
    JSON.stringify(message)

  storeCallbacks: (options={})->
    return {} unless options?.callbacks?

    # human readable names for callbacks
    callback_prefix = "#{options.method}_#{@uid++}"
    callbacks = {}

    # Store the recurring callback
    if options.callbacks.recurring?
      callbacks.recurring = "#{callback_prefix}_recurring"
      @callbacks[callbacks.recurring] = (parameters)=>
        # Trigger callback
        options.callbacks.recurring.call(parameters, parameters)

    # Store the success callback
    if options.callbacks.success?
      callbacks.success = "#{callback_prefix}_success"
      @callbacks[callbacks.success] = (parameters)=>
        # Remove both callbacks on success (as they are no longer required)
        delete @callbacks[callbacks.success]
        delete @callbacks[callbacks.failure]
        # Trigger callback
        options.callbacks.success.call(parameters, parameters)

    # Store the failure callback
    if options.callbacks.failure?
      callbacks.failure = "#{callback_prefix}_fail"
      @callbacks[callbacks.failure] = (parameters)=>
        # Remove both callbacks on failure too (as they are no longer required)
        delete @callbacks[callbacks.success]
        delete @callbacks[callbacks.failure]
        # Trigger callback
        options.callbacks.failure.call(parameters, parameters)

    return callbacks
