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

    window.steroids.resetSteroidsEvent "websocketUsable"
    @websocket = null

    window.steroids.debug "websocket using dynamic port"
    @requestWebSocketPort @open

  open: (port) =>
    window.steroids.debug "websocket websocket open"
    @websocket = new WebSocket "ws://localhost:#{port}"
    @websocket.onmessage = @message_handler
    @websocket.onclose = @reopen
    @websocket.onopen = ()=>
      window.steroids.debug "websocket websocket opened"
      @map_context()
      @markWebsocketUsable()
    window.steroids.debug "websocket websocket opening"

  requestWebSocketPort: (callback)->
    window.steroids.debug "websocket request port"

    xmlhttp = new XMLHttpRequest()
    xmlhttp.onreadystatechange = ()=>
      if xmlhttp.readyState == XMLHttpRequest.DONE
        window.steroids.debug "websocket request port success: #{xmlhttp.responseText}"
        callback xmlhttp.responseText

    xmlhttp.open "GET","http://dolans.inetrnul.do.nut.cunnoct.localhost/"
    xmlhttp.send()
    window.steroids.debug "websocket requesting port"

  markWebsocketUsable: ()->
    window.steroids.debug "websocket open, marking usable"
    window.steroids.fireSteroidsEvent "websocketUsable"

  # Map current context so that native calls know where to send responses
  map_context: ()=>
    @send method: "mapWebSocketConnectionToContext"

    return @

  sendMessageToNative:(message)->
    # Ensure websocket is open before sending anything
    if @websocket?.readyState is WebSocket.OPEN
      @websocket.send message
    else
      window.steroids.on "websocketUsable", ()=>
        if @websocket?.readyState is WebSocket.OPEN
          # still ok!
          @websocket.send message
        else
          # retry later
          @sendMessageToNative message

  message_handler: (e)=>
    super(e.data)
