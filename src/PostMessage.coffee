class PostMessage

  @postMessage: (message, targetOrigin) =>

    callbacks = {}

    escapedJSONMessage = escape(JSON.stringify(message))

    steroids.nativeBridge.nativeCall
      method: "broadcastJavascript"
      parameters:
        javascript: "steroids.PostMessage.dispatchMessageEvent('#{escapedJSONMessage}', '*');"
      successCallbacks: [callbacks.onSuccess]
      recurringCallbacks: [callbacks.onFailure]



  @dispatchMessageEvent: (escapedJSONMessage, targetOrigin) =>
    message = JSON.parse(unescape(escapedJSONMessage))

    e = document.createEvent "MessageEvent"

    #                  type       bubles etc    message    origin
    e.initMessageEvent "message", false, false, message, "", "", window, null

    window.dispatchEvent e
