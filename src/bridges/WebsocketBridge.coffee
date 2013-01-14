# Communication bridge that utilizes a websocket through the network layer
class WebsocketBridge extends Bridge
  constructor: ()->
    # Use reopen to open WebSocket
    @reopen()

  @isUsable: ()->
    true

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

  sendMessageToNative:(message)->
    # Ensure websocket is open before sending anything
    if @websocket.readyState is 0
      @websocket.addEventListener "open", ()=>
         @websocket.send message
    else
      @websocket.send message

  message_handler: (e)=>
    super(e.data)
