class PostMessage

  @postMessage: (message, targetOrigin) =>
    escapedJSONMessage = escape(JSON.stringify(message))

    steroids.nativeBridge.nativeCall
      method: "broadcastJavascript"
      parameters:
        javascript: "steroids.PostMessage.dispatchMessageEvent('#{escapedJSONMessage}', '*');"
      successCallbacks: []
      failureCallbacks: []
      recurringCallbacks: []



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
