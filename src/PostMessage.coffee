class PostMessage

  @originalPostMessage: do (win = window)->
    original = win.postMessage
    (args...)->
      if args.length and !args[1]?
        args[1] = "*"
      try
        original.apply win, args
      catch e
        console.log "Could not pass postMessage to original window.postMessage: #{e}", args[0]

  @postMessage: (message, targetOrigin) =>
    escapedJSONMessage = escape(JSON.stringify(message))

    steroids.nativeBridge.nativeCall
      method: "broadcastJavascript"
      parameters:
        javascript: "steroids.PostMessage.dispatchMessageEvent('#{escapedJSONMessage}', '*');"
      successCallbacks: []
      failureCallbacks: []
      recurringCallbacks: []

    @originalPostMessage message, targetOrigin



  @dispatchMessageEvent: (escapedJSONMessage, targetOrigin) =>
    #wrap in a setTimeout to garantee that runs in the webkit thread.
    setTimeout ->
      message = JSON.parse(unescape(escapedJSONMessage))

      e = document.createEvent "MessageEvent"

      #                  type       bubles etc    message    origin
      e.initMessageEvent "message", false, false, message, "", "", window, null

      window.dispatchEvent e
    ,
      1
