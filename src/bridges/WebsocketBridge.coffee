# Communication bridge that utilizes a websocket through the network layer
class WebsocketBridge extends Bridge
  constructor: ()->
    # Use reopen to open WebSocket
    @reopen()

  @isUsable: ()->
    true

  # Open WebSocket connection to Native
  reopen: ()=>
    window.steroids.debug "websocket reopen"
    @websocket = null
    # AG_CLIENT_VERSION was introduced in 2.3.3 and first supported semver is 2.3.4
    if window.AG_CLIENT_VERSION && window.AG_CLIENT_VERSION != "2.3.3"
      @requestWebSocketPort @open
    else
      @open "31337"

  open: (port) =>
    @websocket = new WebSocket "ws://localhost:#{port}"
    @websocket.onmessage = @message_handler
    @websocket.onclose = @reopen
    @websocket.onopen = ()=>
      window.steroids.debug "websocket websocket opened"
      @map_context()
      @markWebsocketUsable()
    window.steroids.debug "websocket websocket connecting"

  requestWebSocketPort: (callback)->
    window.steroids.debug "websocket request port"
    xmlhttp = new XMLHttpRequest()

    xmlhttp.onreadystatechange = ()=>
      if xmlhttp.readyState == 4
        window.steroids.debug "websocket request port success: #{xmlhttp.responseText}"
        callback xmlhttp.responseText

    xmlhttp.open "GET","http://dolans.inetrnul.do.nut.cunnoct.localhost/"
    xmlhttp.send()

  markWebsocketUsable: ()->
    window.steroids.debug "websocket open, marking usable"
    window.steroids.fireSteroidsEvent "websocketUsable"

  # Map current context so that native calls know where to send responses
  map_context: ()=>
    @send method: "mapWebSocketConnectionToContext"

    return @

  sendMessageToNative:(message)->
    # Ensure websocket is open before sending anything
    if @websocket?.readyState is 1
      @websocket.send message
    else
      window.steroids.on "websocketUsable", ()=>
        @websocket.send message

  message_handler: (e)=>
    super(e.data)
