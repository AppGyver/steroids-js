# Native bridge is the communication layer from WebView to Native
class NativeBridge
  constructor: ()->
    # Use reopen to open WebSocket
    @reopen()

  # Unique identifier to make named callbacks unique
  uid: 0
  # Stored callbacks
  callbacks: {}

  # Open WebSocket connection to Native
  reopen: ()=>
    @websocket = new WebSocket "ws://localhost:31337"
    @websocket.onmessage = @message_handler
    @websocket.onclose = @reopen
    @websocket.addEventListener "open", @map_context
    @map_context()
    return false

  # Map current context so that native calls know where to send responses
  map_context: ()=>
    if window.top.AG_SCREEN_ID? and window.top.AG_LAYER_ID? and window.top.AG_VIEW_ID?
      @send "mapWebSocketConnectionToContext", { parameters: {screen: window.top.AG_SCREEN_ID, layer: window.top.AG_LAYER_ID, view: window.top.AG_VIEW_ID } }
    return @

  # Handles incoming API messages
  message_handler: (e)=>
    data = JSON.parse(e.data)

    if data?.callback?
      if @callbacks[data.callback]?
        @callbacks[data.callback].call(data.parameters, data.parameters)


  # Send client requests via websocket, this function takes care of callback returns (pass options.succcess & options.failure)
  send: (options)=>
    method = options.method

    # human readable names for callbacks
    if options?.callbacks?
      callback_name = "#{method}_#{@uid++}"
      callbacks = {}

      # Store the recurring callback
      if options.callbacks.recurring?
        callbacks.recurring = "#{callback_name}_recurring"
        @callbacks[callbacks.recurring] = (parameters)=>
          # Trigger callback
          options.callbacks.recurring.call(parameters, parameters)

      # Store the success callback
      if options.callbacks.success?
        callbacks.success = "#{callback_name}_success"
        @callbacks[callbacks.success] = (parameters)=>
          # Remove both callbacks on success (as they are no longer required)
          delete @callbacks[callbacks.success]
          delete @callbacks[callbacks.failure]
          # Trigger callback
          options.callbacks.success.call(parameters, parameters)

      # Store the failure callback
      if options.callbacks.failure?
        callbacks.failure = "#{callback_name}_fail"
        @callbacks[callbacks.failure] = (parameters)=>
          # Remove both callbacks on failure too (as they are no longer required)
          delete @callbacks[callbacks.success]
          delete @callbacks[callbacks.failure]
          # Trigger callback
          options.callbacks.failure.call(parameters, parameters)
    else
      callbacks = {}

    # Build the request object for native API
    request =
      method: method
      parameters: if options?.parameters? then options.parameters else {}
      callbacks: callbacks

    # Add context parameters
    request.parameters["view"] = window.top.AG_VIEW_ID
    request.parameters["screen"] = window.top.AG_SCREEN_ID
    request.parameters["layer"] = window.top.AG_LAYER_ID
    #console.log(request)
    # Ensure websocket is open before sending anything
    if @websocket.readyState is 0
      @websocket.addEventListener "open", ()=>
         @websocket.send JSON.stringify request
    else
      @websocket.send JSON.stringify request
